include .env
export

login:
	az login

build:
	@echo "Building Docker Image"
	docker build -t $(DOCKER_IMAGE_TAG)/$(DOCKER_IMAGE_NAME) .

test:
	@echo "Testing Docker Image"
	docker-compose down
	docker-compose up

push:
	@echo "Pushing Docker Image to Docker Hub"
	docker push $(DOCKER_IMAGE_TAG)/$(DOCKER_IMAGE_NAME):latest

deploy:
	@echo "Deploying to Azure"
	@echo "Resource Group: $(RESOURCE_GROUP)"
	az group create --name $(RESOURCE_GROUP) --location $(REGION)

	@echo "Create App Service Plan: $(APP_PLAN_NAME)"
	az appservice plan create \
		--name $(APP_PLAN_NAME) \
		--resource-group $(RESOURCE_GROUP) \
		--sku S1 --is-linux
		

	@echo "Create Web App for Container: $(APP_NAME)"
	az webapp create \
		--resource-group $(RESOURCE_GROUP) \
		--plan $(APP_PLAN_NAME) \
		--name $(APP_NAME) \
		--multicontainer-config-type compose \
		--multicontainer-config-file $(CONFIG_FILE)
	
	@echo "Add App Setting"
	az webapp config appsettings set \
		--resource-group $(RESOURCE_GROUP) \
		--name $(APP_NAME) \
		--settings WEBSITES_ENABLE_APP_SERVICE_STORAGE=TRUE

	@echo "Done!!"
	@echo ""
	@echo "Access the code-server:"
	@echo "open https://$(APP_NAME).azurewebsites.net"
	@echo ""

clean:
	@echo "Cleaning up - Delete Resource group: $(RESOURCE_GROUP)"
	az group delete --name $(RESOURCE_GROUP) --yes