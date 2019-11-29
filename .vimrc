set smartindent
set autoindent
set nu
set ts=4
set softtabstop=4
set shiftwidth=4
set showcmd
let g:mapleader=','
let g:plug_timeout=1200

call plug#begin('~/.vim/plugged')
Plug 'easymotion/vim-easymotion'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

nmap ,  <Plug>(easymotion-prefix)

" palenight
set background=dark
colorscheme palenight
let g:airline_theme = "palenight"
