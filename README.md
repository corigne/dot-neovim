# dot-neovim
My Neovim configurations ported to LUA.  
A combination of my own configs and the lsp/autocompletion features from the ["neovim-from-scratch"](https://github.com/LunarVim/Neovim-from-scratch) series by chris@machine.
## What it looks lke:
![image](https://github.com/corigne/dot-neovim/assets/7695563/4b067d35-2207-44a8-93ac-667db79771c1)

## Requirements:
- [git](https://www.youtube.com/watch?v=l60MnDJklnM)
- [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) - (version 0.7.0 or greater)
- [Packer](https://github.com/wbthomason/packer.nvim) - For plugin management.
- [lua-language-server](https://github.com/LuaLS/lua-language-server):  
  - Necessary, as the [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer) is archived  
   and doesn't have the updated LSP download link for lua-ls.
- I think that's it, **create an issue** if something isn't working out of the box.

## To install:
1. Clone this repo directly into your neovim config directory (usually ~/.config/nvim/ works):  
  i. `git clone git@github.com:corigne/dot-neovim.git ~/.config/nvim`  
  or  
  ii. `https://github.com/corigne/dot-neovim.git ~/.config/nvim`  
2. Run `nvim +PackerInstall +qa` to install all associated plugins. If everything works this may take some time.  
3. Start neovim ( Just run: `nvim` ) and you should be prepared to program in *most* commons languages.  
  i. (Except Java; we don't serve your kind here.)
