#!/bin/bash
#
# [Quick Box Update v1.3 Script]
#
# GitHub:   https://github.com/JMSDOnline/quick-box
# Author:   Jason Matthews
# URL:      https://jmsolodesigns.com/code-projects/quick-box/seedbox-installer
#
# 

HOSTNAME1=$(hostname -s);
VERSION="1.3"
OUTTO="/root/quick-box-update-v1-3.log"

#Script Console Colors
black=$(tput setaf 0);red=$(tput setaf 1);green=$(tput setaf 2);yellow=$(tput setaf 3);blue=$(tput setaf 4);magenta=$(tput setaf 5);cyan=$(tput setaf 6);white=$(tput setaf 7);on_red=$(tput setab 1);on_green=$(tput setab 2);on_yellow=$(tput setab 3);on_blue=$(tput setab 4);on_magenta=$(tput setab 5);on_cyan=$(tput setab 6);on_white=$(tput setab 7);bold=$(tput bold);dim=$(tput dim);underline=$(tput smul);reset_underline=$(tput rmul);standout=$(tput smso);reset_standout=$(tput rmso);normal=$(tput sgr0);alert=${white}${on_red};title=${standout};sub_title=${bold}${yellow};repo_title=${black}${on_green};

function _string() { perl -le 'print map {(a..z,A..Z,0..9)[rand 62] } 0..pop' 15 ; }

# Download packaged version 1.3 Quick Box
curl -LO https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/v1-3/changelog.md >>"${OUTTO}" 2>&1

# Ask if user would like to update Plex
function _intro() {
  echo
  echo
  echo "${title} Welcome to the Quick Box update kit! ${normal}"
  echo " version: ${VERSION}"
  echo
  echo "Several changes had been made. Of these updates the largest"
  echo "commit to Quick Box was the enhanced feature of Plex."
  echo "Plex now comes as a Public facing function - meaning there"
  echo "is no longer a need to figure out complicated Tunneling via ssh."
  echo
  echo "If you do not have Plex installed - nor care do you care to"
  echo "run the Plex update, you may simply select (${red}N${normal}) when the"
  echo "question presents itself."
  echo
  echo "The rest of the updates will run silently. You can review the update log"
  echo "at ${OUTTO}."
  echo
  echo "Let's review real quick some of the changes that version 1.3"
  echo "brings in."
  echo
  echo
  echo -n "${bold}${yellow}Are you ready to run the v1.3 update?${normal} (${bold}${green}Y${normal}/n): "
  read responce
  case $responce in
    [yY] | [yY][Ee][Ss] | "" ) update=yes ;;
    [nN] | [nN][Oo] ) update=no ;;
  esac
}

clear


# function to adjust apache permissions (30)
function _adjustapache() {
  sed -i 's/www-data     ALL=(ALL:ALL) NOPASSWD: \/usr\/bin\/quota, \/usr\/sbin\/repquota, \/usr\/bin\/reload, \/bin\/sed, \/usr\/bin\/pkill, \/usr\/bin\/killall/www-data     ALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers
}

# function to ask for plexmediaserver (30)
function _askplex() {
  echo -ne "${yellow}Would you like to install and update Plex Media Server${normal} (Y/n): (Default: ${red}N${normal}) "; read responce
  case $responce in
    [yY] | [yY][Ee][Ss] )
    echo -n "Installing and Updating Plex ... "
      curl -o /srv/rutorrent/home/index.php.new https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/v1-3/index.php >>"${OUTTO}" 2>&1
      mv /srv/rutorrent/home/index.php /srv/rutorrent/home/index.php.v1.bak
      mv /srv/rutorrent/home/index.php.new /srv/rutorrent/home/index.php
      echo "ServerName ${HOSTNAME1}" | sudo tee /etc/apache2/conf-available/fqdn.conf >>"${OUTTO}" 2>&1
      sudo a2enconf fqdn >>"${OUTTO}" 2>&1
      touch /etc/apache2/sites-enabled/plex.conf
      chown www-data: /etc/apache2/sites-enabled/plex.conf
      echo "deb http://shell.ninthgate.se/packages/debian squeeze main" > /etc/apt/sources.list.d/plexmediaserver.list
      curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key >>"${OUTTO}" 2>&1 | sudo apt-key add - >>"${OUTTO}" 2>&1
      apt-get update >>"${OUTTO}" 2>&1
      apt-get install -qq --yes --force-yes plexmediaserver >>"${OUTTO}" 2>&1
      service plexmediaserver restart >>"${OUTTO}" 2>&1
      echo "${OK}"
      ;;
    [nN] | [nN][Oo] | "") echo "${cyan}Skipping Plex install${normal} ... " ;;
    *) echo "${cyan}Skipping Plex install${normal} ... " ;;
  esac
}

function _bashrc() {
  curl -LO https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/v1-3/.bashrc >>"${OUTTO}" 2>&1
}

function _checkcss() {
  cd /srv/rutorrent/home/skins
  curl -o /srv/rutorrent/home/skins/quick.css.new https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/v1-3/quick.css >>"${OUTTO}" 2>&1
  mv /srv/rutorrent/home/skins/quirk.css /srv/rutorrent/home/skins/quirk.css.v1.bak
  mv /srv/rutorrent/home/skins/quick.css.new /srv/rutorrent/home/skins/quick.css
}

function _lshell() {
cat >/etc/lshell.conf<<'LS'
[global]
logpath         : /var/log/lshell/
loglevel        : 2

[default]
allowed         : ['cd','cp','-d','-dmS','git','irssi','ll','ls','-m','mkdir','mv','nano','pwd','-R','rm','rtorrent','rsync','-S','scp','screen','tar','unrar','unzip','nano','wget']
forbidden       : [';', '&', '|','`','>','<', '$(', '${','sudo','vi','vim','./']
warning_counter : 2
aliases         : {'ls':'ls --color=auto','ll':'ls -l'}
intro           : "== Seedbox Shell ==\nWelcome To Your Quick Box Seedbox Shell\nType '?' to get the list of allowed commands"
home_path       : '/home/%u'
env_path        : ':/usr/local/bin:/usr/sbin'
allowed_cmd_path: ['/home/']
scp             : 1
sftp            : 0
overssh         : ['ls', 'rsync','scp']
LS
}

function _complete() {
  for i in apache2 fail2ban vsftpd; do
    service $i restart >>"${OUTTO}" 2>&1
    systemctl enable $i >>"${OUTTO}" 2>&1
  done

  echo "Update process ${green}COMPLETE${normal}"
}

_intro
_askplex
_bashrc
_checkcss
_lshell
_complete