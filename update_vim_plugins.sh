#!/bin/bash

plugdir=~/dev/git/vimplugins

for plug in `cat ~/dev/git/configfiles/vim.plugins.urls`
	do
		plugname=$(echo $plug | sed -e 's,https://.*/\(.*\).git,\1,g')
		echo "This plugin: $plugname";
		echo "Plugin URL: $plug";
		currplugdir=$plugdir/$plugname
		echo "$currplugdir"
		if [ -d "$currplugdir" ]; then
				cd $currplugdir
				git pull
		else
			cd $plugdir
			git clone $plug
		fi
done
