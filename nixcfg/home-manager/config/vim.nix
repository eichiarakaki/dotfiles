{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      syntax on
      filetype plugin indent on
      set number
      set relativenumber
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set smartindent
      set wrap
      set scrolloff=8
      set mouse=a
      set ignorecase
      set smartcase
      set incsearch
      set hlsearch
      set termguicolors
      set noshowmode
      set laststatus=2

      inoremap kj <Esc>
      set background=dark
      set clipboard=unnamedplus

      let g:clipboard = {
            \ 'name': 'wl-clipboard',
            \ 'copy': {
            \   '+': 'wl-copy --foreground --type text/plain',
            \   '*': 'wl-copy --foreground --primary --type text/plain',
            \ },
            \ 'paste': {
            \   '+': 'wl-paste --no-newline',
            \   '*': 'wl-paste --no-newline --primary',
            \ },
            \ 'cache_enabled': 1,
            \ }

      vnoremap <leader>y "+y
      nnoremap <leader>yy "+yy
      nnoremap <leader>p "+p

      " ----------------------------------------
      " statusline
      " ----------------------------------------
      function! GitBranch()
        return system("git symbolic-ref --short HEAD 2>/dev/null | tr -d '\n'")
      endfunction

      function! GitStatus()
        if strlen(GitBranch()) > 0
          return '[' . GitBranch() . '] '
        endif
        return ""
      endfunction

      set statusline=\ %f\ %m%=%{GitStatus()}%y\ %l:%c\ 

      " ----------------------------------------
      " theme — near-monochrome
      " keywords = dim blue  #4a6a88
      " strings  = dim green #4a6a4a
      " comments = visible grey #606060
      " everything else is grey
      " ----------------------------------------
      highlight clear
      syntax reset

      highlight Normal          guifg=#c0c0c0 guibg=#0d0d0d
      highlight NormalNC        guifg=#c0c0c0 guibg=#0d0d0d
      highlight LineNr          guifg=#303030 guibg=#0d0d0d
      highlight CursorLineNr    guifg=#4a4a4a guibg=#0d0d0d
      highlight CursorLine                    guibg=#111111
      highlight Visual                        guibg=#1c1c1c
      highlight VertSplit       guifg=#181818 guibg=#0d0d0d
      highlight SignColumn                    guibg=#0d0d0d
      highlight EndOfBuffer     guifg=#181818 guibg=#0d0d0d

      highlight Comment         guifg=#606060 gui=none
      highlight SpecialComment  guifg=#606060

      highlight String          guifg=#4a6a4a
      highlight Character       guifg=#4a6a4a

      highlight Number          guifg=#686868
      highlight Boolean         guifg=#686868
      highlight Float           guifg=#686868
      highlight Constant        guifg=#c0c0c0

      highlight Identifier      guifg=#c0c0c0
      highlight Function        guifg=#c0c0c0

      highlight Statement       guifg=#4a6a88 gui=none
      highlight Conditional     guifg=#4a6a88 gui=none
      highlight Repeat          guifg=#4a6a88 gui=none
      highlight Label           guifg=#4a6a88 gui=none
      highlight Keyword         guifg=#4a6a88 gui=none
      highlight Exception       guifg=#4a6a88 gui=none
      highlight Operator        guifg=#c0c0c0

      highlight Type            guifg=#888888 gui=none
      highlight StorageClass    guifg=#888888 gui=none
      highlight Structure       guifg=#888888 gui=none
      highlight Typedef         guifg=#888888 gui=none

      highlight PreProc         guifg=#606060
      highlight Include         guifg=#606060
      highlight Define          guifg=#606060
      highlight Macro           guifg=#606060
      highlight PreCondit       guifg=#606060

      highlight Special         guifg=#c0c0c0
      highlight Delimiter       guifg=#505050

      highlight StatusLine      guifg=#3a3a3a guibg=#0d0d0d gui=none
      highlight StatusLineNC    guifg=#1e1e1e guibg=#0d0d0d gui=none
      highlight MatchParen      guifg=#c0c0c0 guibg=#2a2a2a
      highlight Search          guifg=#0d0d0d guibg=#888888
      highlight IncSearch       guifg=#0d0d0d guibg=#aaaaaa
      highlight Error           guifg=#7a3030 guibg=#0d0d0d
      highlight ErrorMsg        guifg=#7a3030 guibg=#0d0d0d
      highlight WarningMsg      guifg=#888888 guibg=#0d0d0d
      highlight Todo            guifg=#888888 guibg=#0d0d0d
      highlight Pmenu           guifg=#c0c0c0 guibg=#111111
      highlight PmenuSel        guifg=#c0c0c0 guibg=#1e1e1e
      highlight PmenuSbar                     guibg=#1e1e1e
      highlight PmenuThumb                    guibg=#2e2e2e
      highlight NonText         guifg=#181818
      highlight SpecialKey      guifg=#181818
      highlight Folded          guifg=#606060 guibg=#0d0d0d
      highlight ColorColumn                   guibg=#111111
      highlight SpellBad        guifg=#7a3030 gui=underline

      highlight diffAdd         guifg=#4a6a4a guibg=#0d0d0d
      highlight diffDelete      guifg=#7a3030 guibg=#0d0d0d
      highlight diffChange      guifg=#686868 guibg=#0d0d0d
      highlight diffText        guifg=#888888 guibg=#111111
    '';
  };
}
