for file in $( ls ../test_set/scope_check)
do
    echo "\033[47;34m $file \033[0m"
    # echo $file
    ../bin/calcifer "../test_set/scope_check/$file"
    echo
done