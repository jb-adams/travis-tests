NODE_VERSION="12.18.3"

function setup_github_account {
    git config user.name $GH_NAME
    git config user.email $GH_EMAIL
    git config credential.helper "store --file=.git/credentials"
    echo "https://${GH_TOKEN}:x-oauth-basic@github.com" > .git/credentials
}

function cleanup {
  rm .git/credentials
}

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

# PULL GH-PAGES BRANCH TO LOCAL
setup_github_account
git checkout -b gh-pages
git branch --set-upstream-to=origin/gh-pages
git config pull.rebase false
git pull

# COMMIT GH-OPENAPI-DOCS OUTPUTS 
git add preview
git add docs
git add openapi.json
git add openapi.yaml
git commit -m "gh-pages commit"

# PUSH GH-OPENAPI-DOCS OUTPUTS
git push

cleanup

exit 0
