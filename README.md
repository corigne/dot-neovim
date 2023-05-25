# dot-neovim
My Neovim configurations ported to LUA.  
A combination of my own configs and the lsp/autocompletion features  
from the ["neovim-from-scratch"](https://github.com/LunarVim/Neovim-from-scratch) series by chris@machine.  

## What it looks like and does:
- Colors: Ships with tokyonight-night as the default colorscheme, but also installs everforest, darkula, and ayu.
- Statusbar: [lualine](https://github.com/nvim-lualine/lualine.nvim)
- Nerdfont friendly filetree: [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- tmux motion compatibility (requires some tmux config, see link): [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- Fuzzy Finder and more: [Telescope](https://github.com/nvim-telescope/telescope.nvim)
![image](https://github.com/corigne/dot-neovim/assets/7695563/4b067d35-2207-44a8-93ac-667db79771c1)

## Requirements:
- [git](https://www.youtube.com/watch?v=l60MnDJklnM)
- [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) - (version 0.7.0 or greater)
- [Packer](https://github.com/wbthomason/packer.nvim) - For plugin management.
- [lua-language-server](https://github.com/LuaLS/lua-language-server):  
  - Necessary, as the [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer) is archived  
   and doesn't have the updated LSP download link for lua-ls.
- I think that's it, **create an issue** if something isn't working out of the box.

## Install:
1. Clone this repo directly into your neovim config directory (usually ~/.config/nvim/ works):  
  i. `git clone git@github.com:corigne/dot-neovim.git ~/.config/nvim`  
  or  
  ii. `https://github.com/corigne/dot-neovim.git ~/.config/nvim`  
2. Run `nvim +PackerInstall +qa` to install all associated plugins. If everything works this may take some time.  
3. Start neovim ( Just run: `nvim` ) and you should be prepared to program in *most* commons languages.  
  i. (Except Java; we don't serve your kind here.)

## Filemap:  
```
├─ init.lua : the base config file, kicks off with neovim  
├─ README.md : this readme  
└─ /lua/ : the lua folder standard for neovim lua modules  
    ├─ /settings/ : houses the sub-config scripts  
    ├─ cmp.lsp : autocomplete settings  
    ├─ core.lua : core settings, things like tab size and colorscheme  
    ├─ keymap.lua : the keybindings I made or ported (LSP keybinds are in handlers.lua)  
    ├─ plugins.lua : the plugin section for Packer and some of the required configurations  
    └─ /lsp/ : houses the LSP configs, adapted from the 2022 "neovim-from-scratch" series metioned above  
       ├─ handlers.lua : the function and keymap definitions passed as args forthe lsp servers  
       ├─ init.lua : kicks off the lsp module  
       └─ lsp-installer.lua : sets up lsp-config and passes in the options
```

## Adding additional LSP Servers:
1. Install the LSP server of your choice using either `:LspInstall` or by manually installing.
2. Add the setup command for the server to `/lua/settings/lsp/lsp-installer.lua` similarly to how the currently configured ones are added there.
