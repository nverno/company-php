#!/usr/bin/env bash

# get resources:

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
pushd "$DIR">/dev/null

# files
files=()

# repos
declare -A repos=( 
    ["https://github.com/nverno/ac-php"]="ac"
    ["https://github.com/nverno/phpctags"]="phpctags"
    ["https://github.com/for-GET/know-your-http-well"]="headers"
    ["https://github.com/nverno/emacs-request"]="request"
)

# get files
get_resource_files () {
    for f in ${files[@]}; do
        if [[ ! -f $(basename $f) ]]; then
            wget $f
        fi
    done
}

# get / update resource repos
get_resource_repos () {
    for repo in "${!repos[@]}"; do
        if [[ ! -d "${repos["$repo"]}" ]]; then
            git clone --depth 1 "$repo" "${repos["$repo"]}"
        else
            pushd "${repos["$repo"]}">/dev/null
            git pull --depth 1
            popd>/dev/null
        fi
    done
}

# ------------------------------------------------------------
# get stuff

get_resource_repos

popd>/dev/null

# Local Variables:
# sh-shell: bash
# End:
