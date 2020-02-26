#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

for file in $SCRIPT_DIRECTORY/test_files/*.sh
do
    . $file
done

echo "SUCCESS"
