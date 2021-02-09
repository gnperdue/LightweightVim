#!/bin/bash

# Check to see if .vim and .vimrc already exist. If they do, archvie them
# into _bck files unless they are just symbolic links, in which case just
# remove the old links.

DAT=`date -u +%s`

if [ -e $HOME/.vimrc ]; then
  echo "Found existing .vimrc..."
  if [ -L $HOME/.vimrc ]; then
    echo "... removing symbolic link..."
    rm $HOME/.vimrc
  else
    mv $HOME/.vimrc $HOME/.vimrc_bck_$DAT
    echo "... making a backup..."
  fi
fi

if [ -e $HOME/.vim ]; then
  echo "Found existing .vim..."
  if [ -L $HOME/.vim ]; then
    echo "... removing symbolic link..."
    rm $HOME/.vim
  else
    echo "... making a backup..."
    mv $HOME/.vim $HOME/.vim_bck_$DAT
  fi
fi

echo "Making new symbolic links to here..."
ln -sv ${PWD}/vimrc $HOME/.vimrc
ln -sv ${PWD}/vim $HOME/.vim
