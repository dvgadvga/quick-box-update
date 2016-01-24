case $- in
    *i*) ;;
      *) return;;
esac

BASHRCVERSION="23.2"
EDITOR=nano; export EDITOR=nano
USER=`whoami`
TMPDIR=$HOME/.tmp/
HOSTNAME=`hostname -s`
IDUSER=`id -u`
PROMPT_COMMAND='echo -ne "\033]0;${USER}(${IDUSER})@${HOSTNAME}: ${PWD}\007"'
export LS_COLORS='rs=0:di=01;33:ln=00;36:mh=00:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.log=02;34:*.torrent=02;37:*.conf=02;34:*.sh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.tlz=00;31:*.txz=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.dz=00;31:*.gz=00;31:*.lz=00;31:*.xz=00;31:*.bz2=00;31:*.tbz=00;31:*.tbz2=00;31:*.bz=00;31:*.tz=00;31:*.tcl=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.rar=00;31:*.ace=00;31:*.zoo=00;31:*.cpio=00;31:*.7z=00;31:*.rz=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.svg=00;35:*.svgz=00;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.flv=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.cgm=00;35:*.emf=00;35:*.axv=00;35:*.anx=00;35:*.ogv=00;35:*.ogx=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
export TERM=xterm;TERM=xterm
export PATH=/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/quick-box/.bin/
TPUT=`which tput`
BC=`which bc`
if [ ! -e $TPUT ]; then echo "tput is missing, please install it (yum install tput/apt-get install tput)";fi
if [ ! -e $BC ]; then echo "bc is missing, please install it (yum install bc/apt-get install bc)";fi
DFSCRIPT="${HOME}/.du.sh"
if [ ! -e $DFSCRIPT ]; then
cat >"$DFSCRIPT"<<'DS'
#!/bin/bash
ALERT=${BWhite}${On_Red};RED='\e[0;31m';YELLOW='\e[1;33m'
GREEN='\e[0;32m';RESET="\e[00m";BWhite='\e[1;37m';On_Red='\e[41m'
NCPU=$(grep -c 'processor' /proc/cpuinfo)
SLOAD=$(( 100*${NCPU} ));MLOAD=$(( 200*${NCPU} ));XLOAD=$(( 400*${NCPU} ))
function load() { SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.'); echo -n $((10#$SYSLOAD)); }
SYSLOAD=$(load)
if [ ${SYSLOAD} -gt ${XLOAD} ]; then echo -en ${ALERT}
elif [ ${SYSLOAD} -gt ${MLOAD} ]; then echo -en ${RED}
elif [ ${SYSLOAD} -gt ${SLOAD} ]; then echo -en ${YELLOW}
else echo -en ${GREEN} ;fi
let TotalBytes=0 
for Bytes in $(ls -l | grep "^-" | awk '{ print $5 }') 
do 
   let TotalBytes=$TotalBytes+$Bytes 
done
if [ $TotalBytes -lt 1024 ]; then
     TotalSize=$(echo -e "scale=1 \n$TotalBytes \nquit" | bc)
     suffix="b"
else if [ $TotalBytes -lt 1048576 ]; then
     TotalSize=$(echo -e "scale=1 \n$TotalBytes/1024 \nquit" | bc)
     suffix="kb"
  else if [ $TotalBytes -lt 1073741824 ]; then
     TotalSize=$(echo -e "scale=1 \n$TotalBytes/1048576 \nquit" | bc)
     suffix="Mb"
else
     TotalSize=$(echo -e "scale=1 \n$TotalBytes/1073741824 \nquit" | bc)
     suffix="Gb"
fi
fi
fi
echo $TotalSize$suffix
DS
chmod u+x $DFSCRIPT
fi

alias ls='ls --color=auto'
alias dir='ls --color=auto'
alias vdir='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

function normal { 
if [ `id -u` == 0 ] ; then
  DG="$(tput bold ; tput setaf 7)";LG="$(tput bold;tput setaf 7)";NC="$(tput sgr0)"
  export PS1='[\[$LG\]\u\[$NC\]@\[$LG\]\h\[$NC\]]:(\[$LG\]\[$BN\]$($DFSCRIPT)\[$NC\])\w\$ '
else
  DG="$(tput bold;tput setaf 0)"
  LG="$(tput setaf 7)"
  NC="$(tput sgr0)"
  export PS1='[\[$LG\]\u\[$NC\]@\[$LG\]\h\[$NC\]]:(\[$LG\]\[$BN\]$($DFSCRIPT)\[$NC\])\w\$ '
fi
}

case $TERM in
  rxvt*|screen*|cygwin)
    export PS1='\u\@\h\w'
  ;;
  xterm*|linux*|*vt100*|cons25)
    normal
  ;;
  *)
    normal
        ;;
