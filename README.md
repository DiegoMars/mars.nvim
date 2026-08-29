# How to install
## External Dependencies
* Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
* [ripgrep](https://github.com/BurntSushi/ripgrep#installation), [fd-find](https://github.com/sharkdp/fd#installation)
* Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
* A [Nerd Font](https://www.nerdfonts.com): optional, provides various icons
    * if you have it set `vim.g.have_nerd_font` in `init.lua` to true
* Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
* `Treesitter cli`
* Language Setup:
    * If you want to write Typescript, you need `npm`
    * If you want to write Golang, you will need `go`
    * etc.
**Install recipies**
<details>
  <summary>Windows with gcc/make using chocolatey</summary>

  Alternatively, one can install gcc and make which don't require changing the config, the easiest way is to use choco:
  1. install chocolatey either follow the instructions on the page or use winget, run in cmd as admin:
  ```
    winget install --accept-source-agreements chocolatey.chocolatey
  ```

  2. install all requirements using choco, exit the previous cmd and open a new one so that choco path is set, and run in cmd as admin:
  ```
    choco install -y neovim git ripgrep wget fd unzip gzip mingw make tree-sitter
  ```

</details>
<details>
  <summary> Ubuntu Install Steps </summary>

  ```
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install make gcc ripgrep unzip git xclip neovim tree-sitter-cli
  ```

</details>
<details>
  <summary> Debian Install Steps </summary>

  ```
    sudo apt update
    sudo apt install make gcc ripgrep unzip git xclip curl tree-sitter-cli

    # Now we install nvim
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo mkdir -p /opt/nvim-linux-x86_64
    sudo chmod a+rX /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

    # make it available in /usr/local/bin, distro installs to /usr/bin
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
  ```

</details>
<details>
  <summary> Fedora Install Steps </summary>

  ```
    sudo dnf install -y gcc make git ripgrep fd-find unzip neovim tree-sitter-cli
  ```

</details>
<details>
  <summary> Arch Install Steps </summary>

  ```
    sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim tree-sitter-cli
  ```

</details>

## Install mars.nvim

* Windows Powershell
```
    # For HTTPS
    git clone https://github.com/Diegomars/mars.nvim.git "${env:LOCALAPPDATA}\nvim"

    # For SSH
    git clone git@github.com:DiegoMars/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

* Linux and Mac
```
    # For HTTPS
    git clone https://github.com/Diegomars/mars.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

    # For SSH
    git clone git@github.com:DiegoMars/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```
