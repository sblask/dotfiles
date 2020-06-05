#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

PLAYBOOK=${SCRIPT_DIRECTORY}/../ansible/ansible-test.yml

ansible-playbook --verbose --verbose --verbose --extra-vars target_directory=/tmp/dotfiles-ansible-test ${PLAYBOOK}
ansible-playbook --verbose --verbose --verbose --extra-vars target_directory=/tmp/dotfiles-ansible-test ${PLAYBOOK} > ansible_result

cat ansible_result | grep --quiet 'changed=0.*failed=0' \
  && (echo 'Idempotence test: pass' && exit 0) \
  || (echo 'Idempotence test: fail' && cat ansible_result && exit 1) \

