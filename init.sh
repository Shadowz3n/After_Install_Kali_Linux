#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
bold=`tput bold`
reset=`tput sgr0`
tput clear

echo -e "${red}${bold}[Editing]${reset}	${green}/etc/apt/sources.list ${reset}"

cat <<EOF > /tmp/first_time_kali_file.sh
deb http://http.kali.org/ /kali main contrib non-free
deb http://http.kali.org/ /wheezy main contrib non-free
deb http://http.kali.org/kali kali-dev main contrib non-free
deb http://http.kali.org/kali kali-dev main/debian-installer
deb-src http://http.kali.org/kali kali-dev main contrib non-free
deb http://http.kali.org/kali kali main contrib non-free
deb http://http.kali.org/kali kali main/debian-installer
deb-src http://http.kali.org/kali kali main contrib non-free
deb http://security.kali.org/kali-security kali/updates main contrib non-free
deb-src http://security.kali.org/kali-security kali/updates main contrib non-free
EOF

mv /tmp/first_time_kali_file.sh /etc/apt/sources.list

echo -e "${red}${bold}[Updating]${reset}	${green}/etc/apt/sources.list ${reset}"
apt-get update > /dev/null

if [ -d /opt/sqlmap ]
then
	echo -e "${bold}${green}SQLMap [OK]${reset}"
else
	cd /opt
	echo -e "${red}${bold}[Downloading]${reset}  ${green}SQLMap${reset}"
	git clone -q https://github.com/sqlmapproject/sqlmap
fi

if [ -d /opt/google ]
then
	echo -e "${bold}${green}Google Chrome [OK]{reset}"
else
	cd /tmp
	
	function get_google_chrome(deb){
		echo -e "${red}${bold}[Downloading]${reset}  ${green}Google Chrome${reset}"
		wget -q "https://dl.google.com/linux/direct/${deb}
		echo -e "${bold}${green}[Installing]${reset} ${green}Google Chrome${reset}"
		dpkg -i ${deb} > /dev/null
		echo -e "${bold}${green}Google Chrome [OK]${reset}"
	}
	
	if [ `getconf LONG_BIT` = "64" ]
	then
		get_google_chrome("google-chrome-stable_current_amd64.deb")
	else
		get_google_chrome("google-chrome-stable_current_i386.deb")
	fi
fi

echo -e "${bold}${green}[Kali Linux is Ready]${reset}"
tput bel
exit
