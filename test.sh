#!/bin/bash

# ARGS=$1

# echo "$ARGS"


# if [ -z $ARGS ]; then
#     echo "ARGS is null"
# else 
#     echo "ARGS is not null"
# fi

# list_modifty_file=($(find . -type f -ctime -24 | grep '.java'))

# echo "${list_modifty_file[@]}"

# if [ -d "out" ]; then
#     echo "yes"
# else 
#     echo "no"
# fi


# array=("a", "b", "c", "d", "e", "f")
# array2=("a", "b", "c", "d", "e", "f")
# array3=("a", "b", "c", "d", "e", "f")
# arraylist=(
#     "${array[@]}"
# )

# arr=${arraylist[@]}
# echo "${#arr[@]}"
# echo "${#arraylist[@]}"

# echo "${array["a"]}"

# for (( i=0; i<${#arraylist[@]}; i++ )) {
#     temp=${arraylist[$i]}
#     echo "${temp[@]}"
#     for (( i=0; i<${#temp[@]}; i++ )) {
#         echo "${temp[$i]}"
#     }
# }

# function add() {
#     return $(( $1 + $2 ))
# }

# result=$(add 1 2)
# echo "$result"

# str="10-15"
# echo "$str"
# str1="-2022"
# str=$str$str1
# echo "$str"

# a="10/25"

# current_year=$(date +%Y)
# str=$a"/"$current_year
# startDate=$(date -jf '%m/%d/%Y' $str +%s)

# current_day=$(date +%s)
# if [[ $startDate -lt $current_day ]]
# then 
#     current_year=$(( $(date +%Y) + 1 ))
#     echo "$current_year"
#     str=$a"/"$current_year
#     echo "$str"
#     startDate=$(date -jf '%m/%d/%Y' $str +%s)
# fi

# echo "${startDate}"

# array=(
#     'Windows macos linux'
#     'C++ Java C#' 
# )

# array_name=(system lenguage)
# for (( i=0; i<${#array[@]}; i++))
# do 
#     name=${array_name[$i]}
#     declare -r $name=$1
# done

# echo "${array[system]}"

# while IFS=" " read p
# do
#     echo $p
# done < src/Date.txt

# array_name[${#array_name[@]}]=network
# echo "${#array_name[@]}"
# echo "${array_name[$(( ${#array_name[@]} - 1 ))]}"

# str="valbh suiapbvcbhj cgbsuiabl usgbcahsvlb"
# array=($str)
# echo "${array[3]}"

# counter=0;
# index=0;
# array_eunm=()
# array_dates=();
# while IFS=" " read p
# do
#     tmep=(${p})
#     reminder=$( expr $counter % 2 )
#     counter=$( expr $counter + 1 )

#     if [[ $reminder -eq 1 ]]
#     then
#         echo "branch 1 -> ${tmep[@]}"
#         array_dates[$index]=${tmep[@]}
#         index=$( expr $index + 1 )
#     else
#         echo "branch 2"
#         element=${tmep[0]}
#         echo "${element}"
#         array_eunm[$index]=$element
#     fi

# done < src/Date.txt


# echo ${array_dates[@]}

# for (( i=0; i<$index; i++ ))
# do 
#     name=${array_eunm[$i]}
#     declare -r ${name}=$i
# done

# echo "assigment_dates -> ${array_dates[quiz_dates]}"
# echo "quiz_dates -> ${array_dates[quiz_dates]}"
# echo "final_dates -> ${array_dates[final_dates]}"

# array_temp=${array_dates[final_dates]}
# echo "${array_temp[0]}"

# regex_maps='[A-Za-z_]{1,} [0-9]{1,}' 
# str="quiz_dates 1"
# if [[ $str =~ $regex_maps ]]
# then
#     echo "nice"
# fi

# function checkFormatOf() {
#     regex_maps='[A-Za-z_]{1,} [0-9]{1,}'
#     echo $1
#     if [[ $1 =~ [0-9]{1,2}/[0-9]{0,2}/[0-9]{4} ]]
#     then
#         return 0

#     elif [[ $1 =~ [0-9]{1,2}-[0-9]{0,2} ]]
#     then
#         return 1

#     elif [[ $1 =~ $regex_maps ]]
#     then
#         return 2

#     else 
#         return 3
#     fi
# }

# checkFormatOf "$str"

# list_modifty_file=$(find src -type f -ctime -1 | grep '.java')
# echo "$list_modifty_file"
# echo 
# list_modifty_file=$(find src -type f -ctime -1 | grep '.java')
# echo "$list_modifty_file"

# if [[ ! -d out ]]
# then 
#     echo 存在
# else 
#     echo 不存在
# fi

function list() {
    echo "function list()"
}

echo "nice"

dir=$(find src -name '*.java')
