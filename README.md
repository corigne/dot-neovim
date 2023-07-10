# NVIMIS  

Nvim configs ported from my old vimscript configs to lua, with some
additions inspired and borrowed from nvchad.  

This is a personal work-in-progress. It works, but it has some quirks that
I am actively working out and will push to this repository. If there are keybind
related issues or other issues unrelated to the plugins themselves, please create
an issue ticket and I will happily look into handling it.  

Basic items, tab to cycle through autocompletion, enter to accept.
Everything else is self-explanatory. Keybinds are listed in the section below.

Enjoy!

Diagnostics:  
![image](https://github.com/corigne/dot-neovim/assets/7695563/856e8da9-ea5a-4452-9cec-4975f06f5d93)

Autocomplete, with snippets:  
![image](https://github.com/corigne/dot-neovim/assets/7695563/0203868c-8026-46ed-a4de-f8c11458f149)

Fuzzy Finder using Telescope:  
![image](https://github.com/corigne/dot-neovim/assets/7695563/bab2d3a4-f807-45e5-a34f-27ac53dd2d3a)

Nice nvim popout menus with autocompletion:  
![image](https://github.com/corigne/dot-neovim/assets/7695563/d8bec591-4351-401a-a2ab-bba74dc2c674)

## Useful Features

Workflow:

- LSP, Linter, and Debugger installer: [Mason](github.com/williamboman/mason.nvim)
- LSP Handler: [Lspsaga](github.com/nvimdev/lspsaga.nvim)
(Replaced lunarvim LSP Handler)
- Linter: [null-ls](github.com/jose-elias-alvarez/null-ls.nvim)
- LSP Hook Automation: [mason-lspconfig](github.com/williamboman/mason-lspconfig.nvim)
- Commenting: [nerdcommenter](github.com/preservim/nerdcommenter)
- tmux integration (requires tmux plugin): [vim-tmux-navigator](github.com/christoomey/vim-tmux-navigator)
- OSC52 Yanking (for tmux+ssh): [vim-oscyank](github.com/ojroques/vim-oscyank)
- Fuzzy finder and more: [Telescope](github.com/nvim-telescope/telescope.nvim)
- Whitespace management: [vim-better-whitespace](github.com/ntpeters/vim-better-whitespace)
- Snippets: [LuaSnip](github.com/L3M0N3D3/LuaSnip),
  [friendly-snippets](github.com/rafamadriz/friendly-snippets),
  [vim-snippets](github.com/honza/vim-snippets)
- Lunarvim's autocomplete backend: [nvim-cmp](github.com/hrsh7th/nvim-cmp)

UI:

- Statusbar: [lualine](github.com/nvim-lualine/lualine.nvim)
- Filetree: [nvim-tree](github.com/nvim-tree/nvim-tree.lua)
- IDE Tabs: [barbar](github.com/romgrk/barbar)
- Popup nvim command menu: [wilder](github.com/gelguy/wilder.nvim)
- Syntax Highlighting: [nvim-treesitter](github.com/christoomey/nvim-treesitter)
- Colors: Ships with [kanagawa](github.com/rebelot/kanagawa.nvim) as
  the default, but also installs:  
  [everforest](github.com/sainnhe/everforest),
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

All non-standard vim keybinds:  
**Note: Default leader is Space**

Normal Mode:

- , = navigate one tab to the left
- . = navigate one tab to the right
- Super + , = move current tab to the left
- Super + , = move current tab to the right
- leader + \  = nohl
- leader + ss = Strip highlighted whitespace from file (trailing)
- leader + bn = buffer-next
- leader + bp = buffer-prev
- leader + bd = bclose plugin (close the current buffer without closing the window)
- leader + bD = buffer-delete
- leader + bc = ls + prompt buffer-change
- leader + bl = ls (list buffers)
- leader + y = OSC Yank (yank to system clipboard using OSC52 esc)
- leader + yy = OSC Yank whole line
- leader + y (visual) = OSC Yank
- leader + td = close current tab - tabc
- leader + tt = toggle filetree
- leader + tf = NvimTreeFind
- leader + tc = NvimTreeCollapse
- leader + ff = Telescope fuzzyfind
- leader + fg = Telescipe grep
- leader + fb = Telescope buffer builtin
- leader + fh = Telescope helptags

__LSP SAGA__  
-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
gh

-- Code action
- <leader> + ca

-- Rename all occurrences of the hovered word for the entire file
gr

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
gp

-- Go to definition
gd

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
gt

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
<leader>sl

-- Show buffer diagnostics
<leader>sb

-- Show workspace diagnostics
<leader>sw

-- Show cursor diagnostics
<leader>sc

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
[e = (back)
]e = (forward)

-- Toggle outline
<leader>o

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
K

-- Call hierarchy
<Leader>ci (incoming)
<Leader>co (outgoing)

-- Floating terminal
<M-d>

## Adding additional LSP Servers

Install the LSP server of your choice using `:Mason`. LSP servers should be
set up automatically once installed by Mason.

## Filemap

```bash
.
├── init.lua
├── lua
│   ├── local_plugins
│   │   └── bclose.lua
│   └── settings
│       ├── cmp.lua
│       ├── core.lua
│       ├── keymap.lua
│       ├── lsp
│       │   ├── handlers.lua
│       │   └── setup.lua
│       └── plugins.lua
└── README.md

4 directories, 9 files
```
