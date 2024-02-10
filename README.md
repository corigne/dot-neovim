# dogma.nvim
### (In)contravertibly the best neovim config. /s

Note: I am working on updating the keybindings and plugin list to cut down on unnecessary bulk in the config and better align with my current workflow. These changes shift toward telescope. Until these changes are finalized please refer to the keybinding lua file.

Nvim configs ported from my old vimscript configs to lua, with some
additions inspired from lunarvim and nvchad.

This is a personal work-in-progress. 
If you discover any issues unrelated to the plugins themselves, please create
an issue ticket and I will happily look into handling it.  

Basic items, tab to cycle through autocompletion, enter to accept.
Everything else is self-explanatory. Keybinds are listed in the section below.

Enjoy!

##### Diagnostics:  

![image](https://github.com/corigne/dot-neovim/assets/7695563/856e8da9-ea5a-4452-9cec-4975f06f5d93)

##### LSP with autocomplete, and snippets:  

![image](https://github.com/corigne/dot-neovim/assets/7695563/0203868c-8026-46ed-a4de-f8c11458f149)

##### Fuzzy Finder using Telescope:  

![image](https://github.com/corigne/dot-neovim/assets/7695563/bab2d3a4-f807-45e5-a34f-27ac53dd2d3a)

##### Nice nvim popout menus with autocompletion:  

![image](https://github.com/corigne/dot-neovim/assets/7695563/d8bec591-4351-401a-a2ab-bba74dc2c674)

## Useful Features

Workflow:

- LSP, Linter, and Debugger installer: [Mason](github.com/williamboman/mason.nvim)
- LSP Handler: [Lspsaga](github.com/nvimdev/lspsaga.nvim)
(Replaced lunarvim LSP Handler)
- Linter: [null-ls](github.com/jose-elias-alvarez/null-ls.nvim)
- LSP Hook Automation: [mason-lspconfig](github.com/williamboman/mason-lspconfig.nvim)
- DAP Adapter Autoconfiguration: [mason-nvim-dap](github.com/jay-babu/mason-nvim-dap.nvim)
- Commenting Macros: [nerdcommenter](github.com/preservim/nerdcommenter)
- Telescope (Fuzzy Find, Grep, Diagnostics, and more): [Telescope](github.com/nvim-telescope/telescope.nvim)
- Whitespace management: [vim-better-whitespace](github.com/ntpeters/vim-better-whitespace)
- Lunarvim's autocomplete backend: [nvim-cmp](github.com/hrsh7th/nvim-cmp)

UI:
- Statusbar: [lualine](github.com/nvim-lualine/lualine.nvim)
- Filetree: Removed in favor of the Telescope file picker.
- IDE Style Buffer Tabs: [barbar](github.com/romgrk/barbar)
- Popup nvim command menu: [wilder](github.com/gelguy/wilder.nvim)
- Syntax Highlighting: [nvim-treesitter](github.com/christoomey/nvim-treesitter)
- Colors: Ships with [catppuccin-frappe](github.com/catppuccin/nvim) as
  the default, but also installs:  
  [everforest](github.com/sainnhe/everforest),
  [kanagawa](github.com/rebelot/kanagawa.nvim)
  [dracula](github.com/Mofiqul/dracula.nvim),
  and [ayu-vim](github.com/ayu-theme/ayu-vim). among others.
- Icons: ships with necessary Nerdfont icons for statusbars and filetree.

## Requirements

- [git](www.youtube.com/watch?v=l60MnDJklnM)
- [neovim](github.com/neovim/neovim/wiki/Installing-Neovim) - (version __0.9.1__ or greater)
- [ripgrep](github.com/BurntSushi/ripgrep)

## Recommended (required for some LSPs)

Note: many of these can be installed using your
linux distro's package manager or homebrew.
Mason diagnostic output will usually tell you when there's a missing dependency
during install.

- [llvm](llvm.org)
- [clang](clang.llvm.org)
- [nodejs](nodejs.org/en)
- [python](python.org)

## Install

1. Clone this repo directly into your neovim config directory
  (~/.config/nvim/ is typical):  
  `git clone https://github.com/corigne/dot-neovim.git ~/.config/nvim`  
2. Run neovim `nvim` to install all associated plugins on first-run.
3. Install any LSP's you might want to use with `:Mason`

## Keybinds

Some helpful keybinds for common plugins, see [the keymap.lua file](lua/keymap.lua)
for the rest of the bindings, e.g. LSPSaga and

**Note: Default leader is Space**

Normal Mode:

- , = navigate one tab to the left in barbar
- . = navigate one tab to the right in barbar
- Super/Meta + , = move current tab to the left
- Super/Meta + , = move current tab to the right

- leader + \  = nohl
- leader + nt = toggle nvim tidy on/off, default is on
- leader + ss = Strip highlighted whitespace from file (trailing)
- leader + q = close current buffer (closes the tab too, intentionally)
- leader + tt = telescope file picker
- leader + fg = telescope findgrep
- leader + ff = telescope findfile
- leader + fd = telescope lsp definitions
- leader + fr = telescope lsp references
- leader + ft = telescope lsp typedef
- leader + sd = telescope diagnostics
- leader + gs = telescope git status

- Super/Meta + d = toggle hover terminal (LSPSaga)
- leader + ca = show LSPSaga code actions
- leader + re = LSPSaga rename current variable under cursor
- leader + pd = LSPSaga peek definition
- leader + ss = LSPSaga show current line diagnostics
- leader + sc = LSPSaga cursor diagnostics
- leader + K  = LSPSaga hover doc toggle

- leader + ddd = toggle dap-ui on/off
- leader + B = set a breakpoint for DAP
- leader + C = continue in DAP
- leader + I = step into in DAP
- leader + O = step over in DAP

## Adding/Installing/Configuring LSP Servers and Debug Adapters

Install the LSP server of your choice using `:Mason`. LSP servers should be
set up automatically once installed by Mason. The same goes for debug adapters.

## Filemap

```bash
.
├── init.lua
├── lua
│   ├── cmp-config.lua
│   ├── core.lua
│   ├── dap-config.lua
│   ├── keymap.lua
│   └── plugins.lua
└── README.md
```
