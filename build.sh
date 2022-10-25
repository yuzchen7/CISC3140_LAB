#! /bin/bash

#####################################################
# Function :compile and run the java program        #
# Platform :All Linux Based Platform and MacOS      #
# Version  :1.0                                     #
# Date     :10/19/2022                              #
# Author   :Yuzhuang Chen (yuz.chen)                #
#####################################################

# args : root_dir
# return : 1(no java file has been modified) or 0(at least 1 java file has been modified)
function checkModified() {
    # get all the '.java' file from ${root_dir} that has been modifty less than 1 month
    # and convert into an array
    list_modifty_file=$(find ${1} -type f -ctime -1 | grep '.java')
  
    # check if a array is empty, if it is empty, 
    # then return false(0) for repsersenting no java file has been modified,
    # otherwise return true(1)
    if [[ -z "$list_modifty_file" ]]
    then
        return 0
    else
        return 1
    fi
}

# args : root_dir, target_dir
function compile() {
    # read in all the '.java' file from ${root_dir} and convert into an array
    list_files=($(find ${1} -name '*.java'))
    #compile all the files to target location
    javac ${list_files[@]} -d ${2}
}

# args : root_dir target_dir
function run() {
    checkModified "${1}"
    check_modifty=$?

    if [[ $check_modifty -eq 1 ]] || [[ ! -d $2 ]]
    then
        compile ${1} ${2}
    fi

    # read in all the '.class' file from ${root_dir} and convert into an array
    list_files=($(find "${2}" -name '*.class'))
    echo "${list_files[@]}"
    
    #change directory to target dir for avoid java ClassLoadingException/ClassNotFoundException
    cd "${2}"
    
    # since we don't know which .class file contains main/executable,
    # so need to try to run every .class
    for (( i=0; i<${#list_files[@]}; i++ ))
    do
        # modified .class file to java command executable path
        file_name=${list_files[$i]%\.class} # remove longest match from the back of string
        file_name=${file_name#*/} # remove longest match from the start of string

        pwd
        # to avoid print out the error message from java command
        java ${file_name} < ../sampledates.txt # 2> /dev/null
        # 2 stand for stderr, means if the command failed, using stderr stream
        # default value is 1, stand for stdout, 
        # e.g : 'cat input.txt > output.txt' same as 'cat input.txt 1> output.txt'
        # /dev/null is the black hole, like Recycle Bin, will delete the output
        # any output to /dev/null, will not able to read or modified
        # @see https://www.middlewareinventory.com/blog/linux-stdout-stderr-bash/
        # @see https://wxnacy.com/2021/06/12/shell-errror-to-dev-null/

        # if run successfully, then break out
        if [ $? -eq 0 ]; then
            break
        fi
    done
    cd ..
}

execut() {
    run "$1" "$2"
}
