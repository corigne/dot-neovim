# Neovim Keymap Cheatsheet

All mappings use `<leader>` as the leader key (mapped to **spacebar**).

This file lists every keybind currently defined in `lua/keymap.lua` and the
`keys = {}` blocks in `lua/plugins.lua`. Where two plugins/keymaps claim the
same key, the entry that wins (loaded later, so it overrides) is noted.

Load order is `plugins` -> `autocmd` -> `core` -> `keymap` (see `init.lua`),
so anything set in `keymap.lua` overrides a same-key binding registered by a
plugin in `plugins.lua`.

---

## ⚠️ Known Keybind Collisions

| Key            | Registered by                          | Actually wins                          |
|----------------|-----------------------------------------|-----------------------------------------|
| `<leader>gb`   | Snacks Picker (Git Branches), git-blame.nvim (`GitBlameToggle`) | `keymap.lua` -> **GitBlameToggle** |
| `gd`           | Snacks Picker (`lsp_definitions`), native LSP (`vim.lsp.buf.definition`) | `keymap.lua` -> **native LSP jump** (no picker) |
| `<leader>sd`   | Snacks Picker (Diagnostics), native `vim.diagnostic.open_float()` | `keymap.lua` -> **float diagnostics** (no picker) |
| `<leader>cl`   | Trouble (`Trouble lsp toggle`), CopilotChat (`CopilotChatLoad`) | **CopilotChatLoad** (defined after Trouble in `keymap.lua`) |
| `<leader>cs`   | Trouble (`Trouble symbols toggle`), CopilotChat (`CopilotChatSave`) | **CopilotChatSave** (defined after Trouble in `keymap.lua`) |

These aren't necessarily bugs (some may be intentional overrides), just
noted here so the doc matches reality. If you want the Snacks/Trouble
variant instead, rebind the losing side to a different key.

---

## 🔍 Search & Clear Highlights

