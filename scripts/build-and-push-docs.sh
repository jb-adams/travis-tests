

function install_nvm {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm --version
}

function install_node {
    NODE_VERSION="12.18.3"
    nvm install ${NODE_VERSION}
    nvm use ${NODE_VERSION}
    node -v
}

function install_gh_openapi_docs {
    npm install -g @redocly/openapi-cli && npm install -g redoc-cli
    npm install -g @ga4gh/gh-openapi-docs
}

function setup_github_bot {
    git config user.name $GH_NAME
    git config user.email $GH_EMAIL
    git config credential.helper "store --file=.git/credentials"
    echo "https://${GH_TOKEN}:x-oauth-basic@github.com" > .git/credentials
}

function cleanup_github_bot {
  rm .git/credentials
}

function setup_github_branch {
    git checkout -b gh-pages
    git branch --set-upstream-to=origin/gh-pages
    git config pull.rebase false
    git stash save --include-untracked
    git pull
    git stash pop 0
}

function commit_gh_openapi_docs_outputs {
    git add preview
    git add docs
    git add openapi.json
    git add openapi.yaml
    git commit -m "added docs from gh-openapi-docs"
}

function main {
    install_nvm
    install_node
    install_gh_openapi_docs
    gh-openapi-docs
    setup_github_bot
    setup_github_branch
    commit_gh_openapi_docs_outputs
    git push
    cleanup_github_bot
}

main
exit 0
