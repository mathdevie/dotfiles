# Login shells only (new terminal tabs, `zsh -l`). Runs after .zshenv and
# before .zshrc. Keep this to PATH setup; interactive config goes in .zshrc.

# Homebrew: PATH, MANPATH, HOMEBREW_* vars
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# User-level CLIs (claude, codex, cursor-agent, ...)
export PATH="$HOME/.local/bin:$PATH"

# python.org framework install (takes priority over Homebrew's python3)
py_framework="/Library/Frameworks/Python.framework/Versions/3.14/bin"
[ -d "$py_framework" ] && export PATH="$py_framework:$PATH"
unset py_framework

# JetBrains Toolbox launchers (webstorm, pycharm, ...)
jb_scripts="$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
[ -d "$jb_scripts" ] && export PATH="$PATH:$jb_scripts"
unset jb_scripts