esac

function rarit() { rar a -m5 -v1m $1 $1; }
function paste() { $* | curl -F 'sprunge=<-' http://sprunge.us ; }
function disktest() { dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync;rm -rf test ; }
function newpass() { perl -le 'print map {(a..z,A..Z,0..9)[rand 62] } 0..pop' 15 ; }
function fixhome() { chmod -R u=rwX,g=rX,o= "$HOME" ;}

transfer() { 
  if [ $# -eq 0 ]; then 
    echo "No arguments specified. Usage: transfer /tmp/test.md OR: cat /tmp/test.md | transfer test.md"
    return 1
  fi 
tmpfile=$(mktemp -t transferXXX )
if tty -s
  then 
    basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
  else 
    curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile 
fi
cat $tmpfile
rm -f $tmpfile
}

function swap() { 
local TMPFILE=tmp.$$
    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1
    mv "$1" $TMPFILE; mv "$2" "$1"; mv $TMPFILE "$2"
}

if [ -e /etc/bash_completion ] ; then source /etc/bash_completion; fi
if [ -e ~/.custom ]; then source ~/.custom; fi

function changeUserpass() {
REALM=rutorrent
HTPASSWD=/etc/htpasswd
echo -n "Username: "; read user
        username=$(echo "$user"|sed 's/.*/\L&/')
        if [[ ! $(grep "^${username}" ${HTPASSWD}) ]]; then 
    echo "Username ${username} wasnt found in ${HTPASSWD} .. please try again"
    exit
  fi
        echo -n "Password: (hit enter to generate a password) "; read password
        if [[ ! -z "${password}" ]]; then
                echo "setting password to ${password}"
                passwd=${password}
                echo "${username}:${passwd}" | chpasswd >/dev/null 2>&1
                sed -i "/${username}/ d" ${HTPASSWD}
                (echo -n "${username}:${REALM}:" && echo -n "${username}:${REALM}:${passwd}" | md5sum | awk '{print $1}' ) >> "${HTPASSWD}"
        else
                echo "setting password to ${genpass}"
                sed -i "/${username}/ d" ${HTPASSWD}
                passwd=${genpass}
                echo "${username}:${passwd}" | chpasswd >/dev/null 2>&1
                (echo -n "${username}:${REALM}:" && echo -n "${username}:${REALM}:${passwd}" | md5sum | awk '{print $1}' ) >> "${HTPASSWD}"
        fi
  echo "$username : $passwd" >>/root/${username}.txt
}


function setdisk() {
echo -n "Username: "
read username
echo "Quota size for user: (EX: 500GB): "
read SIZE
case $SIZE in
  *TB)
    QUOTASIZE=$(echo $SIZE|cut -d'T' -f1)
    DISKSIZE=$(($QUOTASIZE * 1024 * 1024 * 1024))
    setquota -u ${username} ${DISKSIZE} ${DISKSIZE} 0 0 -a
  ;;
  *GB)
    QUOTASIZE=$(echo $SIZE|cut -d'G' -f1)
    DISKSIZE=$(($QUOTASIZE * 1024 * 1024))
    setquota -u ${username} ${DISKSIZE} ${DISKSIZE} 0 0 -a
  ;;
  *MB)
    QUOTASIZE=$(echo $SIZE|cut -d'M' -f1)
                DISKSIZE=$(($QUOTASIZE * 1024))
                setquota -u ${username} ${DISKSIZE} ${DISKSIZE} 0 0 -a
  ;;
  *)
    echo "Disk Space MUST be in GB/TB, Example: 711GB OR 2.5TB, Exiting script, type bash $0 and try again";exit 0
  ;;
