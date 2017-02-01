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

" scroll 5 lines up or down
noremap <ScrollWheelUp> 5k
noremap <ScrollWheelDown> 5j

" support wide displays
try
    set ttymouse=sgr
catch
    set ttymouse=xterm2
endtry
