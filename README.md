## GMT Site Builder
Utility to build the GMT Jekyll site from data pulled from Github repositories

    Usage: build-gmt-site [opts] <gmt site repo path>
        -o, --organization-name ORGNAME  Organization name to use on GitHub
        -t, --github-oauth-token TOKEN   OAuth token for GitHub access. Falls back on TGI_GITHUB_OAUTH_TOKEN environment variable
        -v [REPO1,REPO2],                Validate config for GitHub repos and exit
            --validate-repo-config
        -h, --help                       Display this screen