esac
}
function createSeedboxUser() {
OK=`echo -e "[\e[0;32mOK\e[00m]"`
realm="rutorrent"
htpasswd="/etc/htpasswd"
genpass=$(perl -le 'print map {(a..z,A..Z,0..9)[rand 62] } 0..pop' 15)
ruconf="/srv/rutorrent/conf/users"
IRSSI_PASS=$(perl -le 'print map {(a..z,A..Z,0..9)[rand 62] } 0..pop' 15)
IRSSI_PORT=$((RANDOM%64025+1024))
#PORT=$(($RANDOM + ($RANDOM % 2) * 32768))
PORT=$(shuf -i 2000-61000 -n 1)
PORTEND=$(($PORT + 1500))
#RPORT=$(($PORT + 1500))
RPORT=$(shuf -i 2000-61000 -n 1)
ip=$(curl -s http://ipecho.net/plain || curl -s http://ifconfig.me/ip ; echo)
# --END HERE --
echo -n "Username: "; read username
  if grep -Fxq "$username" /etc/passwd; then
    echo "$username exists! cant proceed..."
    exit
  else
    useradd -m -k /etc/skel/ $username -s /usr/bin/lshell
    echo -n "Password: (hit enter to generate a password) ";read password
    chown $username.www-data /home/$username >/dev/null 2>&1
    cp $htpasswd /root/rutorrent-htpasswd.`date +'%d.%m.%y-%S'`
    if [[ "$password" == "" ]]; then
      echo "setting password to $genpass"
      echo "${username}:${genpass}" | chpasswd >/dev/null 2>&1
      (echo -n "$username:$realm:" && echo -n "$username:$realm:$genpass" | md5sum | awk '{print $1}' ) >> $htpasswd
      echo "${username} : $genpass" >/root/${username}.info
    else
      echo "using $password"
      echo "${username}:${password}" | chpasswd >/dev/null 2>&1
      (echo -n "$username:$realm:" && echo -n "$username:$realm:$password" | md5sum | awk '{print $1}' ) >> $htpasswd
      echo "${username} : $password " >/root/${username}.info
  fi
  echo "Quota size for user: (EX: 500GB): "
  read SIZE
  case $SIZE in
    *TB)
      QUOTASIZE=$(echo $SIZE|cut -d'T' -f1)
      DISKSIZE=$(($QUOTASIZE * 1024 * 1024 * 1024))
      setquota -u ${username} ${DISKSIZE} ${DISKSIZE} 0 0 -a
      echo "$SIZE" >>/root/${username}.info
    ;;
    *GB)
      QUOTASIZE=$(echo $SIZE|cut -d'G' -f1)
      DISKSIZE=$(($QUOTASIZE * 1024 * 1024))
      setquota -u ${username} ${DISKSIZE} ${DISKSIZE} 0 0 -a
      echo "$SIZE" >>/root/${username}.info
    ;;
    *)
      echo "Disk Space MUST be in GB/TB, Example: 711GB OR 2.5TB, Exiting script, type bash $0 and try again";exit 0
    ;;
  esac

