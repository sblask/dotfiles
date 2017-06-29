fun! ConfigurePythonCheckers()
    let flake8Config = findfile('setup.cfg', '.;')
    if flake8Config != ''
        let b:syntastic_checkers = ['pylint', 'flake8']
        let b:syntastic_python_flake8_args = '--config ' . fnamemodify(flake8Config, ':p')
    else
        let b:syntastic_checkers = ['pylint', 'pycodestyle']
        let b:syntastic_python_pycodestyle_args = '--ignore E501'
    endif

    let pylintConfig = findfile('.pylintrc', '.;')
    if pylintConfig != ''
        let b:syntastic_python_pylint_args = '--rcfile ' . fnamemodify(pylintConfig, ':p')
    endif
endf

fun! SetScssConfig()
    let scssConfig = findfile('.scss-lint.yml', '.;')
    if scssConfig != ''
        let b:syntastic_scss_scss_lint_args = '--config ' . fnamemodify(scssConfig, ':p')
    endif
endf

fun! SetJavascriptCheckers()
    let localEslint = findfile('node_modules/.bin/eslint', '.;')
    if localEslint != ""
        let b:syntastic_javascript_eslint_exec = fnamemodify(localEslint, ':p')
    endif

    let localJscs = findfile('node_modules/.bin/jscs', '.;')
    if localJscs != ""
        let b:syntastic_javascript_jscs_exec = fnamemodify(localJscs, ':p')
    endif
endf

if !exists("language_autocommands_loaded")
    let language_autocommands_loaded = 1
    autocmd FileType apache     setlocal commentstring=#\ %s
    autocmd FileType css        :call SuperTabSetDefaultCompletionType("<c-p>")
    autocmd FileType javascript :call SetJavascriptCheckers() | call SuperTabSetDefaultCompletionType("<c-p>")
    autocmd FileType scss       :call SetScssConfig()
    autocmd FileType python     :call ConfigurePythonCheckers() | setlocal completeopt-=preview
endif

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
