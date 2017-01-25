# NodeJS
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Ruby
if [ -f $HOME/.rvm/scripts/rvm ]; then
    . $HOME/.rvm/scripts/rvm
fi
export PATH=$HOME/.rvm/bin:$PATH

# Python
# use the right python/virtualenv
export PATH=$HOME/opt/virtualenv/bin:$PATH
if [ -f ~/opt/virtualenv/bin/virtualenvwrapper.sh ]; then
    . ~/opt/virtualenv/bin/virtualenvwrapper.sh
fi
