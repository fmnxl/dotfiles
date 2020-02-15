#!/bin/bash
dir="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo $dir
files="bash_profile vimrc"

for file in $files; do
  echo "=> $file"
  if [ -f "$HOME/.$file" ]; then
    echo "...Backing up to $file.bak"
    mv $HOME/.$file $HOME/.$file.bak
  fi
  echo "...Creating symlink in home directory."
  ln -s $dir/$file $HOME/.$file
done