echo -n "writing $username .rtorrent.rc using port-range (${PORT}-${PORTEND})..."
cat >/home/$username/.rtorrent.rc<<RC
# -- START HERE --
scgi_port = localhost:$RPORT
min_peers = 1
max_peers = 100
min_peers_seed = -1
max_peers_seed = -1
max_uploads = 100
download_rate = 0
upload_rate = 0
directory = /home/${username}/torrents/
session = /home/${username}/.sessions/
schedule = watch_directory,5,5,load_start=/home/${username}/rwatch/*.torrent
schedule = filter_active,5,5,"view_filter = active,d.get_up_rate="
view_add = alert
view_sort_new = alert,less=d.get_message=
schedule = filter_alert,30,30,"view_filter = alert,d.get_message=; view_sort = alert"
port_range = $PORT-$PORTEND
use_udp_trackers = yes
encryption = allow_incoming,try_outgoing,enable_retry
peer_exchange = no
check_hash = no
execute_nothrow=chmod,777,/home/${username}/.sessions/
# -- END HERE --

RC
echo $OK
echo -n "setting permissions ... "
  chown $username.www-data /home/$username/{torrents,.sessions,watch,.rtorrent.rc} >/dev/null 2>&1
  usermod -a -G www-data $username >/dev/null 2>&1
  usermod -a -G $username www-data >/dev/null 2>&1
  chmod 777 /home/${username}/.sessions >/dev/null 2>&1
echo $OK
echo -n "writing $username rtorrent/irssi cron script ... "
cat >/home/${username}/.startup<<SU
#!/bin/bash
export USER=\$(id -un)
IRSSI_CLIENT=yes
RTORRENT_CLIENT=yes
WIPEDEAD=yes
ADDRESS=$(curl -s http://ipecho.net/plain || curl -s http://ifconfig.me/ip ; echo)

# NO NEED TO EDIT PAST HERE!
if [ "$WIPEDEAD" == "yes" ]; then screen -wipe >/dev/null 2>&1; fi

if [ "\$IRSSI_CLIENT" == "yes" ]; then 
  (screen -ls|grep irssi > /dev/null || (screen -fa -dmS irssi irssi && false))
fi

if [ "\$RTORRENT_CLIENT" == "yes" ]; then 
  (screen -ls|grep rtorrent >/dev/null || (screen -fa -dmS rtorrent rtorrent && false))
fi
SU
  chown ${username}.${username} /home/${username}/.startup >/dev/null 2>&1
  chmod +x /home/${username}/.startup >/dev/null 2>&1
echo $OK
echo -n "enabling $username cron script ... "
  mkdir "/srv/rutorrent/conf/users/${username}" >/dev/null 2>&1
  mkdir -p /srv/rutorrent/conf/users/"${username}"/plugins/fileupload/ >/dev/null 2>&1
  cp /srv/rutorrent/plugins/fileupload/conf.php /srv/rutorrent/conf/users/"${username}"/plugins/fileupload/conf.php >/dev/null 2>&1
  chown -R www-data: /srv/rutorrent/conf/users/"${username}" >/dev/null 2>&1
  chown $username.$username /home/$username/.startup >/dev/null 2>&1
  sudo -u $username chmod +x /home/$username/.startup  >/dev/null 2>&1
  sudo -u $username chmod 750 /home/$username/ >/dev/null 2>&1
  chown -R $username.www-data /home/${username} >/dev/null 2>&1
echo $OK
echo -n "writing $username rutorrent config.php ... "
  mkdir $ruconf/$username >/dev/null 2>&1
cat >$ruconf/$username/config.php<<DH
<?php
  @define('HTTP_USER_AGENT', 'Mozilla/5.0 (Windows NT 6.0; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0', true);
  @define('HTTP_TIME_OUT', 30, true);
  @define('HTTP_USE_GZIP', true, true);
  \$httpIP = null;
  @define('RPC_TIME_OUT', 5, true);
  @define('LOG_RPC_CALLS', false, true);
  @define('LOG_RPC_FAULTS', true, true);
  @define('PHP_USE_GZIP', false, true);
  @define('PHP_GZIP_LEVEL', 2, true);
  \$schedule_rand = 10;
  \$do_diagnostic = true;
  \$log_file = '/tmp/errors.log';
  \$saveUploadedTorrents = true;
  \$overwriteUploadedTorrents = false;
  \$topDirectory = '/home/$username/';
  \$forbidUserSettings = false;
  \$scgi_port = $RPORT;
  \$scgi_host = "localhost";
  \$XMLRPCMountPoint = "/RPC2";
  \$pathToExternals = array("php" => '',"curl" => '',"gzip" => '',"id" => '',"stat" => '',);
  \$localhosts = array("127.0.0.1", "localhost",);
  \$profilePath = '../share';
  \$profileMask = 0777;
  \$diskuser = '/';
  \$quotaUser = '${username}';
  \$autodlPort = $IRSSI_PORT;
  \$autodlPassword = "$IRSSI_PASS";
DH
echo $OK

fi
echo -n "Setting up autodl-irssi for $username ... "
mkdir -p /home/$username/.autodl >/dev/null 2>&1
touch /home/$username/.autodl/autodl.cfg >/dev/null 2>&1
cat >/home/$username/.autodl/autodl.cfg<<ADC
[options]
gui-server-port = $IRSSI_PORT
gui-server-password = $IRSSI_PASS
ADC

echo $OK
sudo -u $username /home/$username/.startup >/dev/null 2>&1
command1="*/1 * * * * /home/${username}/.startup"
cat <(fgrep -iv "${command1}" <(sh -c 'sudo -u ${username} crontab -l' >/dev/null 2>&1)) <(echo "${command1}") | sudo -u ${username} crontab -
cat >/etc/apache2/sites-enabled/alias.${username}.download.conf<<AS
Alias /${username}.downloads "/home/${username}/torrents/"
  <Directory "/home/${username}/torrents/">
   Options Indexes FollowSymLinks MultiViews
    AllowOverride None
          AuthType Digest
          AuthName "rutorrent"
          AuthUserFile '/etc/htpasswd'
          Require valid-user
    Order allow,deny
    Allow from all
  </Directory>
