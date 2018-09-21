command -nargs=? Outline VoomToggle <args>
command -range WordSort <line1>,<line2>!python -c "import sys; key, value = sys.stdin.read().split('='); print '='.join([key, ','.join(sorted(value.split(',')))])"
command DictToJson % !python -c "from dateutil.tz import tzlocal; from dateutil.tz import tzutc; import datetime; import json; import sys; asDict = eval(sys.stdin.read()); asJson = json.dumps(asDict, default=lambda something: something.isoformat()); print(asJson)"
command FoldEnable set foldenable | set foldcolumn=3
command FoldDisable set nofoldenable | set foldcolumn=0
command IgnoreWhitespace set diffopt+=iwhite
command JsonFormat % !json-format
command JsonFormatSorted % !json-format --sorted
command RelativeNumber set relativenumber!
command SudoWrite w !sudo tee % > /dev/null
command SESNotificationClean % !python -c "import json; import sys; blob = sys.stdin.read(); blob = blob.replace('\n ', ''); print json.loads(blob)['content'].replace('=\r\n', '').replace('=3D', '=').replace('&amp;', '&');"
command Todo Gcd | Ack! "TODO|FIXME"
command W w
command WindowsToLinux :%s/$//
command Wrap windo set wrap
command Q q
