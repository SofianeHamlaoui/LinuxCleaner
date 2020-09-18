#!/bin/bash
# Sofiane Hamaloui 2020
#Github: https://github.com/SofianeHamlaoui

# Colors
b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
y='\E[33m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
enda='\033[0m'

function space {
    echo ""
}

trap ctrl_c INT
function ctrl_c() {
    space
    echo -e "                   ${r} Do you want to leave the script ?${endc}"
    read -p "                                (Y/N) :  "   yn
    case $yn in
        [Yy]* ) exit;;
        [Nn]* ) cleanit;;
        * ) cleanit;;
    esac
    space
}

function showlogo {
    clear
echo """
 _                     _   ______  _                                   
| |                   (_) / _____)| |                                  
| |      _   _  ____   _ | /      | |  ____  ____  ____    ____   ____ 
| |     | | | ||  _ \ | || |      | | / _  )/ _  ||  _ \  / _  ) / ___)
| |_____| |_| || | | || || \_____ | |( (/ /( ( | || | | |( (/ / | |    
|_______)\____||_| |_||_| \______)|_| \____)\_||_||_| |_| \____)|_|    
                    Sofiane Hamlaoui | 2020
""";
    echo
}



function checkroot {
  showlogo
  if [[ $(id -u) = 0 ]]; then
    echo -e " Checking For ROOT: ${g}PASSED${endc}"
    space
  else
    echo -e " Checking For ROOT: ${r}FAILED${endc}
 ${y}This Script Needs To Run As ROOT${endc}"
    echo ""
    echo -e " ${g}LuniCleaner${enda} Will Now Exit"
    space
    sleep 1
    exit
  fi
}
function checkreq {
    which $1 > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        echo -e " ${c} $1 ${enda}Found !!"
    else
        echo -e " ${g} $1 not found, installing it ...${endc}"
        space
        pacman -S python
    fi
}
function Lapt {
    which apt > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        echo -e "   ${g} [S] Apt-Based Distribution detected ${endc}"
        sleep 1
        space
        # Syncing
        echo -e "   ${g} [-] Syncing Database ${endc}"
        apt-get update
        space
        # Cleaning
        echo -e "   ${g} [-] Cleaning Apt's Cache${endc}"
        space
        echo -e "   ${r} [X] Be Careful, this eliminates the possibility of using downgrade${endc}"
        echo -e "   ${r} [X] Do yo want to clean Apt's cache ?${endc}"
        read -p "                           (Y/N) : " choice 
        case "$choice" in 
            y|Y )
                apt clean;;
            n|N ) ;;
            * ) ;;
        esac
        # Removing unused packages
        echo -e "   ${g} [-] Removing unused packages${endc}"
        space
        echo -e "   ${r} [X] Do yo want to Remove unused packages ?${endc}"
        read -p "                           (Y/N) : " choice 
        case "$choice" in 
            y|Y )
                apt-get autoremove --purge;;
            n|N ) ;;
            * ) ;;
        esac
        # Runing rmshit script
        echo -e "   ${g} [-] Running RMshit script by Jakub Klinkovský @lahwaacz${endc}"
        space
        echo -e "   ${r} [X] Do you want to use Rmshit.py script ?${endc}"
        read -p "                           (Y/N) : " choice 
        case "$choice" in 
            y|Y )
                curl -O https://raw.githubusercontent.com/lahwaacz/Scripts/master/rmshit.py && python3 rmshit.py;;
            n|N ) ;;
            * ) ;;
        esac
    fi

}

