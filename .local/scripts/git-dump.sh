#!/bin/bash

#from tomnomnom 

OUT_DIR="git-objects"

if [ ! -z "$1" ]; then
    OUT_DIR="$1"
fi

if [ -d "$OUT_DIR" ]; then
    echo "$OUT_DIR dir already exists"
    exit 1
fi

mkdir -p "$OUT_DIR"
{
    find .git/objects/pack/ -name "*.idx" | while read i; do
        git show-index < "$i" | awk '{print $2}';
    done;
    
    find .git/objects/ -type f | 
        grep -v '/pack/' |
        awk -F'/' '{print $(NF-1)$NF}';
} | while read o; do
    git cat-file -p $o > "$OUT_DIR/$o"
done

