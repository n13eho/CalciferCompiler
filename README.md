# CalciferCompiler



## make

```bash
mkdir build && cd build
cmake ..
make
```

## run

I keep this, for a better debug env

run a single test: test.c

```bash
cd src/
make run
```

run sysy function test

```bash
cd build
ctest

# if the FUNC_TEST is OFF and you wanna activate it...
cd build
cmake .. -D FUNC_TEST=ON
ctest
```

same for the sysy performance test

## where are we

managing IR...