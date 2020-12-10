#!/bin/bash

#The toboggan can only follow a few specific slopes (you opted for a cheaper model that prefers rational numbers); start by counting all the trees you would encounter for the slope right 3, down 1:
#From your starting position at the top-left, check the position that is right 3 and down 1. Then, check the position that is right 3 and down 1 from there, and so on until you go past the bottom of the map.

data="./input/three_day.txt"

trees_encountered() {
    data="$1"
    right="$2"
    down="$3"
    pos=(1 1) # or 1 and 1?
    hit=0

    while read -r line; do
        while [ "${pos[1]}" -lt "$(wc -l <"$data")" ]; do
            pos[0]=$(("${pos[0]}" + "$right"))
            pos[1]=$(("${pos[1]}" + "$down"))
            adj_pos=($(if [ $(("${pos[0]}" % 31)) -eq 0 ]; then
                echo 31
            else
                echo "$((${pos[0]} % 31))"
            fi)
            $(echo "${pos[1]}"))
            hit=$(if [[ ${line:${adj_pos[1]}:1} == "#" ]]; then
                echo $(("$hit" + 1))
            else
                echo "$hit"
            fi)
        done
    done <"$data"

    final_pos="${pos[@]}"
    hit_count="$hit"

    echo "Final position = $final_pos and Trees encountered = $hit_count"

}

trees_encountered "$data" 3 1

# This nearly works it counts trees just not correctly - I'll have to come back to it!

#Part 2
