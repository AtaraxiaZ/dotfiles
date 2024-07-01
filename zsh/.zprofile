# software
# high priority
export PATH=/usr/local/MATLAB/R2021a/bin:$PATH
export PATH=$HOME/software/pycharm/bin:$PATH
export PATH=$HOME/anaconda3/bin:$PATH

# low priority
export PATH=$PATH:$HOME/opt/oss-cad-suite/bin

# bin file
export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/opt:$PATH

# >>> coursier install directory >>>
export PATH="$PATH:/home/zhe/.local/share/coursier/bin"
# <<< coursier install directory <<<

# MacOS brew
[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