AS

cat >/etc/apache2/sites-enabled/alias.${username}.console.conf<<CS
Alias /${username}.console "/home/${username}/.console/"
<Directory "/home/${username}/.console/">
  Options Indexes FollowSymLinks MultiViews
  AuthType Digest
  AuthName "rutorrent"
  AuthUserFile '/etc/htpasswd'
  Require valid-user
  AllowOverride None
  Order allow,deny
  allow from all
</Directory>
CS

cat >>/etc/apache2/sites-enabled/scgimount.conf<<SC
SCGIMount /${username} 127.0.0.1:$RPORT
SC

sed -i -e "s/console-username/${username}/g" \
       -e "s/console-password/${password}/g" \
       -e "s/ipaccess/${ip}/g" /home/${username}/.console/index.php

service apache2 reload >/dev/null 2>&1

}
function deleteSeedboxUser() {

rutorrent="/srv/rutorrent"
htpasswd="/etc/htpasswd"
OK=$(echo -e "[ \e[0;32mDONE\e[00m ]")

echo -n "Username: "
read username
if [[ -z ${username} ]]
  then echo "you want me to delete nothing? next time enter a username";exit
fi
echo -n "Deleting ${username} /home and rutorrent data ... "
userdel -rf ${username} >/dev/null 2>&1
groupdel ${username} >/dev/null 2>&1
sed -i '/^$username/d' ${htpasswd}
rm -rf /etc/apache2/sites-enabled/alias.${username}.download.conf  >/dev/null 2>&1
rm -rf ${rutorrent}/conf/users/${username} >/dev/null 2>&1
rm -rf ${rutorrent}/share/users/${username} >/dev/null 2>&1
rm -rf /var/spool/cron/crontabs/${username} >/dev/null 2>&1
rm -rf /home/${username} >/dev/null 2>&1
rm -rf /var/run/screens/S-${username} >/dev/null 2>&1
rm -rf /etc/openvpn/server-${username}.conf >/dev/null 2>&1
service apache2 reload
echo ${OK}
}

function upgradeBTSync() {
  echo -n "${yellow}Please enter the username of your master account below${normal}"
  echo
  echo "(This is the username you created on install)"
  echo
  read -p "${bold}Master Account Username ${normal} : " username
  if [[ ! $(grep "^${username}" ${HTPASSWD}) ]]; then 
    echo "Username ${username} wasnt found ... please check your username and try again"
    exit 1
  fi
  ip=$(curl -s http://ipecho.net/plain || curl -s http://ifconfig.me/ip ; echo)
  echo -ne "${yellow}Would you like to upgrade BTSync?${normal} (Y/n): (Default: ${green}Y${normal}) "; read responce
  case $responce in
    [yY] | [yY][Ee][Ss] | "")
    echo -n "Installing and Upgrading BTSync ... "
      killall btsync
      wget -qq https://github.com/JMSDOnline/quick-box/raw/master/sources/btsync.latest.tar.gz . >>"${OUTTO}" 2>&1
      tar xf btsync.latest.tar.gz -C /home/"${username}"/ >>"${OUTTO}" 2>&1
      sudo -u "${username}" /home/"${username}"/btsync --webui.listen $ip:8888 >>"${OUTTO}" 2>&1
      rm -rf btsync.latest.tar.gz >>"${OUTTO}" 2>&1
    echo "${OK}"
    ;;
    [nN] | [nN][Oo] ) echo "Skipping ... " ;;
    *) echo "${cyan}Skipping BTSync install${normal} ... " ;;
  esac
  echo
  echo "${green}Congrats! Upgrade is complete - Enjoy${normal}"
  echo
  echo
}

function upgradePlex() {
  apt-get install -yqq --force-yes --only-upgrade plexmediaserver
  service plexmediaserver restart
}