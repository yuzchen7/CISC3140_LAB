#! /usr/local/bin/gawk -f

# List all the car types, models, and acceleration that is 
# from the US and Acceleration are greater than or equal to 
# 20

BEGIN {
    FS=";"; 
    total_record = 0;
    printf "+-%35s-+-%5s-+-%12s-+\n", "-----------------------------------", "-----", "------------"
    printf "| %-35s | %-5s | %-12s |\n", "CarType", "Model", "Acceleration"
    printf "+-%35s-+-%5s-+-%12s-+\n", "-----------------------------------", "-----", "------------"
}

{   
    if ($NF ~ "US" && $7 >= 20) {
        printf "| %-35s | %-5s | %-12s |\n", $1, $8, $7
        total_record++
    }
}

END {
    printf "+-%35s-+-%5s-+-%12s-+\n", "-----------------------------------", "-----", "------------"
    printf "| %-58s | \n", "total "total_record" record are found."
    printf "+-%35s---%5s---%12s-+\n", "-----------------------------------", "-----", "------------"
}