# dogmatic.nvim
### contravertibly the best neovim config.

My neovim configurations, ported from my old monolitchic vimscript to lua, 
with QoL additions inspired from various sources.

This is a personal repo, and highly opinionated. 

Please submit issues only for bugs related to the configuration itself, 
and not for general neovim questions or bugs with the plugins, as I will 
not be able to help with those.

Basic items: 
- supertab style completion with all the standard providers (snippets, lsp, etc, buffer, path)
- copilot integration, make sure to configure your tokens in your environment
- catpuccin-frappe by default
- Snacks picker/explorer/dashboard as the default UI toolkit
- lazygit integration
- toggleterm
- nvim-dap with mason-nvim-dap for autoconfiguration of debug adapters

Enjoy!

## Screenshots

1. **CopilotChat** - Interactive AI code chat panel with syntax highlighting and code blocks
   ![CopilotChat](./assets/screenshots/copilot.png)

2. **Trouble Diagnostics Panel** - Multi-level diagnostic hierarchy view with file organization
   ![Trouble Diagnostics](./assets/screenshots/trouble.png)

3. **DAP Debugging UI** - dapui with variables, stack trace, watches, and breakpoints
   ![DAP UI](./assets/screenshots/dap.png)

4. **ToggleTerm Integration** - Floating terminal with window management
   ![ToggleTerm](./assets/screenshots/toggleterm.png)

## Useful Features

### Workflow & Development
- **LSP Integration**: Full Language Server Protocol support with diagnostics, code completion, hover docs, and code actions via [nvim-lspconfig](github.com/neovim/nvim-lspconfig)
- **Completion Engine**: Supertab-style completion with multiple providers - LSP, Copilot, snippets, buffer, and path via [blink.cmp](github.com/saghen/blink.cmp)
- **Snippets**: Full snippet expansion support via [LuaSnip](github.com/L3MON4D3/LuaSnip) with friendly-snippets library
- **Debugging**: Full DAP (Debug Adapter Protocol) support with [nvim-dap](github.com/mfussenegger/nvim-dap), [dapui](github.com/rcarriga/nvim-dap-ui), and automatic adapter configuration via [mason-nvim-dap](github.com/jay-babu/mason-nvim-dap.nvim)
- **Linting & Formatting**: Code quality tools via [none-ls](github.com/nvimtools/none-ls.nvim)
- **Package Management**: LSP, DAP, and linter installer via [Mason](github.com/williamboman/mason.nvim)

### Searching & Navigation
- **Fuzzy Finder**: [Snacks Picker](github.com/folke/snacks.nvim) for files, buffers, grep, diagnostics, symbols, and more (default picker-set)
- **File Explorer**: Snacks explorer replaces netrw for directory browsing
- **Symbol Navigation**: Document and workspace symbol browsing via Snacks Picker (LSP)
- **Git Integration**: Git-aware pickers for commits, branches, status, stash, and diff hunks

### Git & Version Control
- **Line Blame**: Git blame information inline via [git-blame.nvim](github.com/f-person/git-blame.nvim)
- **Git Signs**: Visual diff indicators and hunk management via [gitsigns.nvim](github.com/lewis6991/gitsigns.nvim)
- **Git Commands**: Full lazygit integration for interactive git operations via [lazygit.nvim](github.com/kdheepak/lazygit.nvim)
- **Blame Details**: Customizable blame message template with author, date, and commit SHA

### AI-Powered Assistance
- **GitHub Copilot**: Code completion powered by GitHub Copilot with [copilot.lua](github.com/zbirenbaum/copilot.lua) and [blink-copilot](github.com/fang2hou/blink-copilot) integration
- **CopilotChat**: Interactive AI chat interface via [CopilotChat.nvim](github.com/CopilotC-Nvim/CopilotChat.nvim), configured for Claude Sonnet 4.6 by default

