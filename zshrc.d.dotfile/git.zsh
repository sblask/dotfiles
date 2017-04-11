GIT_LOG_FORMAT='%C(blue)%h%Creset -%C(yellow)%d%Creset %s %C(blue)(%ai) %C(bold blue)<%an (%ae)>%Creset'
alias ga='git add'
alias gap='ga --patch'
alias gash='git stash --include-untracked --keep-index'
alias gashl='git stash list'
alias gashp='git stash pop'
alias gc='git commit'
alias gco='git checkout'
alias gdt='git difftool'
alias gdtc='gdt --cached'
alias gf='git fetch'
alias glog='git log --graph --decorate --pretty=format:$GIT_LOG_FORMAT --abbrev-commit --date=short --abbrev=8'
alias gl='glog'
alias glh='glog | head'
alias gla='glog --all'
alias glah='glog --all | head'
alias gld='glog --left-right --graph --cherry-mark'
alias gldo='glog --left-right --graph'
alias gm='git merge'
alias gmd='git merge --ff-only origin/develop'
alias gmm='git merge --ff-only origin/master'
alias gps='git push'
alias grb='git rebase'

function gd {
    git diff --color=always          $@
}
function gdc {
    git diff --color=always --cached $@
}
function gdh {
    git diff --color=always          $@ | head --lines 50
}

