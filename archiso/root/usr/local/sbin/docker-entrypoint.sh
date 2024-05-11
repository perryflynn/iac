#!/usr/bin/env bash

set -e
set -u

if [ -n "${IAC_REPO_URL:-}" ]; then
    echo "Setting iac git repo url to '$IAC_REPO_URL'"
    echo "IAC_REPO_URL=$IAC_REPO_URL" >> bootstrapiso/airootfs/etc/environment
fi

if [ -n "${IAC_REPO_TOKEN:-}" ]; then
    echo "Setting iac git repo token"
    echo "IAC_REPO_TOKEN=$IAC_REPO_TOKEN" >> bootstrapiso/airootfs/etc/environment
fi

if [ -n "${IAC_REPO_BRANCH:-}" ]; then
    echo "Setting iac git repo branch to '$IAC_REPO_BRANCH'"
    echo "IAC_REPO_BRANCH=$IAC_REPO_BRANCH" >> bootstrapiso/airootfs/etc/environment
fi

if [ -n "${IAC_SSH_ROOT_KEY:-}" ]; then
    echo "Add ssh key to root account '$IAC_SSH_ROOT_KEY'"
    mkdir -p bootstrapiso/airootfs/root/.ssh
    echo "$IAC_SSH_ROOT_KEY" >> bootstrapiso/airootfs/root/.ssh/authorized_keys
fi

"$@"
