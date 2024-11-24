call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-signify'
Plug 'Yggdroot/indentLine'
Plug 'joshdick/onedark.vim', {'branch': 'main'}
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'Raimondi/delimitMate'
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
call plug#end()

set nu
set t_ut=
set softtabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=80
set nobomb
set hlsearch
set incsearch
set pastetoggle=<F3>
set encoding=utf-8
set ff=unix
set backspace=indent,eol,start
set listchars=tab:>',space:.
"set list
set smarttab
set autoread
set autowrite
set history=1000

let g:mapleader=","
imap <S-Insert> <C-R>*

function! SetPath()
	let current_dir=expand('%:p:h')."/**"
	execute "set path+=".current_dir
endfunc

"autocmd FileType c,cpp setlocal equalprg=clang-format\ -style=file
"autocmd VimEnter * : call SetPath()

" cursor
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>
nnoremap <leader>d :bd<cr>
nnoremap <leader>bb :buffers<cr>:b<cr>
nnoremap <leader><tab> :b#<cr>

" theme
syntax on
set bg=dark
"colo onedark
colo gruvbox

" easymotion
nmap s <Plug>(easymotion-overwin-f2)
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)
map <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)

" coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent><nowait> <Leader>co  :<C-u>CocList outline<cr>
set statusline^=%{coc#status{}}%{get(b:,'coc_current_function','')}
" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader> [g  <Plug>(coc-diagnostic-prev)
nmap <leader> ]g  <Plug>(coc-diagnostic-next)

nmap <leader>rf <Plug>(coc-refactor)
let g:coc_disable_startup_warning = 1

" signify
set signcolumn=yes

" tags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
" ctags and gtags
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
let g:gutentags_define_advanced_commands = 1

" rust and tagbar
let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/opt/homebrew/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }
nmap <F8> :TagbarToggle<CR>

" ale
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_option = ''
let g:ale_cpp_cppcheck_option = ''

" gitgutter
let g:gitgutter_gt_executable = '/usr/bin/git'
set updatetime=100

" nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
