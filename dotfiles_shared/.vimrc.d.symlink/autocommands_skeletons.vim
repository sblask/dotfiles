augroup skeletons
    autocmd!
    autocmd BufNewFile setup.py                                      0read ~/.skeletons/setup.py      | normal Gdd
    autocmd BufNewFile *.html                                        0read ~/.skeletons/skeleton.html | normal Gdd
    autocmd BufNewFile *.py     if expand('<afile>') != 'setup.py' | 0read ~/.skeletons/skeleton.py   | normal Gdd | endif
    autocmd BufNewFile *.sh                                          0read ~/.skeletons/skeleton.sh   | normal Gdd
augroup END
