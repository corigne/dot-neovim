# Neovim Keymap Cheatsheet

All mappings use `<leader>` as the leader key (commonly set to the **spacebar**).

---

## 🔍 Search & Clear Highlights

| Keymap            | Action                           |
|-------------------|----------------------------------|
| `<leader>\`       | Clear search highlights          |

---

## 📑 Buffers

| Keymap    | Action                   |
|-----------|--------------------------|
| `<leader>q` | Kill (bdelete) current buffer      |

---

## 📋 Clipboard (OSC52 - only if not in VSCode)

| Keymap       | Action                  |
|--------------|-------------------------|
| `<leader>y`  | Copy operator (normal)  |
| `<leader>y`  | Copy (visual mode)      |
| `<leader>yy` | Copy current line (by remapping `<leader>y_`) |

---

## 🛠 Autoformat (tidy.nvim, not on Windows)

| Keymap       | Action                        |
|--------------|-------------------------------|
| `<leader>te` | Toggle tidy (autoformat)      |

---

## 🪶 Folding (ufo.nvim)

| Keymap | Action             |
|--------|--------------------|
| zR     | Open all folds     |
| zM     | Close all folds    |

---

## 🔭 Snacks Picker (File Finder & More)

| Keymap           | Action                        |
|------------------|-------------------------------|
| `<leader>ff`     | Smart find files (cwd/git)    |
| `<leader><space>` | Smart find files             |
| `<leader>fg`     | Find git-tracked files        |
| `<leader>fc`     | Find config files             |
| `<leader>fr`     | Recent files                  |
| `<leader>fb`     | Buffers                       |
| `<leader>fp`     | Projects                      |
| `<leader>/`      | Grep (live search)            |
| `<leader>sg`     | Grep                          |
| `<leader>sw`     | Grep word / selection         |
| `<leader>sh`     | Help pages                    |
| `<leader>ss`     | LSP symbols                   |
| `<leader>sS`     | LSP workspace symbols         |
| `<leader>sd`     | Diagnostics                   |
| `<leader>sD`     | Buffer diagnostics            |
| `<leader>sk`     | Keymaps                       |
| `<leader>su`     | Undo history                  |
| `<leader>sR`     | Resume last picker            |
| `gd`             | LSP definitions               |
| `gD`             | LSP declarations              |
| `gr`             | LSP references                |
| `gI`             | LSP implementations           |
| `gy`             | LSP type definitions          |
| `<leader>gl`     | Git log                       |
| `<leader>gb`     | Git branches                  |
| `<leader>gs`     | Git status                    |
| `<leader>gc`     | Git commits (log)             |

---

## 📝 Neogen (Generate Annotations)

| Keymap         | Action          |
|----------------|-----------------|
| `<leader>ng`   | Generate docs   |

---

## 🪲 Debugging (nvim-dap & nvim-dap-ui)

| Keymap          | Action                      |
|-----------------|-----------------------------|
| `<leader>dd`    | Toggle DAP UI               |
| `<leader>db`    | Toggle breakpoint           |
| `<leader>dbc`   | Clear all breakpoints       |
| `<leader>ds`    | Step over                   |
| `<leader>di`    | Step into                   |
| `<leader>do`    | Step out                    |
| `<leader>dc`    | Continue                    |
| `<leader>ds`    | Stop                        |
| `<leader>dr`    | Rerun                       |

---

## 🌊 LSP (Lspsaga)

| Keymap          | Action                                 |
|-----------------|----------------------------------------|
| `<leader>ca`    | Code action                            |
| `<leader>re`    | Rename symbol                          |
| `<leader>pd`    | Peek definition                        |
| `<leader>pt`    | Peek type definition                   |
| `<leader>sdc`   | Show cursor diagnostics                |
| `]d`            | Jump to previous diagnostic            |
| `[d`            | Jump to next diagnostic                |
| `<leader>lo`    | Toggle outline                         |
| `K`             | Hover documentation                    |
| `<leader>ci`    | Incoming calls                         |
| `<leader>co`    | Outgoing calls                         |

---

## 🖥 Terminal/Tmux/Navigation

| Keymap        | Action                                                  |
|---------------|---------------------------------------------------------|
| `<D-d>`/`<M-d>` (n/t) | Floating terminal (toggle)                      |
| `<C-h>`/`<C-j>`/`<C-k>`/`<C-l>` | Navigate between splits using nvim-tmux-navigation |
| `<C-\>`       | Go to last active pane (tmux)                           |
| `<C-Space>`   | Go to next pane (tmux)                                  |
| `<esc>` (t)   | Exit terminal mode to normal mode                       |
| `<C-w>` (t)   | Window commands from terminal mode                      |

---

## 🧩 Notes

- VSCode-specific mappings are disabled when in VSCode (`vim.g.vscode`).
- `<leader>` is usually mapped to space, but check your `core.lua`/`init.lua` for the exact mapping.

---
