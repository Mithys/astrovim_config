# Mithy's AstroVim Config

1. Clone AstroNvim (normal installation instructions)

```sh
git clone https://github.com/kabinspace/AstroNvim ~/.config/nvim
```

2. Clone your empty new repository to your `~/.config/nvim/lua` folder

```sh
git clone https://github.com/mithys/astrovim_config.git ~/.config/nvim/lua/user
```

3. Initialize AstroVim

```sh
nvim  --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
