if has('python3')
    py3file ~/.vimrc.d/commands.py
endif

command! -nargs=? Outline VoomToggle <args>
command! -range Sort <line1>,<line2>!sort
command! -range SortCommaSeparated <line1>,<line2>python3 apply_on_one_line_selection(sort_comma_separated)
command! -range SortWhitespaceSeparated <line1>,<line2>python3 apply_on_one_line_selection(sort_whitespace_separated)

command! Base64Decode % python3 base64_decode()
command! Base64Encode % python3 base64_encode()
command! DictToJson % python3 dict_to_json()
command! FoldDisable set nofoldenable | set foldcolumn=0
command! FoldEnable set foldenable | set foldcolumn=3
command! IgnoreWhitespace set diffopt+=iwhite
command! JsonFormat % !json-format
command! JsonFormatSorted % !json-format --sorted
command! JsonToDict % !python -c "import json; import sys; asDict = json.load(sys.stdin); print(asDict)"
command! JsonToPrettyDict % !python -c "import json; import pprint; import sys; asDict = json.load(sys.stdin); pprint.pprint(asDict)"
command! JsonToPrettyDictNewlines % !python -c "import json; import pprint; import sys; asDict = json.load(sys.stdin); print(pprint.pformat(asDict, indent=4).replace('{   ', '{\n').replace('[   ', '[\n').replace('}', '\n}').replace(']', '\n]').replace('\n', ',\n').replace(',,', ',').replace('[,', '[').replace('{,', '{'))"
command! PackerFmt let b:view = winsaveview() | execute ':%! packer fmt -' | call winrestview(b:view)
command! Q q
command! RelativeNumber set relativenumber!
command! SESNotificationClean % !python -c "import json; import sys; blob = sys.stdin.read(); parseable = blob.strip().split('}\n')[0].replace('\n', ''); content = json.loads(parseable)['content']; print(content.replace('=\r\n', '').replace('=3D', '=').replace('&amp;', '&').replace('\r\n', '\n'));"
command! SudoWrite w !sudo tee % > /dev/null
command! Todo Gcd | Ack! "TODO|FIXME"
command! UnIgnoreWhitespace set diffopt-=iwhite
command! W w
command! WindowsToLinux :%s/$//
command! Wrap windo set wrap
command! YamlFormat % !python -c "import yaml; import sys; asDict = yaml.load(sys.stdin); print(yaml.dump(asDict, default_flow_style=False))"
command! YamlToDict % !python -c "import yaml; import sys; asDict = yaml.load(sys.stdin); print(asDict)"

command! Cnext try | cnext | catch /E553/ | cfirst | catch /E42/ | echohl WarningMsg | echo "Nothing in quickfix-list" | echohl None | endtry
command! Cprev try | cprev | catch /E553/ | clast | catch /E42/ | echohl WarningMsg | echo "Nothing in quickfix-list" | echohl None | endtry
nmap [q :Cprev<CR>
nmap ]q :Cnext<CR>

command! Lnext try | lnext | catch /E553/ | lfirst | catch /E42/ | echohl WarningMsg | echo "Nothing in location-list" | echohl None | endtry
command! Lprev try | lprev | catch /E553/ | llast | catch /E42/ | echohl WarningMsg | echo "Nothing in location-list" | echohl None | endtry
nmap [l :Lprev<CR>
nmap ]l :Lnext<CR>
