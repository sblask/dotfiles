" enable mouse, but disable drag (in all modes and command mode)
set mouse=a
noremap <LeftDrag> <LeftMouse>
noremap! <LeftDrag> <LeftMouse>

" no paste with middle click
map <MiddleMouse> <LeftMouse>
map! <MiddleMouse> <LeftMouse>
map <2-MiddleMouse> <LeftMouse>
map! <2-MiddleMouse> <LeftMouse>
map <3-MiddleMouse> <LeftMouse>
map! <3-MiddleMouse> <LeftMouse>

" support wide displays
if !has('nvim')
    try
        set ttymouse=sgr
    catch
        set ttymouse=xterm2
    endtry
endif
