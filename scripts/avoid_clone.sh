#!/bin/bash
# Avoid cloning if SINGLE_SOURCE_LOCATION is given location.

main() {
    local git_dir=$(realpath -s $1) # SINGLE_SOURCE_LOCATION
    local current_binary_has_cloned=$(realpath -s $2) #ex. 'build32' folder path which has finished run
    local current_binary_no_cloned=$(realpath -s $3)
    for dir in $git_dir/* ; do
        if [[ -d "$dir/.git" ]] ; then
            local name=$(basename $dir)
            local stamp_dir=$current_binary_has_cloned/packages/$name-prefix/src/$name-stamp
            local stamp_dir_copied=$current_binary_no_cloned/packages/$name-prefix/src/$name-stamp
            if [[ -d $stamp_dir ]] ; then
                cp -n $stamp_dir/$name-gitclone-lastrun.txt $stamp_dir_copied
            fi
        fi
    done
}

main $1 $2 $3
#Usage ./avoid_clone.sh /home/shinchiro/git_folder ../build32 ../build64
