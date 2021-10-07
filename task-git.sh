#!/bin/bash
# Used from https://github.com/kostajh/task-git/blob/master/task-git.sh

# Navigate to your Taskwarrior data directory (usually in ~/.task) and type git init. If you plan to push to a remote, go ahead and add your remote now.
# Add alias task=/path/to/task-git/task-git.sh to your .bashrc or .profile. If you want to push to a remote, then the alias should be alias task=/path/to/task-git/task-git.sh --task-git-push. Make sure you source the .bashrc or .profile.
# Run chmod +x /path/to/task-git/task-git.sh.
# Use task as normal; when run, the Taskwarrior database files will be committed to version control.

# Get task command
TASK_COMMAND="task ${@}"
# Get data dir
DATA_RC=$(task _show | grep data.location)
DATA=(${DATA_RC//=/ })
DATA_DIR=${DATA[1]}
if [ ! -d "$DATA_DIR" ]; then
  echo 'Could not load data directory!'
  exit 1
fi

# Check if --task-git-push is passed as an argument.
PUSH=0
for i
do
  if [ "$i" == "--task-git-push" ]; then
    # Set the PUSH flag, and remove this from the arguments list.
    PUSH=1
    shift
  fi
done

# Call task, commit files and push if flag is set.
/usr/bin/task $@
cd $DATA_DIR
git add .
git commit -m "$TASK_COMMAND" > /dev/null

if [ "$PUSH" == 1 ]; then
  git push origin master > /dev/null
fi
exit 0

