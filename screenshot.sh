#!/bin/sh
set -e
rm -rf .vim
cp -a vim .vim
git archive --format tar --prefix=.vim/ master | tar xf -
HOME=$PWD MYVIMRC= VIMINIT= mvim + screenshot.css
screencapture -W screenshot.png
open -a ImageOptim screenshot.png
rm -rf .vim