| Keymap      | Action                  |
|-------------|-------------------------|
| `<leader>\` | Clear search highlights |

---

## 📑 Buffers

| Keymap       | Action                              |
|--------------|--------------------------------------|
| `<leader>q`  | Delete (bdelete) current buffer      |
| `<leader>bd` | Delete buffer (Snacks bufdelete)     |

---

## 📋 Clipboard (OSC52, nvim only)

| Keymap       | Action                                         |
|--------------|-------------------------------------------------|
| `<leader>y`  | Copy operator (normal mode)                     |
| `<leader>y`  | Copy selection (visual mode)                    |
| `<leader>yy` | Copy current line (remaps to `<leader>y_`)      |

---

## 🛠 Autoformat

| Keymap       | Action                                       |
|--------------|-----------------------------------------------|
| `<leader>af` | Toggle autoformat globally (`vim.g.autoformat_enabled`) |
| `<leader>te` | Toggle tidy.nvim autoformat for buffer (not on Windows) |

---

## 🪶 Folding (nvim-ufo, nvim only)

| Keymap | Action                       |
|--------|-------------------------------|
| `zR`   | Open all folds                 |
| `zM`   | Close all folds                |
| `zr`   | Open folds except kinds        |
| `zm`   | Close folds with kinds (`closeFoldsWith`) |

---

## 🔭 Snacks Picker (default picker-set: files, grep, git, LSP, misc)

### Top pickers / explorer
| Keymap             | Action                     |
|---------------------|----------------------------|
| `<leader><space>`   | Smart find files            |
| `<leader>,`         | Buffers                     |
| `<leader>/`         | Grep                        |
| `<leader>:`         | Command history             |
| `<leader>n`         | Notification history        |
| `<leader>e`         | File explorer               |

### Find
| Keymap        | Action                    |
|----------------|----------------------------|
| `<leader>fb`  | Buffers                    |
| `<leader>fc`  | Find config file           |
| `<leader>ff`  | Smart find files           |
| `<leader>fg`  | Find git-tracked files     |
| `<leader>fp`  | Projects                   |
| `<leader>fr`  | Recent files                |

### Git & GitHub
| Keymap        | Action                        |
|----------------|--------------------------------|
| `<leader>gb`  | Git branches *(overridden — see collisions)* |
| `<leader>gl`  | Git log                        |
| `<leader>gL`  | Git log line                   |
| `<leader>gs`  | Git status                     |
| `<leader>gS`  | Git stash                      |
| `<leader>gd`  | Git diff (hunks)                |
| `<leader>gf`  | Git log file                   |
| `<leader>gi`  | GitHub issues (open)            |
| `<leader>gI`  | GitHub issues (all)             |
| `<leader>gp`  | GitHub pull requests (open)     |
| `<leader>gP`  | GitHub pull requests (all)      |
| `<leader>gB`  | Git browse (open in browser), normal/visual |
| `<leader>gg`  | Lazygit                        |

### Grep & search
| Keymap        | Action                          |
|----------------|-----------------------------------|
| `<leader>sb`  | Buffer lines                      |
| `<leader>sB`  | Grep open buffers                 |
| `<leader>sg`  | Grep                               |
| `<leader>sw`  | Grep visual selection or word (normal/visual) |
| `<leader>s"`  | Registers                          |
| `<leader>s/`  | Search history                     |
| `<leader>sa`  | Autocmds                           |
| `<leader>sc`  | Command history                    |
| `<leader>sC`  | Commands                           |
| `<leader>sd`  | Diagnostics *(overridden — see collisions)* |
| `<leader>sD`  | Buffer diagnostics                 |
| `<leader>sh`  | Help pages                         |
| `<leader>sH`  | Highlights                         |
| `<leader>si`  | Icons                              |
| `<leader>sj`  | Jumps                              |
| `<leader>sk`  | Keymaps                            |
| `<leader>sl`  | Location list                      |
| `<leader>sm`  | Marks                              |
| `<leader>sM`  | Man pages                          |
| `<leader>sp`  | Search for plugin spec (lazy)      |
| `<leader>sq`  | Quickfix list                      |
| `<leader>sR`  | Resume last picker                 |
| `<leader>su`  | Undo history                       |
| `<leader>uC`  | Colorschemes                       |

### LSP
| Keymap    | Action                            |
|-----------|-------------------------------------|
| `gd`      | Goto definition *(overridden — see collisions)* |
| `gD`      | Goto declaration                     |
| `gr`      | References                           |
| `gI`      | Goto implementation                  |
| `gy`      | Goto type definition                 |
| `gai`     | Calls incoming                       |
| `gao`     | Calls outgoing                       |
| `<leader>ss` | LSP document symbols              |
| `<leader>sS` | LSP workspace symbols             |

### Other
| Keymap        | Action                        |
|----------------|--------------------------------|
| `<leader>z`   | Toggle Zen mode                |
| `<leader>Z`   | Toggle zoom                     |
| `<leader>.`   | Toggle scratch buffer           |
| `<leader>S`   | Select scratch buffer           |
| `<leader>cR`  | Rename file                     |
| `<leader>un`  | Dismiss all notifications        |
| `<c-/>` / `<c-_>` | Toggle terminal (Snacks)     |
| `]]` / `[[`   | Next / previous reference (normal/terminal) |
| `<leader>N`   | Neovim news                      |

---

## 📝 Neogen (Generate Annotations)

| Keymap       | Action        |
|---------------|----------------|
| `<leader>ng` | Generate docs  |

---

## 🪲 Debugging (nvim-dap & nvim-dap-ui, nvim only)

| Keymap          | Action                      |
|-----------------|-------------------------------|
| `<leader>dd`    | Toggle DAP UI                 |
| `<leader>b`     | Toggle breakpoint              |
| `<leader>db`    | Toggle breakpoint              |
| `<leader>dbc`   | Clear all breakpoints          |
| `<leader>dc` / `<F5>`  | Continue                |
| `<leader>ds` / `<F10>` | Step over               |
| `<leader>di` / `<F11>` | Step into                |
| `<leader>do` / `<F12>` | Step out                 |
| `<leader>dS`    | Stop                            |
| `<leader>dr`    | REPL toggle                     |
| `<leader>dl`    | Run last debug session          |

