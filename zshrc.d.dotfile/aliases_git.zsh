GIT_LOG_FORMAT='%C(blue)%h%Creset -%C(yellow)%d%Creset %s %C(blue)(%ai) %C(bold blue)<%an (%ae)>%Creset'
alias ga='git add'
alias gap='ga --patch'
alias gdt='git difftool'
alias gdtc='gdt --cached'
alias gl='git log --graph --decorate --pretty=format:$GIT_LOG_FORMAT --abbrev-commit --date=short --abbrev=8'
alias glh='gl | head'
alias gla='gl --all | vimpager'
alias glah='gl --all | head'
alias gld='gl --left-right --graph --cherry-mark'
alias gldo='gl --left-right --graph'
alias gmd='git merge --ff-only origin/develop'
alias gmm='git merge --ff-only origin/master'
