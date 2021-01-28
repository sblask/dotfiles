_serverless_completion () {
local reply
local si=$IFS

IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" serverless completion -- "${words[@]}"))
IFS=$si

_describe 'values' reply
}
compdef _serverless_completion serverless
compdef _serverless_completion sls
