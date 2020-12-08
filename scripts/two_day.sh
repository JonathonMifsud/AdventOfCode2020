#!/bin/bash

#Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid.
#For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

#How many passwords are valid according to their policies?

# I wrote this with the assumption that the each password and policy would be on a single line which isnt the case but this is fixed by removing the new lines using sed.

valid=0
data="./input/two_day.txt"

for i in $(sed -e 's/\s\+/,/g' "$data"); do
    lowLim=$(echo "$i" | cut -f1 -d "," | cut -f1 -d "-")
    upLim=$(echo "$i" | cut -f1 -d "," | cut -f2 -d "-")
    letter=$(echo "$i" | cut -f2 -d "," | tr -d ":")
    password=$(echo "$i" | cut -f3 -d ",")
    occurences=$(echo "$password" | grep -o "$letter" | wc -l)
    if { [ "$occurences" -ge "$lowLim" ] && [ "$occurences" -le "$upLim" ] ; } then
        let "valid++"
    fi
    echo $valid
done

# Answer
# 378

#PART 2

#Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!)
#Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement
#How many passwords are valid according to the new interpretation of the policies?

valid=0
data="./input/two_day.txt"

for i in $(sed -e 's/\s\+/,/g' "$data"); do
    pos1=$(echo "$i" | cut -f1 -d "," | echo $(( $(cut -f1 -d "-") - 1 )) ) # the minus 1 is needed as indexing starts at 0 but the problem uses indexing starting at 1
    pos2=$(echo "$i" | cut -f1 -d "," | echo $(( $(cut -f2 -d "-") - 1 )) ) # was tricky figuring out the brackets here but now I think I understand them much better
    letter=$(echo "$i" | cut -f2 -d "," | tr -d ":")
    password=$(echo "$i" | cut -f3 -d ",")
    if { [ "${password:$pos1:1}" == "$letter" ] && [ "${password:$pos2:1}" == "$letter" ] ; } || { [ "${password:$pos1:1}" != "$letter" ] && [ "${password:$pos2:1}" != "$letter" ] ; } ; then
        : # do nothing command
        else
            let "valid++"
    fi
    echo "$valid"
done

# Answer
# 280

# Super slow but it works! 

# Improvments:
# echo answer outside of the loop to make terminal cleaner