# NVIMIS  

Nvim configs ported from my old vimscript configs to lua, with some
additions inspired and borrowed from lunarvim and nvchad.  

Note: This is a personal work-in-progress. It works, but it has some quirks that
I am actively working out and will push to this repository. If there are keybind
related issues or other issues unrelated to the plugins themselves, please create
an issue ticket and I will happily look into handling it.  

Enjoy!

## Useful Features

- Workflow:
- 1. LSP, Linter, and Debugger installer: [Mason](github.com/williamboman/mason.nvim)
- 2. Linter: [null-ls](github.com/jose-elias-alvarez/null-ls.nvim)
- 3. LSP Hook Automation: [mason-lspconfig](github.com/williamboman/mason-lspconfig.nvim)
- 4. Commenting: [nerdcommenter](github.com/preservim/nerdcommenter)
- 5. tmux integration (requires tmux plugin): [vim-tmux-navigator](github.com/christoomey/vim-tmux-navigator)
- 6. OSC52 Yanking (for tmux+ssh): [vim-oscyank](github.com/ojroques/vim-oscyank)
- 7. Fuzzy finder and more: [Telescope](github.com/nvim-telescope/telescope.nvim)
- 8. Whitespace management: [vim-better-whitespace](github.com/ntpeters/vim-better-whitespace)
- 9. Snippets: [LuaSnip](github.com/L3M0N3D3/LuaSnip),
  [friendly-snippets](github.com/rafamadriz/friendly-snippets),
  [vim-snippets](github.com/honza/vim-snippets)
- 10. Lunarvim's autocomplete backend: [nvim-cmp](github.com/hrsh7th/nvim-cmp)
- 11.

- UI:
- 1. Statusbar: [lualine](github.com/nvim-lualine/lualine.nvim)
- 2. Filetree: [nvim-tree](github.com/nvim-tree/nvim-tree.lua)
- 3. IDE Tabs: [bufferline](github.com/akinsho/bufferline.nvim)
- 4. Popup nvim command menu: [wilder](github.com/gelguy/wilder.nvim)
- 5. Highlighting: [nvim-treesitter](github.com/christoomey/nvim-treesitter)
- 6. Colors: Ships with [kanagawa](github.com/rebelot/kanagawa.nvim) as
  the default, but also installs:  
  [everforest](github.com/sainnhe/everforest),
  [dracula](github.com/Mofiqul/dracula.nvim),
  and [ayu-vim](github.com/ayu-theme/ayu-vim). among others.
- 7. Icons: ships with necessary Nerdfont icons for statusbars and filetree.

## Preview Images

TODO

## Requirements

- [git](www.youtube.com/watch?v=l60MnDJklnM)
- [neovim](github.com/neovim/neovim/wiki/Installing-Neovim) - (version 0.7.0 or greater)
- [Packer](github.com/wbthomason/packer.nvim) - For plugin management.
- [ripgrep](github.com/BurntSushi/ripgrep)

## Recommended (required for some LSPs)

Note: many of these can be installed using your
linux distro's package manager or homebrew.

- [llvm](llvm.org)
- [clang](clang.llvm.org)
- [nodejs](nodejs.org/en)
- [python](python.org)

## Install

1. Clone this repo directly into your neovim config directory
  (usually ~/.config/nvim/ works):  
  i. `git clone git@github.com:corigne/dot-neovim.git ~/.config/nvim`  
  or  
  ii. `github.com/corigne/dot-neovim.git ~/.config/nvim`  
2. Run `nvim +PackerInstall +qa` to install all associated plugins.
  If everything works this may take some time.
3. Start neovim ( Just run: `nvim` ) and you should be prepared to program in
*most* commons languages.  
  i. (Except Java; we don't serve your kind here.)

## Adding additional LSP Servers

Install the LSP server of your choice using Mason. LSP servers should be
set up automatically once installed by Mason.

## Filemap

```bash
├─ init.lua : the base config file, kicks off with neovim  
├─ README.md : this readme  
└─ /lua/ : the lua folder standard for neovim lua modules  
   └─ /settings/ : houses the sub-config scripts  
      ├─ cmp.lsp : autocomplete settings  
      ├─ core.lua : core settings, things like tab size and colorscheme  
      ├─ keymap.lua : the keybindings I made or ported (LSP keybinds are in handlers.lua)  
      ├─ plugins.lua : the plugin section for Packer and some of the required configurations  
      └─ /lsp/ : houses the LSP configs, adapted from the 2022 "neovim-from-scratch" series metioned above  
         ├─ handlers.lua : the function and keymap definitions passed as args forthe lsp servers  
         ├─ init.lua : kicks off the lsp module  
         └─ lsp-installer.lua : sets up lsp-config and passes in the options
```
