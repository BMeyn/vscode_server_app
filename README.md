# Create a vscode server app with Azure container apps
----
This repository contains the source code for the [Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/) sample application. The application is a vscode server that can be accessed via a web browser.

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [Docker](https://docs.docker.com/get-docker/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Azure Account Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account)

## Create a container app

### 1. Clone the repository

```bash
git clone
```

### 2. Edit .env file and set the following variables

```
# The name of the container app
RESOURCE_GROUP="<Resource Group Name>" (e.g. rg-codeserver-app)
REGION="<REGION>" (e.g. westeurope)
APP_NAME="<APP NAME>" (e.g. codeserver-app)
APP_PLAN_NAME="APP PLAN NAME" (e.g. codeserver-plan)
CONFIG_FILE="codeserver.yml"
DOCKER_IMAGE_NAME="DOCKER IMAGE NAME" (e.g. codeserver)
DOCKER_IMAGE_REPOSITORY="REPOSITORY" (e.g. bmeyn)
``` 

### 3. Build the docker image

```bash 
make build
```

### 4. Test the docker image locally
This will start a container locally. You can then open the vscode server in a browser

```bash
make test
```

### 4. Push the docker image to the docker registry
In this example the docker image is pushed to docker hub. You can also push the image to a private registry.

```bash
make push
```

### 5. Use the makefile to login to Azure and create a container app
In this step you will need to sign in to Azure and create a container app. 
The makefile will use the variables set in the .env file. A new resource group will be created if it does not exist and a new container app will be created.

```bash
make login
make deploy
``` 

### 6. Open vscode in the browser

When the container app is deployed, you can open the vscode server in a browser. The url is printed in the terminal.

```
Access the code-server:
open https://$(APP_NAME).azurewebsites.net
```
----
## Happy coding! ;) :tada: