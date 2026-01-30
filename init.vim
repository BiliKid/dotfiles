call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
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
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'OXY2DEV/markview.nvim'
Plug 'dhruvasagar/vim-table-mode'
call plug#end()

" lsp 
lua << EOF
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")

require'nvim-treesitter'.setup {
  ensure_installed = { "c", "lua", "vim", "cpp", "python", "rust"},
  sync_install = false,
  auto_install = true,
  ignore_install = {},

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
}


EOF

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources( {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'nvim_lsp_signature_help' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
EOF


set nu
set t_ut=
set softtabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=80
set nobomb
set hlsearch
set incsearch
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
" colo onedark
colo gruvbox

" easymotion
nmap s <Plug>(easymotion-overwin-f2)
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)
map <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)

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
let g:rustfmt_autosave = 1
let g:rust_cargo_use_clippy = 1

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

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" telescope
nnoremap <leader>ff <cmd>Telescope find_files follow=true<cr>
nnoremap <leader>fg <cmd>Telescope grep_string grep_open_files=false<cr>
nnoremap <leader>fw <cmd>Telescope live_grep grep_open_files=false<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>ft <cmd>Telescope help_tags<cr>
nnoremap <leader>fh <cmd>Telescope search_history<cr>

nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fi <cmd>Telescope lsp_incoming_calls<cr>
nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>

lua <<EOF
-- search in current directory
vim.keymap.set('n', '<leader>sg', function()
  local current_file_dir = vim.fn.expand('%:p:h')
  if current_file_dir == '' then
    -- if current is not a file, rollback to root directory
    current_file_dir = vim.fn.getcwd()
  end
  require('telescope.builtin').live_grep({
    cwd = current_file_dir,
    prompt_title = 'Live Grep (Current File Dir)',
    additional_args = { '--hidden', '--glob=!{.git,node_modules,.cache}' }
  })
end, { desc = 'Search in current file\'s directory with rg' })
EOF

" yank relative path
nnoremap <leader>yp :let @+=expand('%')<cr>
