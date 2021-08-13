# CalciferCompiler

don't forget to cmake again after adding of deleting any .cpp/.h file

## where are we

managing IR >> arm assembly.


## build

```bash
mkdir build && cd build
cmake ..
make
```

## debug

if you want to see debug output, enable `line 16` in CMakelist.txt, disable it if you don't.


## run

- run a single test: ./test_set/test.c

    ```bash
    cd build/
    ./calcifer
    ```

- run sysy function tests

    ```bash
    cd build/
    ctest
    
    # if the FUNC_TEST is OFF and you wanna activate it...
    cd build/
    cmake .. -D FUNC_TEST=ON
    ctest
    ```

    same for the sysy performance tests