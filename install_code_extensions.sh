#!/bin/bash

# List of my commonly installed vscode extensions
declare -a StringArray=("jpogran.puppet-vscode" \
"ms-kubernetes-tools.vscode-kubernetes-tools" \
"ms-python.python" \
"redhat.vscode-yaml" \
"vscoss.vscode-ansible" \
"yzhang.markdown-all-in-one" \
"waderyan.gitblame" \
"eamodio.gitlens" \
"remisa.shellman")

# List installed vscode extensions
installed_extensions=$(code --list-extensions)

# Install missing vscode extensions only
for val in ${StringArray[@]}; do
   if [ ! "$(echo $installed_extensions | grep -q $val)" ]; then
      code --install-extension $val --force
   fi
done
