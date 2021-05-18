#!/bin/bash

theme=$1

sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface icon-theme $1
sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface cursor-theme $1
