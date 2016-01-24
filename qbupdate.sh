#!/bin/bash
#
# [Quick Box Update Script]
#
# GitHub:   https://github.com/JMSDOnline/quick-box
# Author:   Jason Matthews
# URL:      https://jmsolodesigns.com/code-projects/quick-box/seedbox-installer
#
# 
#################################################################################
HOSTNAME1=$(hostname -s);
UPDATEURL="/root/tmp/quick-box-update-2.0.8/"
INETFACE=$(ifconfig | grep "Link encap" | sed 's/[ \t].*//;/^\(lo\|\)$/d' | awk '{ print $1 '});
QBVERSION="2.0.8"
RUTORRENT="/srv/rutorrent/"
OUTTO="/root/quickbox-update.log"
IP=$(curl -s http://ipecho.net/plain || curl -s http://ifconfig.me/ip ; echo)
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
  echo " version: ${QBVERSION}"
  echo
  echo "Updates will run silently. You can review the update log"
  echo "at ${OUTTO}."
  echo
  echo -n "${bold}${yellow}Are you ready to run the update?${normal} (${bold}${green}Y${normal}/n): "
  read responce
  case $responce in
    [yY] | [yY][Ee][Ss] | "" ) update=yes ;;
    [nN] | [nN][Oo] ) update=no ;;
  esac
}

clear

function _quickboxv() {
  curl -s -o /usr/bin/quickbox https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/quickbox
  chmod +x /usr/bin/quickbox
}

function _indexupdate() {
  cd "${RUTORRENT}home"
  cp -R "${UPDATEURL}home/" /srv/rutorrent/
  sed -i "s/eth0/${INETFACE}/g" /srv/rutorrent/home/index.php
  sed -i "s/qb-version/${QBVERSION}/g" /srv/rutorrent/home/index.php
  sed -i "s/ipaccess/${IP}/g" /srv/rutorrent/home/index.php
}

function _complete() {
  rm -rf /root/tmp/quick-box-update*
  echo "Update process ${green}COMPLETE${normal}"
}

export DEBIAN_FRONTEND=noninteractive

# QUICK BOX UPDATE STRUCTURE
_intro
_quickboxv
_indexupdate
_complete