#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

find "$SCRIPT_DIRECTORY/.." -name 'test_*.py' -not -path '*/.venv/*' -not -path '*/plugged/*' -exec dirname {} \; \
    | sort --unique \
    | xargs -I _ sh -c "cd \$0 && pwd && python -m unittest discover" _
