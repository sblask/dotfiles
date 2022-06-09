if has('python3')
    py3file ~/.config/nvim/vim/commands.py
endif

function! RunWithErrorHandling(command) abort
  let view = winsaveview()
  let errorOutputFile = tempname()

  let shellredir_save = &shellredir
  let &shellredir = '>%s 2>' . errorOutputFile
  silent execute a:command
  let &shellredir = shellredir_save

  if v:shell_error != 0
    silent undo
    echo join(readfile(errorOutputFile), "\n")
  endif

  call delete(errorOutputFile)
  call winrestview(view)
endfunction

command! JsonFormat       call RunWithErrorHandling('% ! json-format')
command! JsonFormatSorted call RunWithErrorHandling('% ! json-format --sorted')
command! JsonToDict       call RunWithErrorHandling('% ! python -c "import json; import sys; as_dict = json.load(sys.stdin); print(as_dict)"')
command! PackerFmt        call RunWithErrorHandling('% ! packer fmt -no-color -')
command! PrettyDict       call RunWithErrorHandling('% ! python -c "import pprint; import sys; as_dict = eval(sys.stdin); pprint.pprint(as_dict)"')
command! TerraformFmt     call RunWithErrorHandling('% ! terraform fmt -no-color -')
command! YamlFormat       call RunWithErrorHandling('% ! python -c "import yaml; import sys; as_dict = yaml.load(sys.stdin); print(yaml.dump(as_dict, default_flow_style=False))"')
command! YamlToDict       call RunWithErrorHandling('% ! python -c "import yaml; import sys; as_dict = yaml.load(sys.stdin); print(as_dict)"')

command! -range Sort <line1>,<line2>!sort
command! -range SortCommaSeparated <line1>,<line2>python3 apply_on_one_line_selection(sort_comma_separated)
command! -range SortWhitespaceSeparated <line1>,<line2>python3 apply_on_one_line_selection(sort_whitespace_separated)

command! Base64Decode % python3 base64_decode()
command! Base64Encode % python3 base64_encode()
command! DictToJson   % python3 dict_to_json()

command! FoldDisable         set nofoldenable | set foldcolumn=0
command! FoldEnable          set foldenable   | set foldcolumn=3
command! IgnoreWhitespaceOff set diffopt-=iwhite
command! IgnoreWhitespaceOn  set diffopt+=iwhite
command! RelativeNumber      set relativenumber!

command! SudoWrite w !sudo tee % > /dev/null
command! Todo Gcd | Ack! "TODO|FIXME"
command! WindowsToLinux :%s/$//

command! Cnext try | cnext | catch /E553/ | cfirst | catch /E42/ | echohl WarningMsg | echo "Nothing in quickfix-list" | echohl None | endtry
command! Cprev try | cprev | catch /E553/ | clast | catch /E42/ | echohl WarningMsg | echo "Nothing in quickfix-list" | echohl None | endtry
nmap [q :Cprev<CR>
nmap ]q :Cnext<CR>

command! Lnext try | lnext | catch /E553/ | lfirst | catch /E42/ | echohl WarningMsg | echo "Nothing in location-list" | echohl None | endtry
command! Lprev try | lprev | catch /E553/ | llast | catch /E42/ | echohl WarningMsg | echo "Nothing in location-list" | echohl None | endtry
nmap [l :Lprev<CR>
nmap ]l :Lnext<CR>
