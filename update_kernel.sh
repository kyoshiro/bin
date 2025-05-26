#!/bin/bash
notify() {
    echo -ne "\e[1m[\e[31mKernel-Update\e[0m\e[1m] "
    echo -n "$1"
    echo -e "\e[0m"
}

post_pkg_postinst() {

    # Abort on error
    set -e
    
    # Avoid removing all versions of gentoo-sources
    #emerge --noreplace gentoo-sources
    
    # Select most current
    # eselect kernel set 1
    
    # Check if an upgrade is needed.
    new_kernel=$(readlink /usr/src/linux | sed 's/linux-//g')
    current_kernel=$(uname -r)
    if [ "$new_kernel" == "$current_kernel" ]; then
        # A kernel based on the most recent sources is already running
        notify "No upgrade needed."
    else
        # Upgrade is needed, continue....
        pushd /usr/src/linux
        
        # Copy old config
        notify "Upgrading to: $new_kernel"
        cp -v /usr/src/linux-$current_kernel/.config .
        
        # Create new config
        make olddefconfig

        # Build and install kernel
        make
	make modules_install
	make install
    fi
    
    if [ "$(eix '-I*' --format '<installedversions:NAMEVERSION>' gentoo-sources | wc -l)" -ne "1" ]; then
        notify "It's now save to remove old kernel sources..."
	notify "by executing 'emerge --deplean'"
    fi
}

post_pkg_postinst
