GIT_LOG_FORMAT='%C(blue) %h%Creset %C(yellow)%d%Creset %s %C(blue)(%ai) %C(bold blue)<%an (%ae)>%Creset'
alias glog='git log --graph --decorate --pretty=format:$GIT_LOG_FORMAT --abbrev-commit --date=short --abbrev=8'

alias ga='git add'
alias gap='git add --patch'
alias gash='git stash --include-untracked --keep-index'
alias gashl='git stash list'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdsbs='vimdiff <(git diff | grep --invert-match --regexp "^+[^+]") <(git diff | grep --invert-match --regexp "^-[^-]")'
alias gdsbsc='vimdiff <(git diff --cached | grep --invert-match --regexp "^+[^+]") <(git diff --cached | grep --invert-match --regexp "^-[^-]")'
alias gdt='git difftool'
alias gdtc='git difftool --cached'
alias gf='git fetch'
alias gfp='git fetch --prune'
alias gl='glog'
alias gla='glog --all'
alias gld='glog --left-right --graph --cherry-mark'
alias gldo='glog --left-right --graph'
alias gm='git merge --no-ff'
alias gmd='git merge --ff-only origin/develop'
alias gmm='git merge --ff-only origin/master'
alias gmt='git mergetool'
alias gps='git push'
alias gpsd='git push --delete origin'
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grst='git reset'
alias grsth='git reset --hard'
alias gt='git tag'
alias gvh='git show HEAD'
