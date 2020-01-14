#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

declare -r SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )
