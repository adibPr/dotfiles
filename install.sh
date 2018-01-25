#!/bin/bash
# this script is to install dotfiles by linked in in its respective directory
# first it will check the file/folder, if exist then it will move into a new file/folder
# with additional .bak and then link it


# first, function to check existance of a file/folder and if yes, rename it with
# affix bak

BAK_FOLDER="$HOME/config.bak"
if [ -d $BAK_FOLDER ] ; then
    echo " Back up directory is exist"
else
    echo "Making back up directory"
    mkdir -v $BAK_FOLDER
fi

function check_n_move {
    if [ -f "$HOME/$1" ]
    then
        echo "File $1 exist, backing up"
        mv -vf "$HOME/$1" "$BAK_FOLDER/""$1"".bak"
    elif [ -d "$HOME/$1" ]
    then
        echo "Directory $1 exist, backing up"
        mv -vf "$HOME/$1" "$BAK_FOLDER/""$1"".bak"
    else
        echo "$1 not exist"
    fi
}

# then, function to link current file to its $HOME path
function link_file {
    ln -vs "`pwd`/$1" "$HOME/$1"
}

# contains function to check if one string in one array
# taken from 
# https://stackoverflow.com/questions/8063228/how-do-i-check-if-a-variable-exists-in-a-list-in-bash
contains() {
    if [[ $1 =~ (^|[[:space:]])"$2"($|[[:space:]]) ]] ;then
        result="0"
    else
        result="1"
    fi

    return $result
}

blacklist=".git .. ."
for d in .* ; do
    if `contains "$blacklist" "$d"` ; then
        echo "$d is skipped"
    else 
        echo "linking $d"
        check_n_move "$d"
        link_file "$d"
    fi
done

# special for vim
echo "Cloning vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# then you just need to plugin install inside vim