function Lpacman {
    which pacman > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        echo -e "   ${g} [S] Pacman-Based Distribution detected ${endc}"
        sleep 1
        space
        # Syncing
        echo -e "   ${g} [-] Syncing Database ${endc}"
        pacman -Syy
        space
        # Cleaning
        echo -e "   ${g} [-] Cleaning Pacman's Cache${endc}"
        space
        echo -e "   ${r} [X] Be Careful, this eliminates the possibility of using downgrade${endc}"
        echo -e "   ${r} [X] Do yo want to clean Pacman's cache ?${endc}"
        read -p "                           (Y/N) : " choice 
        case "$choice" in 
            y|Y )
                pacman -Scc;;
            n|N ) ;;
            * ) ;;
        esac
        # Removing unused packages
        echo -e "   ${g} [-] Removing unused packages${endc}"
        space
        echo -e "   ${r} [X] Do yo want to Remove unused packages ?${endc}"
        read -p "                           (Y/N) : " choice 
        case "$choice" in 
            y|Y )
                pacman -Rns $(pacman -Qtdq);;
            n|N ) ;;
            * ) ;;
        esac
        # Runing rmshit script
        echo -e "   ${g} [-] Running RMshit script by Jakub Klinkovský @lahwaacz${endc}"
        space
        echo -e "   ${r} [X] Do you want to use Rmshit.py script ?${endc}"
        read -p "                           (Y/N) : " choice 
        case "$choice" in 
            y|Y )
                curl -O https://raw.githubusercontent.com/lahwaacz/Scripts/master/rmshit.py && python3 rmshit.py;;
            n|N ) ;;
            * ) ;;
        esac
    fi
}

function Lzypper {
    which zypper > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        echo -e "   ${g} [S] SUSE-Based Distribution detected ${endc}"
        sleep 1
        space
        # Syncing
        echo -e "   ${g} [-] Syncing Database ${endc}"
        zypper  up
        space
        # Cleaning
        echo -e "   ${g} [-] Cleaning Zypper's Cache${endc}"
        space
        echo -e "   ${r} [X] Be Careful, this eliminates the possibility of using downgrade${endc}"
        echo -e "   ${r} [X] Do yo want to clean Zypper's cache ?${endc}"
        read -p "                           (Y/N) : " choice 
        case "$choice" in 
            y|Y )
                zypper cc;;
            n|N ) ;;
            * ) ;;
        esac
        # Removing unused packages
        echo -e "   ${g} [-] Removing unused packages${endc}"
        space
        echo -e "   ${r} [X] Do yo want to Remove unused packages ?${endc}"
        read -p "                           (Y/N) : " choice 
        case "$choice" in 
            y|Y )
                zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' > list
                while read p; do sudo zypper -n rm -y "$p"; done < list
                rm -rf list;;
            n|N ) ;;
            * ) ;;
        esac
        # Runing rmshit script
        echo -e "   ${g} [-] Running RMshit script by Jakub Klinkovský @lahwaacz${endc}"
        space
        echo -e "   ${r} [X] Do you want to use Rmshit.py script ?${endc}"
        read -p "                           (Y/N) : " choice 
        case "$choice" in 
            y|Y )
                curl -O https://raw.githubusercontent.com/lahwaacz/Scripts/master/rmshit.py && python3 rmshit.py;;
            n|N ) ;;
            * ) ;;
        esac
    fi
}

function Ldnf {
    which dnf > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        echo -e "   ${g} [-] 'Syncing Database '${endc}"
        echo ""
        dnf install go python python-pip python-requests python2 python2-pip gcc ruby php git wget bc curl netcat subversion jre-openjdk make automake gcc linux-headers gzip rsync wget
        gem install bundler:1.17.2
    else
        echo -e "   ${g} [-] Skipping dnf${endc}"
    fi
    sleep 1
}

function Lyum {
    which yum > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        echo -e "   ${g} [-] 'Syncing Database '${endc}"
        echo ""
        yum install go python python-pip python-requests python2 python2-pip gcc ruby php git wget bc curl netcat subversion jre-openjdk make automake gcc linux-headers gzip rsync wget
        gem install bundler:1.17.2
    else
        echo -e "   ${g} [-] Skipping yum${endc}"
    fi
    sleep 1
}

function cleanit {
    checkroot
    echo -e "${y}Checking Requirments : ${enda}"
    space && checkreq python3 && checkreq curl && checkreq wget
    space && Lapt && Lpacman
}
cleanit