for file in ~/.config/zsh/plugins/**/*.plugin.zsh; do
    source "$file"
done

# set color scheme
base16_eighties

# configure git syntax highlighting plugin
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf*' 'fg=black,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('\|' 'fg=yellow')
ZSH_HIGHLIGHT_PATTERNS+=('\*' 'fg=black,bg=red')

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]-%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND_AHEAD_SEPARATOR="$fg[red]/"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[red]+%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{ ✔%G%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]%}%{ +%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[green]%}%{ ~%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}%{ …%G%}"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[magenta]%}%{ ⚑%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{X%G%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
