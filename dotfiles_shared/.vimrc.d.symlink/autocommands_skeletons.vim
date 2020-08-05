augroup skeletons
    autocmd!
    autocmd BufNewFile setup.py                                      0r ~/.skeletons/setup.py      | $d
    autocmd BufNewFile *.html                                        0r ~/.skeletons/skeleton.html | $d
    autocmd BufNewFile *.py     if expand('<afile>') != 'setup.py' | 0r ~/.skeletons/skeleton.py   | $d | endif
    autocmd BufNewFile *.sh                                          0r ~/.skeletons/skeleton.sh   | $d
augroup END
