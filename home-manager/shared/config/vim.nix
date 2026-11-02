{ ... }:

{
  home.file.".vimrc".text = ''
    " ------------------------------
    " General Settings
    " ------------------------------
    set nocompatible
    filetype plugin indent on

    " Buffers and history
    set hidden
    set noswapfile
    set undofile

    " Display and searching
    set hlsearch
    set ignorecase
    set incsearch
    set laststatus=2
    set relativenumber
    set ruler
    set scrolloff=8
    set showcmd
    set showmatch
    set sidescrolloff=8
    set smartcase
    set splitbelow
    set splitright
    set wrap

    " Editing
    set autoindent
    set backspace=indent,eol,start
    set expandtab
    set hidden
    set modelines=0
    set shiftwidth=4
    set smartindent
    set softtabstop=4
    set tabstop=4

    " Clipboard
    " (in TMUX: `set -s set-clipboard on`)
    let g:osc52_force_avail = v:true
    let g:osc52_disable_paste = v:true
    packadd osc52
    set clipmethod=osc52
    set clipboard=unnamedplus

    if has("syntax")
        syntax on
    endif

    if has('termguicolors')
        set termguicolors
    endif

    " ------------------------------
    " Colemak DHm keymaps
    " ------------------------------
    noremap <silent> m h
    noremap <silent> n j
    noremap <silent> e k
    noremap <silent> i l

    noremap <silent> M H
    noremap <silent> N J
    noremap <silent> E K
    noremap <silent> I L

    noremap <silent> <C-m> <C-h>
    noremap <silent> <C-n> 4j
    noremap <silent> <C-e> 4k
    noremap <silent> <C-i> <C-l>

    noremap <silent> h i
    noremap <silent> j m
    noremap <silent> k n
    noremap <silent> l e

    noremap <silent> H I
    noremap <silent> J M
    noremap <silent> K N
    noremap <silent> L E

    noremap <silent> <C-h> <C-i>
    noremap <silent> <C-j> <C-m>
    noremap <silent> <C-k> <C-n>
    noremap <silent> <C-l> <C-e>

    nnoremap <silent> <C-w>m <C-w>h
    nnoremap <silent> <C-w>n <C-w>j
    nnoremap <silent> <C-w>e <C-w>k
    nnoremap <silent> <C-w>i <C-w>l

    " ------------------------------
    " Generic Keymaps
    " ------------------------------
    nnoremap <Space> <Nop>
    let mapleader = " "

    nnoremap <silent> <C-c> <Esc>
    vnoremap <silent> <C-c> <Esc>
    onoremap <silent> <C-c> <Esc>
    vnoremap <silent> ,, <Esc>
    onoremap <silent> ,, <Esc>
    inoremap <silent> ,, <Esc>
    tnoremap <silent> ,, <C-\><C-n>

    nnoremap <silent> d "_d
    vnoremap <silent> d "_d
    nnoremap <silent> x "_x
    vnoremap <silent> x "_x
    nnoremap <silent> D "_D
    vnoremap <silent> D "_D
    nnoremap <silent> <leader>d d
    vnoremap <silent> <leader>d d
    nnoremap <silent> <leader>x x
    vnoremap <silent> <leader>x x
    nnoremap <silent> <leader>D D
    vnoremap <silent> <leader>D D

    noremap <silent> <C-u> <C-u>zz
    noremap <silent> <C-d> <C-d>zz

    nnoremap <silent> <C-W>< 20<C-W><
    nnoremap <silent> <C-W>> 20<C-W>>
    nnoremap <silent> <C-W>- 20<C-W>-
    nnoremap <silent> <C-W>+ 20<C-W>+

    " ------------------------------
    " Plugins
    " ------------------------------
    " curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    "   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    " :PlugInstall

    if !empty(globpath(&runtimepath, 'autoload/plug.vim'))
        call plug#begin()
            Plug 'tpope/vim-surround'     " Manage surrounding pairs
            Plug 'tpope/vim-repeat'       " Repeat plugin edits with .
            Plug 'tpope/vim-fugitive'     " Git commands through :Git
            Plug 'junegunn/fzf'           " Vim integration w/ fzf
            Plug 'junegunn/fzf.vim'       " :Files, :Rg, :Buffers, :History
            Plug 'preservim/nerdtree'     " File tree explorer with Space-p
        call plug#end()

        nnoremap <silent> <leader>. :Files<CR>
        nnoremap <silent> <leader>, :Buffers<CR>
        nnoremap <silent> <leader>fg :Rg<CR>
        nnoremap <silent> <leader>ff :Files<CR>
        nnoremap <silent> <leader>p :NERDTreeToggle<CR>
    endif

    " ------------------------------
    " Colorscheme
    " ------------------------------
    colorscheme habamax
    set background=dark
  '';
}