### Editor Enhancements
- **Smart Surround**: Easy manipulation of surrounding characters via [nvim-surround](github.com/kylechui/nvim-surround)
- **Auto Pairs**: Automatic bracket and quote pairing via [nvim-autopairs](github.com/windwp/nvim-autopairs)
- **Comments**: Smart comment toggling via [Comment.nvim](github.com/numToStr/Comment.nvim)
- **Rainbow Delimiters**: Colorized nested bracket pairs via [rainbow-delimiters.nvim](github.com/HiPhish/rainbow-delimiters.nvim)
- **Todo Comments**: Highlight and navigate todo/fixme comments via [todo-comments.nvim](github.com/folke/todo-comments.nvim)
- **Indentation Guides**: Visual indentation markers via [blink.indent](github.com/saghen/blink.indent)

### UI & Visual Enhancements
- **Syntax Highlighting**: Modern syntax via [nvim-treesitter](github.com/nvim-treesitter/nvim-treesitter) with 40+ languages
- **Code Folding**: Intelligent code folding via [nvim-ufo](github.com/kevinhwang91/nvim-ufo) with treesitter support
- **Color Scheme**: Ships with [Catppuccin Frappe](github.com/catppuccin/nvim) as default, highly customizable
- **Status Line**: Beautiful status bar via [lualine.nvim](github.com/nvim-lualine/lualine.nvim) with Copilot status integration
- **Icons**: Complete Nerd Font icon support for UI elements
- **Cursor Effects**: Smear cursor animation via [smear-cursor.nvim](github.com/sphamba/smear-cursor.nvim)
- **Command Menu**: Enhanced command-line interface via [wilder.nvim](github.com/gelguy/wilder.nvim)

### Terminal Integration
- **Floating Terminal**: Integrated floating terminal via [toggleterm.nvim](github.com/akinsho/toggleterm.nvim)
- **Terminal Navigation**: Seamless window switching including terminal windows

### Window & Tab Management
- **Tmux Integration**: Seamless navigation between Neovim and Tmux splits via [nvim-tmux-navigation](github.com/alexghergh/nvim-tmux-navigation)
- **Tab Scoping**: Smart buffer scoping per tab via [scope.nvim](github.com/tiagovla/scope.nvim)

### Additional Tools
- **Documentation Generation**: Auto-generate function documentation via [neogen](github.com/danymat/neogen)
- **Clipboard Over SSH**: Copy to clipboard via SSH with OSC52 support via [nvim-osc52](github.com/ojroques/nvim-osc52)
- **Org Mode**: Full Emacs org-mode support via [orgmode](github.com/nvim-orgmode/orgmode)
- **Dev Environment**: Lua development tools via [neodev.nvim](github.com/folke/neodev.nvim)
- **Language Support**: Go development tools via [go.nvim](github.com/ray-x/go.nvim) and Rust via [rust-tools.nvim](github.com/simrat39/rust-tools.nvim)

## Keybinds

**Note: Default leader is Space. See `CHEATSHEET.md` for the full reference, including a few noted keybind collisions.**

