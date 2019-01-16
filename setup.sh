#!/usr/bin/env bash

set -e

cp gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

cd ~

cat << 'EOF' >> .bashrc
. /Users/albert/.nix-profile/etc/profile.d/nix.sh
. /Users/albert/miniconda3/etc/profile.d/conda.sh
export PS1="\n\[\e[1m\]\[\e[36m\][\w]$\[\e[m\]\[\e[0m\] "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls --color=auto'
alias ll='ls -al'
EOF

cat << 'EOF' >> .bash_profile
if [ -r ~/.bashrc ]; then
    source ~/.bashrc
fi
EOF

stem="https://raw.githubusercontent.com/albertgoncalves"

syntax_dir="./.vim/syntax"
if [ ! -e $syntax_dir ]; then
    mkdir -p $syntax_dir
fi

curl $stem"/haskell.vim/master/syntax/haskell.vim" > \
    $syntax_dir/haskell.vim
curl $stem"/typescript-vim/master/syntax/typescript.vim" > \
    $syntax_dir/typescript.vim
curl $stem"/stan.vim/master/syntax/stan.vim" > \
    $syntax_dir/stan.vim
curl $stem"/vim-nix/master/syntax/nix.vim" > \
    $syntax_dir/nix.vim

colors_dir="./.vim/colors"
if [ ! -e $colors_dir ]; then
    mkdir -p $colors_dir
fi

curl $stem"/gruvbox/master/colors/gruvbox.vim" > \
    $colors_dir/gruvbox.vim
curl $stem"/vim-desertink/master/colors/desertink.vim" > \
    $colors_dir/desertink.vim

cat << 'EOF' >> .vimrc
syntax on
set colorcolumn=80
set number
" set background=dark
colorscheme desertink
xnoremap <leader>b xi()<Esc>P
xnoremap <leader>c xi{}<Esc>P
xnoremap <leader>s xi[]<Esc>P
xnoremap <leader>q xi""<Esc>P
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * retab
set tabstop=4 shiftwidth=4 expandtab
vmap <leader>y :w! /tmp/vitmp<CR>
nmap <leader>p :r! cat /tmp/vitmp<CR>
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.stan setlocal filetype=stan
autocmd BufNewFile,BufRead *.nix setlocal filetype=nix
autocmd BufRead *.go retab
set cursorline
set laststatus=2
set statusline+=%F
set t_Co=256
" hi Normal ctermbg=232
" hi nonText ctermbg=238
" hi ColorColumn ctermbg=238
" hi CursorLine ctermbg=238
" hi LineNr ctermfg=243
" " hi LineNr ctermbg=234
hi Normal ctermbg=232
hi nonText ctermbg=234
hi ColorColumn ctermbg=234
hi CursorLine ctermbg=234
hi CursorLineNr ctermfg=255
hi LineNr ctermfg=243
hi LineNr ctermbg=234
EOF

# last line needed on the Pi!

cat << 'EOF' >> .tmux.conf
set-option -g default-shell "/bin/bash"
set -g default-terminal "xterm-256color"
set -g status-right '#(date +"%a, %b %d, %Y at %I:%M %p")'
setw -g mode-keys vi
bind-key -r -T prefix M-k resize-pane -U
bind-key -r -T prefix M-j resize-pane -D
bind-key -r -T prefix M-h resize-pane -L
bind-key -r -T prefix M-l resize-pane -R
EOF
