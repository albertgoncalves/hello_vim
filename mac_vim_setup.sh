#!/usr/bin/env bash

cd ~

# echo "export PS1=\"\t \w $ \"" >> .bash_profile
# echo "export CLICOLOR=1"     >> .bash_profile
# echo "export PS1=\"\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ \""
# echo "export CLICOLOR=1"
# echo "export LSCOLORS=ExFxBxDxCxegedabagacad"
# echo "alias ls='ls -GFh'"

mkdir -p .vim/syntax
curl "https://raw.githubusercontent.com/albertgoncalves/haskell.vim/master/syntax/haskell.vim" > .vim/syntax/haskell.vim

mkdir .vim/colors
curl "https://raw.githubusercontent.com/albertgoncalves/Gummybears/master/colors/gummybears.vim" > .vim/colors/gummybears.vim

git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/tmp/typescript-vim
cp ~/.vim/tmp/typescript-vim/syntax/typescript.vim ~/.vim/syntax/
yes | rm -R ~/.vim/tmp/typescript-vim

echo "syntax on"                                                     > .vimrc
echo "set colorcolumn=80"                                           >> .vimrc
echo "set number"                                                   >> .vimrc
echo "colorscheme gummybears"                                       >> .vimrc
echo "highlight ColorColumn ctermbg=7"                              >> .vimrc
echo "xnoremap <leader>b xi()<Esc>P"                                >> .vimrc
echo "xnoremap <leader>c xi{}<Esc>P"                                >> .vimrc
echo "xnoremap <leader>s xi[]<Esc>P"                                >> .vimrc
echo "xnoremap <leader>q xi""<Esc>P"                                >> .vimrc
echo "autocmd BufWritePre * %s/\s\+$//e"                            >> .vimrc
echo "set tabstop=4 shiftwidth=4 expandtab"                         >> .vimrc
echo "vmap <leader>y :w! /tmp/vitmp<CR>"                            >> .vimrc
echo "nmap <leader>p :r! cat /tmp/vitmp<CR>"                        >> .vimrc
echo "autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript" >> .vimrc
