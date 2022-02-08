#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

PLAYBOOK=${SCRIPT_DIRECTORY}/../ansible/ansible-test.yml

TARGET_DIRECTORY=/tmp/dotfiles-ansible-test

mkdir ${TARGET_DIRECTORY}

export ASDF_DATA_DIR=${TARGET_DIRECTORY}/.asdf/

ansible-playbook --extra-vars target_directory=${TARGET_DIRECTORY} "${PLAYBOOK}"
ansible-playbook --extra-vars target_directory=${TARGET_DIRECTORY} "${PLAYBOOK}" | tee ansible_result

if grep --quiet 'changed=0.*failed=0' ansible_result
then
  echo 'Idempotence test: pass'
  exit 0
else
  echo 'Idempotence test: fail'
  exit 1
fi
