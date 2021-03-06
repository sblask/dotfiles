fun! ConfigureApache()
    setlocal commentstring=#\ %s
endf

fun! ConfigureClojure()
    call SuperTabSetDefaultCompletionType('<c-x><c-o>')
    RainbowParentheses
    nmap <buffer> <Leader>d ]<C-D>
endf

fun! ConfigureCss()
    call SuperTabSetDefaultCompletionType('<c-p>')
endf

fun! ConfigureJavascript()
    let l:localEslint = findfile('node_modules/.bin/eslint', '.;')
    if l:localEslint !=? ''
        let b:syntastic_javascript_eslint_exec = fnamemodify(l:localEslint, ':p')
    endif
    call SuperTabSetDefaultCompletionType('<c-n>')
endf

fun! ConfigureJson()
    let b:ale_fix_on_save = 1
endf

fun! ConfigurePython()
    " see https://github.com/w0rp/ale/blob/master/doc/ale-python.txt
    let l:config = findfile('.pylintrc', '.;')
    if l:config !=? ''
        let l:config_path = fnamemodify(l:config, ':p')
        let b:ale_python_pylint_options = '--rcfile ' . l:config_path
        let b:ale_python_black_options = '--line-length 79'
        if match(readfile(l:config_path), 'max-line-length') != -1
            " default for ignore is E121,E123,E126,E226,E24,E704,W503,W504
            let b:ale_python_pycodestyle_options = '--ignore=E121,E123,E126,E203,E226,E24,E704,W503,W504 --max-line-length=999'
        endif
    endif
    set diffopt-=iwhite
endf

fun! ConfigureScss()
    let l:scssConfig = findfile('.scss-lint.yml', '.;')
    if l:scssConfig !=? ''
        let b:syntastic_scss_scss_lint_args = '--config ' . fnamemodify(l:scssConfig, ':p')
    endif
endf

fun! ConfigureYaml()
    let l:config = findfile('.yamllint', '.;')
    if l:config !=? ''
        let b:ale_yaml_yamllint_options = '--config-file ' . fnamemodify(l:config, ':p')
    endif
endf

augroup programming_language_support
    autocmd!

    autocmd FileType apache     :call ConfigureApache()
    autocmd FileType clojure    :call ConfigureClojure()
    autocmd FileType css        :call ConfigureCss()
    autocmd FileType javascript :call ConfigureJavascript()
    autocmd FileType json       :call ConfigureJson()
    autocmd FileType python     :call ConfigurePython()
    autocmd FileType scss       :call ConfigureScss()
    autocmd FileType yaml       :call ConfigureYaml()

augroup END

if has('python3')
    python3 import os; import sys; sys.path.insert(0, os.getcwd())
endif
