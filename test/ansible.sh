#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )


ansible-playbook ${SCRIPT_DIRECTORY}/../ansible-test.yml