### General Editing
- `<leader>\` = Clear search highlighting
- `<leader>q` = Delete current buffer (bdelete)
- `<leader>y` = Copy with OSC52 (over SSH) - operator mode / visual mode
- `<leader>yy` = Copy current line with OSC52
- `<leader>af` = Toggle autoformat globally
- `<leader>te` = Toggle autoformat on save for buffer (tidy, not on Windows)
- `<leader>ng` = Generate documentation (neogen)

### Snacks Picker (Find, Search, Explorer)
- `<leader><space>` / `<leader>ff` = Smart find files
- `<leader>,` / `<leader>fb` = Buffers
- `<leader>/` / `<leader>sg` = Grep
- `<leader>e` = File explorer
- `<leader>fc` = Find config files
- `<leader>fg` = Find git-tracked files
- `<leader>fp` = Projects
- `<leader>fr` = Recent files
- `<leader>sw` = Grep word/selection (normal/visual)
- `<leader>sd` / `<leader>sD` = Diagnostics / buffer diagnostics
- `<leader>sh` = Help pages
- `<leader>sk` = Keymaps
- `<leader>su` = Undo history
- `<leader>sR` = Resume last picker
- `<leader>ss` / `<leader>sS` = LSP document/workspace symbols
- `gd` / `gD` / `gr` / `gI` / `gy` = LSP definitions/declarations/references/implementations/type-defs
- `gai` / `gao` = LSP incoming/outgoing calls
- `<leader>gl` / `<leader>gs` / `<leader>gS` / `<leader>gd` / `<leader>gf` = Git log/status/stash/diff/log-file
- `<leader>gi` / `<leader>gI` / `<leader>gp` / `<leader>gP` = GitHub issues/PRs (open/all)
- `<leader>gB` = Git browse (open in browser)
- `<leader>gg` = Lazygit
- `<leader>z` / `<leader>Z` = Zen mode / zoom
- `<leader>.` / `<leader>S` = Scratch buffer toggle / select
- `<leader>n` / `<leader>un` = Notification history / dismiss all
- `<C-/>` / `<C-_>` = Toggle Snacks terminal
- `]]` / `[[` = Next/previous reference under cursor

> Full picker list (registers, jumps, marks, man pages, colorschemes, etc.) is in `CHEATSHEET.md`.

### Trouble (Diagnostics Panel)
- `<leader>xx` = Toggle diagnostics panel
- `<leader>xX` = Toggle buffer diagnostics
- `<leader>xL` = Toggle location list
- `<leader>xQ` = Toggle quickfix list
- `<leader>cs` / `<leader>cl` = Bound, but currently overridden by the CopilotChat mappings below (see note in `CHEATSHEET.md`)

### LSP & Code Navigation
- `gd` = Go to definition (native LSP; overrides the Snacks picker binding above)
- `gt` = Go to type definition (native LSP)
- `K` = Hover documentation
- `<leader>ca` = Code actions (normal/visual)
- `<leader>re` = Rename symbol
- `<leader>sd` = Show line diagnostics (float; overrides the Snacks diagnostics picker binding above)
- `<leader>sdc` = Show cursor diagnostics (float)
- `]d` / `[d` = Next/previous diagnostic

### Git
- `<leader>gb` = Git blame toggle (overrides the Snacks "Git Branches" picker binding above)
- `<leader>gg` = Open lazygit

### AI & Copilot
- `<leader>cc` = Toggle CopilotChat panel
- `<leader>cr` = Reset CopilotChat conversation
- `<leader>cl` = Load CopilotChat session (wins over Trouble's `<leader>cl`)
- `<leader>cs` = Save CopilotChat session (wins over Trouble's `<leader>cs`)
- `<leader>cS` = Stop CopilotChat
- `<leader>cm` = Select CopilotChat model
- `<tab>` = Sidekick: jump to/apply next edit suggestion (falls back to normal Tab)
- `<c-.>` / `<leader>aa` = Toggle Sidekick CLI (normal/terminal/insert/visual)
- `<leader>as` = Select Sidekick CLI tool
- `<leader>ad` = Detach a CLI session
- `<leader>at` / `<leader>aF` / `<leader>av` = Send this/file/selection to CLI
- `<leader>ap` = Select a Sidekick prompt
- `<leader>ac` = Toggle Sidekick with Copilot CLI directly

### Debugging (DAP)
- `<leader>dd` = Toggle DAP UI
- `<leader>b` / `<leader>db` = Toggle breakpoint
- `<leader>dbc` = Clear all breakpoints
- `<leader>dc` / `<F5>` = Continue execution
- `<leader>ds` / `<F10>` = Step over
- `<leader>di` / `<F11>` = Step into
- `<leader>do` / `<F12>` = Step out
- `<leader>dS` = Stop debugger
- `<leader>dr` = REPL toggle
- `<leader>dl` = Run last debug session

### Terminal
- `<D-d>` / `<M-d>` = Toggle floating terminal (normal/terminal modes, ToggleTerm)
- `<esc>` = Exit terminal mode
- `<C-h/j/k/l>` = Navigate windows from terminal mode
- `<C-w>` = Window commands from terminal mode

### Window Navigation (herdr/tmux Integration)
- `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` = Move to the left/bottom/top/right window; at a split edge, hands off to herdr or tmux if running (see `~/tools/vim-herdr-navigation`)

### Folding (UFO)
- `zR` = Open all folds
- `zM` = Close all folds
- `zr` = Open folds except kinds
- `zm` = Close folds with
