# ===== SSH AUTH =====

# Start ssh-agent if not running
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c)
end

# List of your SSH keys
set ssh_keys ~/.ssh/id_ed25519_github_auth ~/.ssh/id_ed25519_github_signing

# Add each key if it's not already loaded
for key in $ssh_keys
    ssh-add -l | grep (ssh-keygen -lf $key.pub | awk '{print $2}') > /dev/null 2>&1
    if test $status -ne 0
        ssh-add $key > /dev/null 2>&1
    end
end


# ===== Theme Modifications =====

set fish_greeting ""
set -gx TERM xterm-256color
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user no
set -g theme_hide_hostname no


# ===== Environment Variables =====
set -gx TMUX_CONF ~/.config/tmux/tmux.conf
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PYENV_ROOT "$HOME/.pyenv"
set -gx PNPM_HOME "$HOME/Library/pnpm"

# ===== PATH Modifications =====
fish_add_path "$BUN_INSTALL/bin"
fish_add_path "$PNPM_HOME"
fish_add_path "$PYENV_ROOT/bin"

# ===== Aliases =====
# File operations
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"
alias lh="eza -dl .* --group-directories-first --icons"
alias ll="eza -al --group-directories-first --icons"
alias lt="eza -al --sort=modified --icons"
alias c="clear"
alias e="exit"
alias cat="bat"
alias tree="tree -L 3 -a -I '.git' --charset X"

# Git
alias gcl="git clone"
alias ggpull="git pull origin"
alias ga="git add"
alias gaa="git add ."
alias gaaa="git add --all"
alias gau="git add --update"
alias gb="git branch"
alias gbd="git branch --delete"
alias gc="git commit"
alias gcm="git commit --message"
alias gcf="git commit --fixup"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcom="git checkout master"
alias gcos="git checkout staging"
alias gcod="git checkout develop"
alias gd="git diff"
alias gda="git diff HEAD"
alias gi="git init"
alias glg="git log --graph --oneline --decorate --all"
alias gld="git log --pretty=format:'%h %ad %s' --date=short --all"
alias gm="git merge --no-ff"
alias gma="git merge --abort"
alias gmc="git merge --continue"
alias gp="git pull"
alias gpo="git pull origin"
alias gpuo="git push origin"
alias gpr="git pull --rebase"
alias gr="git rebase"
alias gss="git status --short"
alias gst="git stash"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gsts="git stash save"
alias gs="git status"
alias gc1='git config user.name "Krish Makhijani" && git config user.email "git@krishm.dev"'

# Package managers
alias pi="pnpm install"
alias ps="pnpm start"
alias prd="pnpm run dev"
alias pr="pnpm run"
alias px="pnpx"
alias bs="bun start"
alias ns="npm start"
alias nrd="npm run dev"
alias brd="bun run dev"
alias nr="npm run"
alias br="bun run"
alias nil="npm install --legacy-peer-deps"

# Docker
alias dps="docker ps"
alias de="docker exec -it"

# Tmux
alias tmux="tmux -f $TMUX_CONF"
alias tns="tmux new -s"
alias td="tmux detach"
alias tls="tmux ls"
alias ta="tmux attach -t"

# Custom
alias appx="open https://app.100xdevs.com/courses"
alias zg="z github"
alias sourcefish="source ~/.config/fish/config.fish"

# ===== FZF Configuration =====
set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"
set -gx FZF_DEFAULT_OPTS "--height 50% --layout=default --border --color=hl:#2dd4bf"
set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always -n --line-range :500 {}'"
set -gx FZF_ALT_C_OPTS "--preview 'eza --icons=always --tree --color=always {} | head -200'"
set -gx FZF_TMUX_OPTS " -p90%,70%"

# ===== Tool Initializations =====
# Pyenv
if command -v pyenv >/dev/null
    pyenv init - | source
end

# Zoxide (replacement for z)
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# FZF key bindings
if command -v fzf >/dev/null
    fzf --fish | source
end

