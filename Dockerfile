FROM --platform=linux/amd64 codercom/code-server:latest

COPY .config/code-server/config.yaml /home/coder/.config/code-server/config.yaml

# install extensions
RUN code-server --install-extension ms-python.python; \
    code-server --install-extension msjsdiag.debugger-for-chrome; \
    code-server --install-extension vscodevim.vim; \
    code-server --install-extension esbenp.prettier-vscode; \
    code-server --install-extension chenxsan.vscode-standardjs; \
    code-server --list-extensions;

# install python for debian
RUN sudo apt-get update && sudo apt-get install -y python3 python3-pip