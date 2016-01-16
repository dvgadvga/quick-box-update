#!/bin/bash
#
# [Quick Box Update v1.6 Script]
#
# GitHub:   https://github.com/JMSDOnline/quick-box
# Author:   Jason Matthews
# URL:      https://jmsolodesigns.com/code-projects/quick-box/seedbox-installer
#
# 
#################################################################################
HOSTNAME1=$(hostname -s);
VERSION="1.6"
OUTTO="/root/quick-box-update-v1-6.log"
#################################################################################
#Script Console Colors
black=$(tput setaf 0); red=$(tput setaf 1); green=$(tput setaf 2); yellow=$(tput setaf 3); 
blue=$(tput setaf 4); magenta=$(tput setaf 5); cyan=$(tput setaf 6); white=$(tput setaf 7); 
on_red=$(tput setab 1); on_green=$(tput setab 2); on_yellow=$(tput setab 3); on_blue=$(tput setab 4); 
on_magenta=$(tput setab 5); on_cyan=$(tput setab 6); on_white=$(tput setab 7); bold=$(tput bold); 
dim=$(tput dim); underline=$(tput smul); reset_underline=$(tput rmul); standout=$(tput smso); 
reset_standout=$(tput rmso); normal=$(tput sgr0); alert=${white}${on_red}; title=${standout}; 
sub_title=${bold}${yellow}; repo_title=${black}${on_green};
#################################################################################

function _string() { perl -le 'print map {(a..z,A..Z,0..9)[rand 62] } 0..pop' 15 ; }

# Download packaged version 1.6 Quick Box
#curl -LO https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/v1-6/changelog.md >>"${OUTTO}" 2>&1

# Ask if user would like to update Plex
function _intro() {
  echo
  echo
  echo "${title} Welcome to the Quick Box update kit! ${normal}"
  echo " version: ${VERSION}"
  echo
  echo "The version 1.6 update caters to fixing a few minor (yet annoying) bugs"
  echo "that were occuring on multi-user intended environments. Additonal enhancements"
  echo "such as adding additional built-in functions for tasks such as upgrading"
  echo "included multi-media packages such as BTSync."
  echo
  echo "Updates will run silently. You can review the update log"
  echo "at ${OUTTO}."
  echo
  echo -n "${bold}${yellow}Are you ready to run the v1.6 update?${normal} (${bold}${green}Y${normal}/n): "
  read responce
  case $responce in
    [yY] | [yY][Ee][Ss] | "" ) update=yes ;;
    [nN] | [nN][Oo] ) update=no ;;
  esac
}

clear

function _bashrc() {
  curl -LO https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/v1-6/.bashrc >>"${OUTTO}" 2>&1
  curl -o /usr/bin/quickbox https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/v1-6/quickbox >>"${OUTTO}" 2>&1
  chmod +x /usr/bin/quickbox
}

function _diskspaceupdate() {
  curl -o /srv/rutorrent/plugins/diskspace/action.php https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/v1-6/action.php >>"${OUTTO}" 2>&1
  chown -R www-data: /srv/rutorrent/plugins/diskspace
}

function _complete() {
  echo "Update process ${green}COMPLETE${normal}"
}

_intro
_bashrc
_diskspaceupdate
_complete