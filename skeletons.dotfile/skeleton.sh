#!/bin/bash

set -x -o errexit -o nounset -o pipefail

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )
