for file in $( ls ./outputS/)
do
    echo ">>>" $file
    # echo ${file%%.*}
    # echo ./exe/${file%%.*}
    clang ./outputS/$file -o ./exe/${file%%.*} -L./sysyruntime -static -lsysy
    ./exe/${file%%.*}
    echo $?
    # echo
done

