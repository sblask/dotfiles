#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

diff <(add-index ls_list_in) <(cat ls_list_out)
diff <(add-index --print-files ls_list_plus_files_in) <(cat ls_list_plus_files_out)
echo "SUCCESS"