---

## 🌊 LSP (native `vim.lsp.buf.*`, nvim only)

| Keymap          | Action                                 |
|-----------------|-----------------------------------------|
| `<leader>ca`    | Code action (normal/visual)             |
| `<leader>re`    | Rename symbol                           |
| `<leader>sd`    | Show line diagnostics (float) *(wins over Snacks diagnostics picker)* |
| `<leader>sdc`   | Show cursor diagnostics (float)         |
| `]d`            | Jump to next diagnostic                 |
| `[d`            | Jump to previous diagnostic             |
| `gd`            | Go to definition *(wins over Snacks picker)* |
| `gt`            | Go to type definition                   |
| `K`             | Hover documentation                     |

---

## 🚨 Trouble (Diagnostics Panel, nvim only)

| Keymap          | Action                                                  |
|-----------------|-----------------------------------------------------------|
| `<leader>xx`    | Toggle diagnostics panel                                    |
| `<leader>xX`    | Toggle buffer diagnostics                                   |
| `<leader>xL`    | Toggle location list                                        |
| `<leader>xQ`    | Toggle quickfix list                                        |
| `<leader>cs`    | Toggle symbols *(overridden by CopilotChat's `<leader>cs`)* |
| `<leader>cl`    | Toggle LSP locations *(overridden by CopilotChat's `<leader>cl`)* |

---

## 🤖 AI & Copilot (nvim only)

### CopilotChat
| Keymap       | Action                       |
|---------------|-------------------------------|
| `<leader>cc` | Toggle CopilotChat panel       |
| `<leader>cr` | Reset CopilotChat conversation |
| `<leader>cl` | Load CopilotChat session (wins over Trouble) |
| `<leader>cs` | Save CopilotChat session (wins over Trouble) |
| `<leader>cS` | Stop CopilotChat                |
| `<leader>cm` | Select CopilotChat model         |

### Sidekick (Copilot NES + CLI)
| Keymap       | Action                                              |
|---------------|-------------------------------------------------------|
| `<tab>`      | Jump to / apply next edit suggestion (falls back to Tab) |
| `<c-.>`      | Toggle Sidekick CLI (normal/terminal/insert/visual)     |
| `<leader>aa` | Toggle Sidekick CLI                                     |
| `<leader>as` | Select CLI tool                                          |
| `<leader>ad` | Detach a CLI session                                     |
| `<leader>at` | Send "this" (normal/visual)                              |
| `<leader>aF` | Send file                                                 |
| `<leader>av` | Send visual selection (visual)                           |
| `<leader>ap` | Select a prompt (normal/visual)                          |
| `<leader>ac` | Toggle Sidekick with Copilot CLI directly                |

---

## 🖥 Terminal / Window / Tmux Navigation

| Keymap                          | Action                                                       |
|-----------------------------------|-----------------------------------------------------------------|
| `<D-d>` / `<M-d>` (normal/terminal) | Toggle floating terminal (ToggleTerm)                        |
| `<esc>` (terminal)                | Exit terminal mode to normal mode                                |
| `<C-w>` (terminal)                | Window commands from terminal mode                               |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move to left/bottom/top/right window; at a split edge, hands off to herdr or tmux (from `~/tools/vim-herdr-navigation`, loaded via `dofile` in `plugins.lua`) |

Note: `vim-tmux-navigator` is installed but its own mappings are disabled
(`vim.g.tmux_navigator_no_mappings = 1`); the `<C-h/j/k/l>` bindings above
come from the custom herdr navigation script instead, and it does not map
`<C-\>` or `<C-Space>`.

---

## 🧩 Notes

- Neovim-only mappings (most of the above) are disabled when running inside VSCode (`vim.g.vscode`).
- `<leader>` is mapped to space in `plugins.lua` (`vim.g.mapleader = " "`).
- See the collisions table at the top for keys bound by more than one source.
