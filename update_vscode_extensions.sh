#!/bin/bash

# Read list of my commonly installed vscode extensions from file
vsextensions_list=~/dev/git/dotfiles/vsextensions.list
while read vsExtension; do vsExtensions+=($vsExtension); done < $vsextensions_list

# Transform to array
declare -p vsExtensions

# Read installed vscode extensions
installed_extensions=$(code --list-extensions)

# Install missing vscode extensions only and update installed ones
for val in ${vsExtensions[@]}; do
   if [ ! "$(echo $installed_extensions | grep -q $val)" ]; then
      code --install-extension $val --force
   fi
done

