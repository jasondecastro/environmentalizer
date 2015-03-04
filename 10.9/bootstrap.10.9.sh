#!/bin/bash

echo 'Running script for 10.9.x'
echo 'Checking existing environment...'

set -e

installation_checklist=($(cat ./10.9/installation.list))
checklist_length=${#installation_checklist[@]}
already_installed=()
to_be_installed=()

function checkInstallation {
  printf "Checking for $1... "

  installation=$(./10.9/$1/check.sh)

  if [[ ${installation} =~ ^.*installed$ ]]; then
    echo -e "\033[34;32minstalled\033[0m"
    return 0
  else
    echo -e "\033[1;31mnot installed\033[0m"
    return 1
  fi
}

for (( i=0; i<${checklist_length}; i++ )); do
  checkInstallation ${installation_checklist[i]}

  if [ "$?" -eq "0" ]; then
    already_installed[${#already_installed[@]}]=${installation_checklist[i]}
  else
    to_be_installed[${#to_be_installed[@]}]=${installation_checklist[i]}
  fi
done

echo "To Be Installed: ${#to_be_installed[@]}"
echo "Already Installed: ${#already_installed[@]}"

to_be_installed_length=${#to_be_installed[@]}

#echo 'Setting up environment...'

#if [ "$1" -eq "install" ]; then
  #for (( i=0; i<${to_be_installed_length}; i++ )); do
    ## TODO: Handle this better...this is garbaggio
    #if [ "${to_be_installed[i]}" -eq "command_line_tools" ]; then
      #continue
    #else
      #./10.10/${to_be_installed[i]}/install.sh
    #fi
  #done
#fi
