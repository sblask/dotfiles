#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )


GLOBIGNORE=.venv
for file_path in */**/test_*.py; do
    pushd $(dirname $file_path)
    python -m unittest discover
    popd
done
