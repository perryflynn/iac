#!/usr/bin/env bash

set -u
set -e

rm -rf /opt/iac
git clone --branch ${IAC_REPO_BRANCH} https://${IAC_REPO_TOKEN:-}${IAC_REPO_TOKEN:+@}${IAC_REPO_URL} /opt/iac

chmod a+x /opt/iac/bootstrap.sh
/opt/iac/bootstrap.sh "$@"
