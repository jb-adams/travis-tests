NODE_VERSION="12.18.3"

echo -e "Start of Script"

# INSTALL AND LOAD NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
echo -e "Has NVM been installed/loaded?"
nvm
nvm --version

echo -e "Version of Node:"
nvm install ${NODE_VERSION}
nvm use ${NODE_VERSION}
node -v
echo -e "Version of NPM:"
npm -v
# npm install -g @redocly/openapi-cli && npm install -g redoc-cli
# npm install -g @ga4gh/gh-openapi-docs
# gh-openapi-docs
echo -e "End of Script"