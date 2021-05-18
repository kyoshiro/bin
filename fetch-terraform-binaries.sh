#!/bin/bash
#
# author: Roman Asendorf (roman.asendorf@gmail.com)
# version: 0.1 initial (2021-05-11)
#
# This script is intended to download all released terraform binaries
# for a specific architecture to a specified release version, beginning
# at version 0.12.0
#
# e.g. arch=linux_amd64, version=0.13.3 will download all binaries for
# linux_amd64 architecture till version 0.13.3
#
# if no architecture or version is specified the script will default to
# linux_amd64 and latest upstream release

# starting release version
starting_release_version=12

#max minor version
max_minor_release_version=31

# latest release version
latest_release_version=15

# latest release version
latest_version="0.15.3"

# default architecture
default_arch="linux_amd64"


while [ $# -gt 0 ]; do
  case "$1" in
    --arch*|-a*)
      if [[ "$1" != *=* ]]; then shift; fi
      arch="${1#*=}"
      ;;
    --version*|-v*)
      if [[ "$1" != *=* ]]; then shift; fi
      version="${1#*=}"
      ;;
    --help|-h)
      printf "Allowed parameters:\n"
      printf "--arch|-a=<arch>, with arch like darwin_amd,freebsd_386,freebsd_amd64,freebsd_arm,linux_arm,linux_386,linux_amd64,linux_armi\n"
      printf "--version|-v=<version>, with version like 0.13.3\n"
      printf "--help|-h, for this help\n"
      exit 0
      ;;
    *)
      >&2 printf "Error: Invalid argument\n"
      exit 1
      ;;
  esac
  shift
done

if [ "$version" = "" ]; then
	version=$latest_version
fi

if [ "$arch" = "" ]; then
	arch=$default_arch
fi

for ((release_version=$starting_release_version; release_version<=$latest_release_version;release_version++)); do
	for ((minor_release_version=0; minor_release_version<=$max_minor_release_version; minor_release_version++)); do
		current_version="0.$release_version.$minor_release_version"
		echo $current_version
		#wget + unzip + rename
		terraform_release_url="https://releases.hashicorp.com/terraform/"$current_version"/"
		terraform_release_zip="terraform_"$current_version"_"$arch".zip"
		terraform_url="$terraform_release_url$terraform_release_zip"
		terraform_bin_version="terraform.$current_version"
		if [ ! -f "$terraform_release_zip" ]; then
			wget $terraform_url
		fi
		if [ -f "$terraform_release_zip" ]; then
			if [ ! -f "$terraform_bin_version" ]; then
				unzip -o $terraform_release_zip && mv "terraform" "$terraform_bin_version"
			fi
		fi
		if [ "$current_version" = "$version" ]; then
			echo "Finishing @version=$version"
			exit 0
		fi
	done
done

