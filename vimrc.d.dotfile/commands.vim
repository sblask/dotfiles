command -nargs=? Outline VoomToggle <args>
command -range WordSort <line1>,<line2>!python -c "import sys; key, value = sys.stdin.read().split('='); print '='.join([key, ','.join(sorted(value.split(',')))])" 
command FoldEnable set foldenable | set foldcolumn=3
command FoldDisable set nofoldenable | set foldcolumn=0
command IgnoreWhitespace set diffopt+=iwhite
command JsonFormat % !json-format
command JsonFormatSorted % !json-format --sorted
command RelativeNumber set relativenumber!
command SudoWrite w !sudo tee % > /dev/null
command SESNotificationClean % !python -c "import json; import sys; blob = sys.stdin.read(); print json.loads(blob.replace('\n', ''))['content'].replace('=\r\n', '').replace('=3D', '=').replace('&amp;', '&');"
command W w
command Wrap windo set wrap
command Q q
