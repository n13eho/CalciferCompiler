/*
input: CFG with newIR
output: CFG whichout phi/RIG

note:
    1. What is newIR?
    ----将之前四元式中的指令替换为汇编指令，暂不处理寄存器，使用decel（每一个变量被赋值都会多一个decel，在多个变量合并的时候，需要插入phi节点）
*/