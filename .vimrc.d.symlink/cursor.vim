if has('nvim')
    set guicursor=
    set guicursor+=n-v-c:block-Cursor/lCursor-blinkwait0-blinkoff150-blinkon150,
    set guicursor+=ve:ver35-Cursor-blinkwait0-blinkoff150-blinkon150,
    set guicursor+=o:hor50-Cursor-blinkwait0-blinkoff150-blinkon150,
    set guicursor+=i-ci:ver25-Cursor/lCursor-blinkwait0-blinkoff150-blinkon150,
    set guicursor+=r-cr:hor40-Cursor/lCursor-blinkwait0-blinkoff150-blinkon150,
    set guicursor+=sm:block-Cursor-blinkwait0-blinkoff150-blinkon150,
else
    let &t_SI = "\x1b[\x35 q" " bar
    let &t_EI = "\x1b[\x31 q" " block
    let &t_SR = "\x1b[\x33 q" " underline

    if !exists("cursor_autocommands_loaded")
        let cursor_autocommands_loaded = 1
        " make sure we are always start with block
        autocmd FocusGained * redraw | silent !echo -ne "\x1b[\x31 q"
        autocmd VimEnter    * redraw | silent !echo -ne "\x1b[\x31 q"
    endif
endif
