#!/bin/bash

# Prevents committing in root folder
if test $(pwd) == $HOME ; then
      echo "Do not run this script in root"
      exit 1;
fi

# Checks if location is git initialized
if [ ! -e ".git" ] ; then
	echo "This is not a git repository - run git init"
	exit 1;
fi

function commit_message {	
	git add .
	git add -u
	git commit -m "$message"
	exit 0;
}

while getopts ":sm" opt; do
	case $opt in
		s)
			message="Spring Cleaning"			
			commit_message $message
			;;			
		m)
			message="Resolve merge conflicts"			
			commit_message $message
			;;			
		\?)
			echo "Unrecognizable option"
			exit 0;
			;;
	esac	
done

echo "Write commit msg, leave blank to end script"
read -r -p 'Commit message: ' message
if test "$message" == "" ; then
	echo "Cancelling commiting"
	exit 0;
fi	
git add .
git add -u
git commit -m "$message"
