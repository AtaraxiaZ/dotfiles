set nocompatible
filetype plugin on
filetype indent on
filetype plugin indent on   
packadd! matchit
let b:match_words = '\<begin\>:\<end\>,\<module\>:\<endmodule\>'
set path+=~/Documents/projects/**
set ignorecase
" To make vim faster
set nocursorline
set norelativenumber
set hlsearch
set suffixesadd=.sv,.py,.c,.cpp
set tabstop=4
set shiftwidth=4
set buftype=
set expandtab " Expand TABs to spaces
set number
set background=dark
set backspace=indent,eol,start
set clipboard=unnamed
set notagrelative
set incsearch
" set the autocomplete do not use tags
" you can use :h 'cpt to check each flag
set complete-=]
" sets the keywordprg option to use Vim's built-in help system for looking up
" keywords. You can replace :help with any command or program that accepts a
" keyword as an argument and displays information about that keyword.
set keywordprg=:help
" It tells Vim to look for a tags file in the directory of the current file,
" in the current directory and up and up until your $HOME (that's the meaning
" of the semicolon), stopping on the first hit.
set tags=./tags,tags;/
" set tags=./tags,$HOME/tags,tags;/
" set tags+=/sandbox/noc_test_chip/common_hw/akcsr/src/tags
" set tags=./tags,tags;/
set autochdir
" automatical reload file in disk
set autoread
set statusline=%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
" enable mouse control
set mouse=a
" verilator can't include file recursively 
set makeprg=verilator\ --lint-only\ -Wall\ -I../\ %
" remember to type `VerilogErrorFormat verilator 1` in command line

" color sheme config
" colorscheme envy
colorscheme molokai
" let g:molokai_original = 1
" let g:rehash256 = 1

" ctags parameters order matters! 
" --foo[=(yes|no)]'' means ``--foo, -foo=yes, or -foo=no
" A better approch is running ctags coommand in the root directory with -R
" use --append option and gather all tags in $HOME is a bad idea, since -a
" doesn't work for some reason
" autocmd BufWritePost *.sv,*.svh,*.py call system("ctags -f $HOME/tags -a --tag-relative=never -R ./*")
autocmd BufWritePost *.sv,*.svh,*.py,*.tcl call system("ctags --tag-relative=never -R ./*")
" set the compiler for python files to pylint
autocmd FileType python compiler pylint
" autocmd BufWritePost *.py,*.sv call system("/home/zhe.li/opt/bin/ctags -R ./*")
" autocmd BufWritePost *.sv  silent! !start /min ctags -R *.sv

" save current session when quit accidently
" if filereadable('~/.vim/lastsession.vim')
"   exe 'source ~/.vim/lastsession.vim'
" endif
" autocmd VimLeave * mksession! ~/.vim/lastsession.vim

" keyboard mapping
" run cog and verilog mode
nnoremap <F5> :! python ~/miniconda3/pkgs/cogapp*/bin/cog.py -r %<CR> ! emacs -l /net/binlib/tools/fpga/scripts/verilog-mode/.emacs --batch % -f verilog-batch-auto<CR> ! sed -i 's/[ \t]*$//' %<CR>

" run verilog mode
" nnoremap <C-m> :! emacs -l /net/binlib/tools/fpga/scripts/verilog-mode/.emacs -batch % -f verilog-batch-auto<CR> ! sed -i 's/[ \t]*$//' %<CR>

" remove verilog mode
" nnoremap <C-n> :! emacs -l /net/binlib/tools/fpga/scripts/verilog-mode/.emacs -batch % -f verilog-batch-delete-auto<CR> ! sed -i 's/[ \t]*$//' %<CR>

nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
" nnoremap <C-6> <C-^>
nnoremap <C-s> :write<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)



" nnoremap <C-p> :Buffers<CR>
nnoremap <C-p> :Files /sandbox/noc_test_chip/<CR>

set splitbelow
set splitright

let g:verilog_syntax_fold_lst = "all"
set foldmethod=syntax
" set the default fold to all unfold
set foldlevel=99

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

Plug 'vhda/verilog_systemverilog.vim'

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


" disable the syntax highlighting in vimdiff
if &diff
    syntax off
end

set wrap linebreak

au StdinReadPost * set nomodified
