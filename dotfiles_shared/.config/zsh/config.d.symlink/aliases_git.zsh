GIT_LOG_FORMAT='%C(blue) %h%Creset %C(yellow)%d%Creset %s %C(blue)(%ai) %C(bold blue)<%an (%ae)>%Creset'
alias glog='git log --graph --decorate --pretty=format:$GIT_LOG_FORMAT --abbrev-commit --date=short --abbrev=8'

alias ga='git add'
alias gap='git add --patch'
alias gash='git stash --include-untracked --keep-index'
alias gashl='git stash list'
alias gc='git commit'
alias gcd='cd (../)#.git(:a:h)'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdsbs='vimdiff <(git diff | grep --invert-match --regexp "^+[^+]") <(git diff | grep --invert-match --regexp "^-[^-]")'
alias gdsbsc='vimdiff <(git diff --cached | grep --invert-match --regexp "^+[^+]") <(git diff --cached | grep --invert-match --regexp "^-[^-]")'
alias gdt='git difftool'
alias gdtc='git difftool --cached'
alias gdtf='vim -c Gvdiffsplit' # use Fugitive
alias gf='git fetch'
alias gfp='git fetch --prune'
alias gfpd='git fetch --prune origin develop:develop'
alias gfpm='git fetch --prune origin master:master'
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
alias gurl='git remote -v | grep origin | head -n 1 | awk "{ print \$2 }" | sed -E "s|[^@]+@([^:]+):[0-9]*(.+)\.git|https://\1/\2|"'
alias gurlo='gurl | xargs open'
alias gvh='git show HEAD'
