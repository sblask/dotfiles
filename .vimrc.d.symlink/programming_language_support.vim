fun! ConfigureJavascript()
    let l:localEslint = findfile('node_modules/.bin/eslint', '.;')
    if l:localEslint !=? ''
        let b:syntastic_javascript_eslint_exec = fnamemodify(l:localEslint, ':p')
    endif
endf

fun! ConfigureScss()
    let l:scssConfig = findfile('.scss-lint.yml', '.;')
    if l:scssConfig !=? ''
        let b:syntastic_scss_scss_lint_args = '--config ' . fnamemodify(l:scssConfig, ':p')
    endif
endf

fun! ConfigurePython()
    " see https://github.com/w0rp/ale/blob/master/doc/ale-python.txt
    let l:config = findfile('.pylintrc', '.;')
    if l:config !=? ''
        let b:ale_python_pylint_options = '--rcfile ' . fnamemodify(l:config, ':p')
        let b:ale_python_pycodestyle_options = '--ignore=E501,W504'
    endif
endf

fun! ConfigureYaml()
    let l:config = findfile('.yamllint', '.;')
    if l:config !=? ''
        let b:ale_yaml_yamllint_options = '--config-file ' . fnamemodify(l:config, ':p')
    endif
endf

augroup filetype
    autocmd!
    autocmd FileType apache     setlocal commentstring=#\ %s
    autocmd FileType css        :call SuperTabSetDefaultCompletionType("<c-p>")
    autocmd FileType javascript :call ConfigureJavascript() | call SuperTabSetDefaultCompletionType("<c-p>")
    autocmd FileType scss       :call ConfigureScss()
    autocmd FileType python     :call ConfigurePython()
    autocmd FileType yaml       :call ConfigureYaml()
augroup END

if has('python3')
    python3 import os; import sys; sys.path.insert(0, os.getcwd())
else
    python import os; import sys; sys.path.insert(0, os.getcwd())
endif
