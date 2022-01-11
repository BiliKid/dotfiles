call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.vim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-signify', {'branch': 'legacy'}
Plug 'Yggdroot/indentLine'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'liuchengxu/vista.vim'
call plug#end()

set nu
set term=screen-256color
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

autocmd FileType c,cpp setlocal equalprg=clang-format\ -style=file
autocmd VimEnter * : call SetPath()

" cursor
nnormap <leader>n :bn<cr>
nnormap <leader>p :bp<cr>
nnormap <leader>d :bd<cr>
nnormap <leader>bb :buffers<cr>:b<cr>
nnormap <leader><tab> :b#<cr>

" theme
syntax on
set bg=dark
colo onedark

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
nnoremap <F4> :CocCommand explorer --toggle --root-strategies keep --sources buffers+,file+ <cr>
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

" signify
set signcolumn=yes



" tags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
" ctags and gtags
let g:gutentags_modules = []
if executalbe('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executalbe('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
let g:gutentags_auto_add_gtags_cscope = 0
let g:gutentags_define_advanced_commands = 1

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

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#wordcount#formatter#default#fmt = '%s W'

let g:airline#extensions#whitespace#trailing_format = '[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'MI[%s]'
let g:airline#extensions#whitespace#long_format = '[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'MF[%s]'
let g:airline#extensions#whitespace#conflicts_format = 'conflicts[%s]'
let g:airline#extensions#searchcount#enable = 0

let g:airline_powerline_fonts=1

" gitgutter
let g:gitgutter_gt_executable = '/usr/bin/git'
set updatetime=100

" gtags
let $GTAGSCONF = expand('~/.vim/gtags.conf')

" leaderf
let g:Lf_CacheDirectory = expand('~/.vim/cache')
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fc :LeaderfFunction!<CR>
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_GtagsAutoUpdate = 1
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fs :<C-U><C-R>=printf("Leaderf! gtags -s %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
let g:Lf_WildIgnore = {'dir': ['.vscode', '.git'], 'file': []}

" vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ }

let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }

let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1

let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
nnoremap <F5> :Vista!! <cr>


