NODE_VERSION="12.18.3"

# INSTALL NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm --version

# INSTALL NODEJS
nvm install ${NODE_VERSION}
nvm use ${NODE_VERSION}
node -v

# INSTALL GH-OPENAPI-DOCS
npm install -g @redocly/openapi-cli && npm install -g redoc-cli
npm install -g @ga4gh/gh-openapi-docs

# RUN GH-OPENAPI-DOCS
gh-openapi-docs

echo "GH OPENAPI DOCS DONE RUNNING"
git branch
git remote -v
git checkout master
git fetch
git checkout -b gh-pages
git branch --set-upstream-to=origin/gh-pages

git branch
git status
ls
