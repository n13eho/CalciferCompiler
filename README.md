# CalciferCompiler

快快上车clion

## where are we

managing IR >> arm assembly.


## build

```bash
mkdir build && cd build
cmake ..
make
```

## run

- run a single test: ./test_set/test.c

    ```bash
    cd build/
    ./calcifer
    ```

- run sysy function tests

    ```bash
    cd build
    ctest
    
    # if the FUNC_TEST is OFF and you wanna activate it...
    cd build
    cmake .. -D FUNC_TEST=ON
    ctest
    ```

    same for the sysy performance tests