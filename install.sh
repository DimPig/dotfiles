#!/bin/bash

# ---- Install apt packages ----
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch

sudo apt update

sudo apt install -y \
	bat \
	fzf \
	git-delta \
	zoxide \
	ripgrep \
	eza \
	fd-find \
	fastfetch \

# ---- Correcting bat binary ----
mkdir -p $HOME/.local/bin
ln -s /usr/bin/batcat $HOME/.local/bin/bat

# ---- Correcting fd binary ----
ln -s /usr/bin/fdfind $HOME/.local/bin/fd

# ---- Install TPM and clone plugins ----
if [[ ! -d $HOME/.tmux ]]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
  echo "[INFO] tpm is already installed";
fi

# ---- Install oh-my-zsh ----
if [[ ! -d $HOME/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "[INFO] oh-my-zsh is already installed";
fi

# ---- oh-my-zsh plugins ----
download_oh_my_zsh_plugin () {
    repo_name=$1
    github_user="${2:-zsh-users}"

    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$repo_name" ]]; then
        git clone "https://github.com/$github_user/$repo_name" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$repo_name"
    fi
}

download_oh_my_zsh_plugin fzf-tab Aloxaf

# ---- oh-my-zsh themes ----
download_oh_my_zsh_theme () {
    repo_name=$1
    github_user="${2:-zsh-users}"

    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/$repo_name" ]]; then
        git clone "https://github.com/$github_user/$repo_name" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/$repo_name"
    fi
}

download_oh_my_zsh_theme powerlevel10k romkatv

/bin/zsh ./sources/pokemon-colorscripts/install.sh
