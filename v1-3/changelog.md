###Changelog for version 1.3 of Quick Box

  * .bashrc - The bashrc file is located within your /root/ directory. This file is the once responsible for many of the commands that you may put to use on your Quick Box seedbox install. Of all these commands, there was but one that was presenting a problem in v1.2. That was the 'changeUserpass' command. 
  The Problem   : Changing a users password would create complications for the user to login afterwards. This was due to the user having a duplicated set of username and password hashes within the /etc/htpasswd file.
  The Solution  : I have written the proper sed command to be fired at user password change. This sed command will remove the last know users password and hash entry from the file before echoing in the new username and password hash.

  * LShell - LShell -or- Limited Shell is a user environment written in python that allows us to restrict a users shell environment to certain commands that we approve. 
  The problem   : Aditional added users could break out of their /home/${username} directories by connectiong to VSFTPd on port 4747 (SFTP). This would give the additional user the ability to browse the entire server.
  The Solution  : Set SFTP options to '0' in the lshell.conf file. This file is located at /etc/lshell.conf if you would like to take a look at it's settings.

  * Plex Public Access  : This one is exciting as it adds in the ability to simply enable (switch on) and disable (switch off) Plex Access WITHOUT the need for creating a tunnel on your local computer. Understandably, for some this is too much of a hassle to enjoy Plex as they prefer to simply watch TV and Movies directly from their server (permitting their network and hardware is suitable). You may opt to enable it when you are wanting to watch it (Public Access - no login required) and disable it when you want to secure your Plex Media Server (Deletes a custom plex.conf file in the apache2/site-enabled directory, thus hiding Plex from Public Access)

  * Dashboard index.php update - To aid in this updated function of Plex, there were a few minor changes that needed to be made to the index file as it uses custom shell hooks via php to make this possible. Is it safe? I wouldn't be doing this if it wasn't!

  Here's a question --- "I have plex from your version 1.0 installed. I think that version was built from source. Your update looks like it adds a Debian ppa to the sources.list and runs an install. Will this affect my current Plex?"

  Here's an answer --- "No, the built-from-source Plex will stay as it is. Since PlexMediaServer is already installed (and more than likely out-of-date) the ppa will simply pickup that Plex is already installed and rather than attempting to install, it will merely run an update... thus making future updates a breeze (ex: apt-get install --only-upgrade plexmediaserver"