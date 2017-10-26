fun! ConfigurePythonCheckers()
    let l:flake8Config = findfile('setup.cfg', '.;')
    if l:flake8Config !=? ''
        let b:syntastic_checkers = ['pylint', 'flake8']
        let b:syntastic_python_flake8_args = '--config ' . fnamemodify(l:flake8Config, ':p')
    else
        let b:syntastic_checkers = ['pylint', 'pycodestyle']
        let b:syntastic_python_pycodestyle_args = '--ignore E501'
    endif

    let l:pylintConfig = findfile('.pylintrc', '.;')
    if l:pylintConfig !=? ''
        let b:syntastic_python_pylint_args = '--rcfile ' . fnamemodify(l:pylintConfig, ':p')
    endif
endf

fun! SetScssConfig()
    let l:scssConfig = findfile('.scss-lint.yml', '.;')
    if l:scssConfig !=? ''
        let b:syntastic_scss_scss_lint_args = '--config ' . fnamemodify(l:scssConfig, ':p')
    endif
endf

fun! SetEslintCheckers()
    let l:localEslint = findfile('node_modules/.bin/eslint', '.;')
    if l:localEslint !=? ''
        let b:syntastic_javascript_eslint_exec = fnamemodify(l:localEslint, ':p')
    endif
endf

augroup filetype
    autocmd!
    autocmd FileType apache     setlocal commentstring=#\ %s
    autocmd FileType css        :call SuperTabSetDefaultCompletionType("<c-p>")
    autocmd FileType javascript :call SetEslintCheckers() | call SuperTabSetDefaultCompletionType("<c-p>")
    autocmd FileType scss       :call SetScssConfig()
    autocmd FileType python     :call ConfigurePythonCheckers()
augroup END

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    sys.path.insert(0, os.environ['VIRTUAL_ENV'])
    sys.path.insert(0, os.getcwd())
    activate_this = os.path.join(os.environ['VIRTUAL_ENV'], 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif
