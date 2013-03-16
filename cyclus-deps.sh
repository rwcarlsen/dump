#!/bin/bash

# determine system type
SYSTEM=`uname -a`
DEPENDENCIES='poopy cmake libxml++2.6-dev libboost-dev libsqlite3-dev coinor-libcbc-dev'
if [[ `echo $SYSTEM | grep Ubuntu` ]]; then
  DEPENDENCIES='poopy cmake libxml++2.6-dev libboost-dev libsqlite3-dev coinor-libcbc-dev'
else
  echo "Unsupported operating system type $SYSTEM"
  exit 0
fi

# What dependencies are missing?
PKGSTOINSTALL=""
for DEP in $DEPENDENCIES
do
	if which dpkg &> /dev/null; then
		if [[ ! `dpkg -l | grep -w "ii  $DEP "` ]]; then
			PKGSTOINSTALL="$PKGSTOINSTALL $DEP"
      echo "Missing dep: ${PKGSTOINSTALL}"
		fi
	# OpenSuse, Mandriva, Fedora, CentOs, ecc. (with rpm)
	elif which rpm &> /dev/null; then
		if [[ ! `rpm -q $DEP` ]]; then
			PKGSTOINSTALL=$PKGSTOINSTALL" "$DEP
		fi
	# ArchLinux (with pacman)
	elif which pacman &> /dev/null; then
		if [[ ! `pacman -Qqe | grep "$DEP"` ]]; then
			PKGSTOINSTALL=$PKGSTOINSTALL" "$DEP
		fi
	# If it's impossible to determine if there are missing dependencies, mark all as missing
	else
		PKGSTOINSTALL=$PKGSTOINSTALL" "$DEP
	fi
done

echo $PKGTOINSTALL

# If some dependencies are missing, asks if user wants to install
if [ "$PKGSTOINSTALL" != "" ]; then
	echo -n "Some dependencies are missing. Want to install them? (Y/n): "
	read SURE
	# If user want to install missing dependencies
	if [[ $SURE = "Y" || $SURE = "y" || $SURE = "" ]]; then
		# Debian, Ubuntu and derivatives (with apt-get)
		if which apt-get &> /dev/null; then
			apt-get install $PKGSTOINSTALL
		# OpenSuse (with zypper)
		elif which zypper &> /dev/null; then
			zypper in $PKGSTOINSTALL
		# Mandriva (with urpmi)
		elif which urpmi &> /dev/null; then
			urpmi $PKGSTOINSTALL
		# Fedora and CentOS (with yum)
		elif which yum &> /dev/null; then
			yum install $PKGSTOINSTALL
		# ArchLinux (with pacman)
		elif which pacman &> /dev/null; then
			pacman -Sy $PKGSTOINSTALL
		# Else, if no package manager has been founded
		else
			# Set $NOPKGMANAGER
			NOPKGMANAGER=TRUE
			echo "ERROR: impossible to found a package manager in your sistem. Please, install manually ${DEPENDENCIES}."
		fi
		# Check if installation is successful
		if [[ $? -eq 0 && ! -z $NOPKGMANAGER ]] ; then
			echo "All dependencies are satisfied."
		# Else, if installation isn't successful
		else
			echo "ERROR: impossible to install some missing dependencies. Please, install manually ${DEPENDENCIES}."
		fi
	# Else, if user don't want to install missing dependencies
	else
		echo "WARNING: Some dependencies may be missing. So, please, install manually ${DEPENDENCIES}."
	fi
fi

