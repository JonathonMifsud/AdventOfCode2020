#!/bin/bash

# Day 1
#Find the two entries that sum to 2020; what do you get if you multiply them together?

dos2unix ./input/oneday.txt
my_array=($(cat ./input/oneday.txt))
declare -p my_array

# here is my first attempt but I realise that this only adds each number to the next and not the other combinations
for i in "${!my_array[@]}"; do
    a="${my_array[i]}"
    b="${my_array[i + 1]}"
    sum=$(($a + $b))
    if [ $sum == 2020 ]; then
        echo $a and $b are the numbers we need!
    fi
done

# here is the second attempt, messy but it works
for i in "${!my_array[@]}"; do
    a="${my_array[i]}"
    for j in "${!my_array[@]}"; do
        b="${my_array[j]}"
        sum=$(($a + $b))
        if [ $sum == 2020 ]; then
            echo $a and $b are the numbers we need lets multiply these!
            answer=$(($a * $b))
            echo The answer is $answer
        fi
    done
done

# output
# 28 and 1992 are the numbers we need lets multiply these!
# The answer is 55776

# PART 2
# In your expense report, what is the product of the three entries that sum to 2020?
# Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.

# This is a horrible way to do it and made my laptop run hard but yay it works first try!
for i in "${!my_array[@]}"; do
    a="${my_array[i]}"
    for j in "${!my_array[@]}"; do
        b="${my_array[j]}"
        for k in "${!my_array[@]}"; do
            c="${my_array[k]}"
            sum=$(($a + $b + $c))
            if [ $sum == 2020 ]; then
                echo $a and $b and $c are the numbers we need lets multiply these!
                answer=$(($a * $b * $c))
                echo The answer is $answer
            fi
        done
    done
done

# output
# 314 and 723 and 983 are the numbers we need lets multiply these!
# The answer is 223162626

# Day 1 complete 
# First time using arrays in bash - super useful
# Also learnt how to auto format in VSC and how to run lines in the VSC terminal