# Node version manager
export N_PREFIX="$HOME/.n"
if [ -d "$N_PREFIX/bin" ]; then
    PATH="$N_PREFIX/bin:$PATH"
fi

# Ruby version manager
if [ -d "$HOME/.rvm/bin" ]; then
    PATH="$HOME/.rvm/bin:$PATH"
fi
if [ -f "$HOME/.rvm/scripts/rvm" ]; then
    . "$HOME/.rvm/scripts/rvm"
fi

# Ruby gem environment
if [ -d "$HOME/.gem/ruby/2.6.0/bin" ]; then
    PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
fi
