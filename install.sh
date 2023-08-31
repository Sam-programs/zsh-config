sudo pacman -S gzip unzip tar bzip2 unrar pulseaudio\
	  github-cli git\
     exa neovim gdb\
	  zsh-syntax-highlighting zsh-autosuggestions\
     --needed


mkdir -p ~/.config/zsh/
cp ~/.config/zsh/.zshrc ~/.config/zsh/.zshrc.bak -f
cp .zshrc ~/.config/zsh/.zshrc -f

cp .zshalias ~/.config/zsh/.zshalias -f
cp .zshgit  ~/.config/zsh/.zshgit -f
cp .zshutils ~/.config/zsh/.zshutils -f
cp empty ~/.config/zsh/.zshconfig -f

mv  ~/.zshrc ~/.zshrc.bak
ln -sf ~/.config/zsh/.zshrc ~/.zshrc -f
