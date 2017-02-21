nmap <Leader>f <Plug>(easymotion-bd-w)
" make vim-surround shortcuts consistent
xmap s         <Plug>VSurround
" start interactive aligning on Enter
vmap <Enter>   <Plug>(LiveEasyAlign)
" camel case motions
map  <silent>   w <Plug>CamelCaseMotion_w
map  <silent>   b <Plug>CamelCaseMotion_b
map  <silent>   e <Plug>CamelCaseMotion_e
map  <silent>  ge <Plug>CamelCaseMotion_ge
omap <silent>  iw <Plug>CamelCaseMotion_iw
xmap <silent>  iw <Plug>CamelCaseMotion_iw
