" Set leader key
inoremap jk <ESC>
inoremap kj <ESC>
inoremap jj <ESC>
inoremap kk <ESC>
let mapleader = ";"
" Set number lines
set termguicolors
set number
set relativenumber
set tabstop=4
set expandtab
set shiftwidth=4
set ignorecase

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mg979/vim-visual-multi'
" Plug 'github/copilot.vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'overcache/NeoSolarized'
Plug 'asvetliakov/vim-easymotion'
" Plug 'cohama/lexima.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


" XML Format
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml(indent='\t', newl=''))"
nnoremap = :FormatXML<Cr>

" Set colorscheme
if exists("&termguicolors") && exists("&winblend")
    syntax enable
    set winblend=0
    set wildoptions=pum
    set pumblend=5
    set background=dark
    let g:neosolarized_termtrans=1
    colorscheme NeoSolarized
endif

" set shortcut for nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>

vnoremap <C-d>   <Cmd>call VSCodeNotifyVisual('editor.action.addSelectionToNextFindMatch', 1)<CR>
inoremap <C-d>   <Cmd>call VSCodeNotifyVisual('editor.action.addSelectionToNextFindMatch', 1)<CR>
