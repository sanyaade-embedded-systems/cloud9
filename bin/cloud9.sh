#!/bin/sh -e
# lets check if we have the submodules initialized
cd `dirname $0`
cd ..
if [ ! -e support/ace/LICENSE ]; then
    echo "--------------------------- Please wait, initializing submodules for first launch ------------------------"
    #git submodule update --init --recursive
    git submodule foreach --recursive 'git submodule update --init; perl -pe "s/git:\/\/(.+)\//git\$1:/" -i.bak .git/config; git submodule update --init'
    echo "--------------------------- Submodules installed ------------------------"
fi

case `uname -a` in
Linux*x86_64*)  echo "Linux 64 bit"   
    support/node-builds-v4/node-linux64 bin/cloud9.js "$@" -a x-www-browser
    ;;

Linux*i686*)  echo "Linux 32 bit"   
sup    port/node-builds-v4/node-linux32 bin/cloud9.js "$@" -a x-www-browser
    ;;
    
Darwin*)  echo  "OSX"
    support/node-builds-v4/node-darwin bin/cloud9.js "$@" -a open
    ;;

CYGWIN*)  echo  "Cygwin"
    support/node-builds-v4/node-cygwin.exe bin/cloud9.js "$@" -a "cmd /c start"
    ;;

MING*)  echo  "MingW"
    support/node-builds-v4/node-cygwin.exe bin/cloud9.js "$@" -a "cmd /c start"
    ;;    

SunOS*)  echo  "Solaris"
    support/node-builds-v4/node-sunos bin/cloud9.js "$@"
    ;;


*) echo "Unknown OS"
    node bin/cloud9.js -c config.js "$@"
    ;;
esac



