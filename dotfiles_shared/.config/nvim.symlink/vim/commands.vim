if has('python3')
    py3file ~/.config/nvim/vim/commands.py
endif

function! RunWithErrorHandling(command) abort
  let view = winsaveview()
  let errorOutputFile = tempname()

  " fake change so undo does not jump to top of file
  normal! ix
  normal! "_x

  let shellredir_save = &shellredir
  let &shellredir = '>%s 2>' . errorOutputFile
  silent execute a:command
  let &shellredir = shellredir_save

  if v:shell_error != 0
    silent undo
    for error in readfile(errorOutputFile)
        echoerr error
    endfor
  endif

  call delete(errorOutputFile)
  call winrestview(view)
endfunction

command! JsonFormat       call RunWithErrorHandling('% ! json-format')
command! JsonFormatSorted call RunWithErrorHandling('% ! json-format --sorted')
command! JsonToDict       call RunWithErrorHandling('% ! python -c "import json; import sys; as_dict = json.load(sys.stdin); print(as_dict)"')
command! PrettyDict       call RunWithErrorHandling('% ! python -c "import pprint; import sys; as_dict = eval(sys.stdin); pprint.pprint(as_dict)"')
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

command! ReloadConfig source $MYVIMRC
command! SudoWrite w !sudo tee % > /dev/null
command! Todo Gcd | Ack! "TODO|FIXME"
command! WindowsToLinux :%s/$//


function! JumpInList(count, isLocationList, isBackward) abort
    if ! QuickFixCurrentNumber#Next(a:count, a:isLocationList, a:isBackward) && ! QuickFixCurrentNumber#Border(a:count, a:isLocationList, a:isBackward)
        if ingo#err#IsSet()
            call ingo#msg#ErrorMsg(ingo#err#Get())
        else
            call ingo#msg#WarningMsg('Nothing in list')
        endif
    endif
endfunction

nnoremap <silent> ]q :<C-u>call JumpInList(v:count1, 0, 0)<CR>
nnoremap <silent> [q :<C-u>call JumpInList(v:count1, 0, 1)<CR>
nnoremap <silent> ]l :<C-u>call JumpInList(v:count1, 1, 0)<CR>
nnoremap <silent> [l :<C-u>call JumpInList(v:count1, 1, 1)<CR>
