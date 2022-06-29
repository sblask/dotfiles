alias av='deactivate 2>/dev/null; aws-vault'
alias cal='echo -n "       Week "; week;ncal -wC'
alias cf='clone_fetch'
alias conda='micromamba'
alias cs='clone_status'
alias diff='colordiff'
alias extensionUpdateVersion='version=$(jq --raw-output .version manifest.json) && vared -p "Current version is ${version}, specify new version: " version && jq --indent 4 ".version = \"$version\"" manifest.json | sponge manifest.json && jq --indent 4 ".version = \"$version\"" package.json | sponge package.json'
alias less='less -K'
alias psgrep='ps aufx | grep'
alias psless='ps aufx | vimpager'
alias pss='ps aufx'
alias untar='tar -xzf'
alias week='date +%W'
# allow vim instead of less
alias vimpager="nvim -c 'set tabstop=4 nomodified nomodifiable nolist nowrap' -c 'AnsiEsc' -"
# use nvim instead of vi/vim
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d -c "windo set nofoldenable"'
# apt-get
alias aptgrep='dpkg -l | grep'
alias autoremove='sudo apt-get autoremove --purge'
alias aptstall='sudo apt-get install'
alias policy='apt-cache policy'
alias uninstall='sudo apt-get purge'
# virtualenvwrapper stuff
alias on='workon'
alias off="deactivate"
# task
alias ta='task add'
alias td='task delete'
alias tl='task list'
alias tm='task minimal'
# Terraform
alias tera='terraform apply plan'
alias teri='terraform init'
alias termv='terraform state mv'
alias terp='terraform plan -out plan'
# top
alias top='top -c'
alias topcpu='top -b -n1 | tail -n +8 | sort -n -r -k 9'
alias tophead='top -b -n1 | head -n 5'
alias topmem='top -b -n1 | tail -n +8 | sort -n -r -k 10'
alias virtualenv3='python3 -m venv'
alias virtualenv37='python3.7 -m venv'

if command -v fdfind &> /dev/null
then
    alias fd=fdfind
fi
