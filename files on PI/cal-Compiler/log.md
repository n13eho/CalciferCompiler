# code generation
## structure
1. .text
    * If this is a function, we start a `.text`
    1. `.align` declare the alignment size
    2. `.global [name]` declare a label put in global
    3. `.type` tells type, eg.`.type	_Z3addii, %function`
    4. translate our IR into the assembly code.
    5. `.fnstart` and `.fnend` means start position and end position of the function 

2. .bss
    * If this is a int-no-init variable, we start a `.bss`

3. .data
    * If this is a int-init varable, we start a `.data`

4. .section .rodata 
    * `.section` means we define our section own
    * If this is a const-int variable, we start a `.section .rodata`