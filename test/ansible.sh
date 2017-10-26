#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

PLAYBOOK=${SCRIPT_DIRECTORY}/../ansible/ansible-test.yml

ansible-playbook --extra-vars target_directory=/tmp/dotfiles-ansible-test ${PLAYBOOK}

ansible-playbook --extra-vars target_directory=/tmp/dotfiles-ansible-test ${PLAYBOOK} \
  |   grep --quiet 'changed=0.*failed=0' \
  && (echo 'Idempotence test: pass' && exit 0) \
  || (echo 'Idempotence test: fail' && exit 1) \

