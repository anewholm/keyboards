#!/bin/bash

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
NC="$(tput sgr0)"  # No Color

linux_dist=`lsb_release -i 2> /dev/null | cut -d ":" -f 2 | sed -E 's/\s+//'`
linux_release=`lsb_release -r 2> /dev/null | cut -d ":" -f 2 | sed -E 's/\s+//'`
linux_codename=`lsb_release -c 2> /dev/null | cut -d ":" -f 2 | sed -E 's/\s+//'`
host_keyboards=`ls -1 ku-* | sed 's/ku-//'`
language="Kurmanjî (LATIN/Qamişlo)"

echo "${GREEN}INFO${NC}: Keyboard $language installation"
echo "OS Linux $linux_dist $linux_codename $linux_release"
echo "Keys normally (row-column):"
echo "  E-00(§½)=ş, E-12(´)=î"
echo "  D-11=û"
echo "  C-10=ç, C-11=ê"

# ------------------------------------ (K)Ubuntu
# Check supported
default_layout=
default_layout_location="/etc/default/keyboard"
if [ -f $default_layout_location ]; then
	default_layout=`grep XKBLAYOUT= $default_layout_location | cut -d "=" -f 2 | sed 's/"//g'`
	has_ku=`ls ku-$default_layout 2> /dev/null`
	if [ -z "$has_ku" ]; then
		echo "${RED}ERROR${NC}: Your [$default_layout] keyboard layout is not supported yet"
		echo "${GREEN}INFO${NC}: Installing anyway. You can manually setup if needed"
	else
		echo "${GREEN}INFO${NC}: [$default_layout] keyboard found and supported"
	fi
else
	echo "${RED}ERROR${NC}: Default keyboard settings file $default_layout_location not found. Support check skipped"
fi

# Install
definitions_location="/usr/share/X11/xkb/symbols/"
rules_location="/usr/share/X11/xkb/rules/evdev.xml"
if [ -d $definitions_location ]; then
	# Kurdish Keyboard alternatives
	if [ -f $definitions_location/ku-fi ]; then
        sudo cp ku-* $definitions_location
        echo "${YELLOW}WARN${NC}: Keyboards overwritten in $definitions_location"
	else
        sudo cp ku-* $definitions_location
        echo "${GREEN}INFO${NC}: Keyboard definitions installed in to $definitions_location"
    fi
    
	# Layouts XML update
	# Necessary to remove newlines from xml before injection in to sed command
	layouts_line=`cat evdev_kurdish.xml | tr -d '\n\t'`
	first_name=`grep \<name\> evdev_kurdish.xml | head -n 1 | cut -d ">" -f 2 | cut -d "<" -f 1`
	installed=`grep $first_name $rules_location`
	if [ -n "$installed" ]; then
        echo "${RED}ERROR${NC}: Keyboard rules seem to be already installed. Aborting"
        echo "Check file at $rules_location"
	else
        # Backup
        sudo cp $rules_location $rules_location-old
        echo "${GREEN}INFO${NC}: Backed-up rules file to $rules_location-old"
        # Install
        sudo sed -i "s@</layoutList>@  $layouts_line\n  </layoutList>@" $rules_location
        echo "${GREEN}INFO${NC}: Keyboard definition names linked in to $rules_location"
        echo "${GREEN}INFO${NC}: Keyboards successfully installed. To enable, goto:"
        echo '	System Settings >> Input Devices >> Keyboard >> Layouts >> + Add "Kurdish"'
    fi
else
	echo "${RED}ERROR${NC}: $definitions_location does not exist. Aborting"
	exit 1
fi

exit 0
