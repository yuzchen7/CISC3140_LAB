#! /bin/bash

#########################################################
# Function :Date Calculator program trans form java     #
# Platform :MacOS Platform                              #
# Version  :1.0                                         #
# Date     :10/21/2022                                  #
# Author   :Yuzhuang Chen (yuz.chen)                    #
#########################################################

# function return the matching format code by using exit code in shell script
# args : string_with/without_format
# return : 0(matched with mm/dd/yyyy format) 
#          1(matched with mm-dd format)
#          2(matched with select date format)
#          3(non of the format are matched)
function checkFormatOf() {
    regex_maps='[A-Za-z_]{1,} [0-9]{1,}'

    if [[ $1 =~ [0-9]{1,2}/[0-9]{0,2}/[0-9]{4} ]]
    then
        return 0
    elif [[ $1 =~ [0-9]{1,2}-[0-9]{0,2} ]]
    then
        return 1
    elif [[ $1 =~ $regex_maps ]]
    then
        return 2
    else 
        return 3
    fi
}

# function for read in the date that has been saved
array_dates=(); # array for saved all the dates in process
array_eunm=(); # array for saved all the key for matched the dates
function savedDate() {
    counter=0;
    index=0;

    while IFS=" " read p #readin
    do
        tmep=(${p})
        reminder=$( expr $counter % 2 )

        if [[ $reminder -eq 1 ]]
        then
            array_dates[$index]=${tmep[@]}
            index=$( expr $index + 1 )
        else
            element=${tmep[0]}
            array_eunm[$index]=$element
        fi

        counter=$( expr $counter + 1 )

    done < src/Date.txt

    # chenge key string t become the key of the dates arrays
    for (( i=0; i<$index; i++ ))
    do 
        name=${array_eunm[$i]}
        declare -r ${name}=$i
    done
}

# function to print out all the dates and the key of the dates
printDateMune() {
    for (( i=0; i<${#array_eunm[@]}; i++ ))
    do
        key=${array_eunm[$i]}
        echo "${key} -> [ ${array_dates[${key}]} ]"
    done
}

# function to exit the program if user input 'exit' or 'EXIT'
# args user_input
checkExit() {
    if [[ $1 =~ "exit" ]] || [[ $1 =~ "EXIT" ]]
    then
        echo "Processing exit......."
        exit 0
    fi
}

# function to convert the input that form user 
# to the repersened it in time stamp from(in seconds)
# since shell script cannot return what i want(like any other program language), 
# so using extra globle variables to hold the result (shell only return in range 0~255)
# arg a_string_in_date_format
dateStamp=0
function makeDate() {
    checkFormatOf "$1"
    format_code=$?

    if [[ $format_code -eq 3 ]] # non match any date format 
    then 
        echo "$1 -> input format errors."
        return 1
    elif [[ $format_code -eq 0 ]] # match date format : mm/dd/yyyy
    then 
        dateStamp=$(date -jf '%m/%d/%Y' $1 +%s)

    elif [[ $format_code -eq 1 ]] # match date format : mm-dd
    then
        current_year=$(date +%Y)
        str=$1"-"$current_year
        dateStamp=$(date -jf '%m-%d-%Y' $str +%s)

        current_day=$(date +%s)
        # by defult, year is current year, if the date is alrady pass by, 
        # then set year to the next year
        if [[ $dateStamp -lt $current_day ]] 
        then 
            current_year=$(( $(date +%Y) + 1 ))
            str=$1"-"$current_year
            endDate=$(date -jf '%m-%d-%Y' $str +%s)
        fi

    elif [[ $format_code -eq 2 ]] # match the format with selecting a date from saved dates
    then
        temp=($1)
        date_list=(${array_dates[${temp[0]}]})
        date_str=${date_list[${temp[1]}]}
        dateStamp=$(date -jf '%m/%d/%Y' $date_str +%s)
    fi
}

# function for Calculating ant two vaild input dates, if input is invaild,
# will stop the function with return code 1
# args start_date_string end_date_string
function dateCalculator() {
    makeDate "$1"
    successCode=$?
    if [[ $successCode -eq 1 ]] 
    then
        return
    fi
    startDate=$dateStamp
    if [[ $startDate -eq 0 ]]
    then
        echo "input1 format errors."
        return 1;
    fi

    makeDate "$2"
    successCode=$?
    if [[ $successCode -eq 1 ]] 
    then
        return
    fi
    endDate=$dateStamp
    if [[ $endDate -eq 0 ]]
    then
        echo "input2 format errors."
        return 1;
    fi

    diff=$(( $endDate - $startDate ))
    days=$(( $diff / (60 * 60 * 24) ))

    if [[ $days -eq 0 ]]
    then
        echo "Today is the due Date, please submit the work."
    elif [[ $days -lt 0 ]]
    then 
        echo "The due date is passed."
    else
        echo "$days days alway form today"
    fi
}


savedDate
while [ 1 -eq 1 ]
do
    echo
    printDateMune
    echo

    echo "Enter the date in format either in 'MM/DD/YYY' or 'MM-DD'"
    echo "Or choose a Date from above in format 'xxx_date index'"
    read -p "From date : " startStr
    checkExit $startStr
    read -p "To   date : " endStr
    checkExit $endStr

    dateCalculator "${startStr}" "${endStr}"

    echo
done