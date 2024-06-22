#!/bin/bash

# This script runs all checks across the entire project.

# Checks if a dependency is installed on a system.
function checkDependency {
  local depName="$1"
  if hash "$depName"; then
    return 0
  else
    echo "ERROR: dependency not installed '$depName'"
    return 1
  fi
}

# Installs Docker and dependencies
# Docker is installed through python, we install python & pip first, then docker.
# Last, we add current user to the 'docker' group to enable sudo-less docker.
function installDocker {
  if [ "$(uname)" == "Darwin" ]; then
    echo "Follow these steps to install docker: https://store.docker.com/editions/community/docker-ce-desktop-mac"
    exit 1
  fi
  echo "Installing python and pip, a dependency of docker"
  if hash yum; then
    set -x
    sudo yum update -y
    sudo yum install -y python3 python3-pip
    set +x
  else
    set -x
    sudo apt install -y python3 python3-pip
    set +x
  fi
  echo "Installing Docker (with pip)"
  set -x
  pip3 install docker docker-compose
  set +x

  echo "Adding current user: $USER to group: 'docker' (allows sudo-less docker)."
  echo "Log back in for these changes to take effect."
  groups | grep -q "docker" || sudo usermod -a -G docker "$USER"
}

scriptDir="$(dirname $0)"
set -o pipefail
set -eu

checkDependency "docker" || installDocker
"$scriptDir/gradlew" spotlessApply check $@
"$scriptDir/.build/code-convention-checks/check-custom-style"
