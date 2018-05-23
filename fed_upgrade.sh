#!/bin/bash

echo "Upgrading system to Fedora $1"

dnf clean all && dnf update -y
dnf --refresh upgrade -y
dnf system-upgrade download --releasever=$1 --allowerasing -y
