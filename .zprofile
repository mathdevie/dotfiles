# Login shells (new terminal tabs): PATH only, everything else is in .zshrc

[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$HOME/.local/bin:$PATH"

# python.org Python before Homebrew's, since that's the one pip can install into
py=/Library/Frameworks/Python.framework/Versions/Current/bin
[ -d $py ] && export PATH="$py:$PATH"
unset py
