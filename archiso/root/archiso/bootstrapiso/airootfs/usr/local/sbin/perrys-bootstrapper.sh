#!/usr/bin/env bash

set -u
set -e

rm -rf /opt/iac
git clone --branch dev https://github.com/perryflynn/iac.git /opt/iac

chmod a+x /opt/iac/bootstrap.sh
/opt/iac/bootstrap.sh "$@"
