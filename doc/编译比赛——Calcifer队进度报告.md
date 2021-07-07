## 编译比赛——Calcifer队进度报告

时间：2021年7月5日

组长：周祎欢

队员：邵怡阳、谭清月、陈昊琦

[toc]

### 1 当前项目进展和工程详细

#### 1.1 项目进展

目前我们已经成功完成了词法语法分析，从而建立了AST，完成了语义检查，生成了符号表和线性IR，线性IR形式目前采用四元式。

目前处于 通过四元式翻译成arm汇编代码 这一阶段。

#### 1.2 工程详细

我们的代码目前托管在[gitlab](https://gitlab.eduxiji.net/calcifer/calcifercompiler/-/tree/useTool)上，主要在**useTool**这一分支上进行开发。下面对每一个文件（夹）内容及其功能进行说明。

- `/bin`：用于存放生成的可执行文件，还有一个用于批量测试的shell文件

- `/doc`：各类记录文档，包括输出日志、语义检查详细项目点、我们稍微改动之后的文法、指令分类等

- `/test_set`：测试样例和测试样例集

- `/include`：头文件

  - `sysy_node.hpp`

    `struct GrammaNode`：定义了语法树上的每一个结点的结构体，其中包含变量名、作用域、类型、行号、子节点指针列表等信息

    `TokenType`：枚举类型，定义所有关键字、标识符等

    `GrammaType`：枚举类型，对应每一个语法树上的结点信息

  - `Value.h`

    `class Value`：是符号表对应值的父类，所有类型的value都继承自它。包含名字、行号和作用域

    `class IntegerValue:public Value`：所有int类型变量的子value，包括一些中间变量值也会使用这个子类进行表示。其中关键成员有isConst，表明这是不是一个常量

    `class ArrayValue:public Value`：表示数组类型的value，同样也有isCosnt成员来表明它是不是一个常量。还有NumOfDimension记录维度信息，ArrayElement记录数组初值。

    `class FunctionValue:public Value`：函数类型的value，成员有Result返回值类型、ParamsNum参数个数、FuncParams参数列表

    `class ImmValue:public Value`：表示是立即数。成员为其值

  - `semanticAnalyze.h`

    `struct idTable_struct`：定义符号表的结构体，其中包括一个语法树结点node向Value类指针的映射map，和addItem，askItem两个方法

    `class SemanticError : public std::exception`：一个继承c++异常类的子类，用于提示发生了语义错误

  - `Instruction.h` 目前insturction还在继续写，只有一个父类，考虑在后面重构一下结构，用多种子类区分各种指令的类别

    `class Instruction`：包含所有指令的类型的一个联合体、id、操作符、操作数列表、结果、以及这条指令属于的基本快的指针

  - `BasicBlock.h` 基本快，其中只有一个class BasicBlock，为了后面做优化而设立

    `enum BlockType`：基本快类型，有基本、if、while、break和continue

    `succBlock、pioneerBlock`：前驱、后继基本快

    `bType`：类型

    `FuncV`：对应符号表中的函数

    ...

  - `BuildIR.h` 构造中间表达IR，`class LinearIR`

    `InstList`：记录所有的指令

    `Blocks`：记录所有的Block

    `FuncMap`：将函数的value与对应的basicblock对应

- `/src`：源文件

  - `Makefile`：该工程编译规则，一并把测试run的脚本也搭进去了

  - `main.cpp`：程序主函数，内容基本是按照标准流程进行的，首先是词法语法分析、语义检查、建立四元式...

    <img src="C:\Users\Neho\AppData\Roaming\Typora\typora-user-images\image-20210706092928210.png" alt="image-20210706092928210" style="zoom:50%;" />

  - `lex.yy.cpp, part.tab.cpp`：由词法语法工具生成，用于词法语法分析。并且包括部分语义检查，包括变量名未定义重复定义等问题，并且将每次使用的变量结点重新指向声明处，从这里得出每个变量的作用域。

  - `sysy_node.cpp`：里面函数就一个shownode，打印所有结点及其信息；对应的.h文件中声明了语法树的结点node结构

  - `semanticAnalyze.cpp`：通过访问AST，进行完整的语义检查，包括main函数约束、const常量定义和使用、数组访问越界问题、函数调用的参数个数问题、break，continue循环层数检查、数组初值和纬度相对应等问题。同时建立了树节点node到Value的映射，生成符号表。

  - `BuildIR.cpp`：通过再次访问AST，建立四元式，并且划分基本块，明确每条指令术语哪个基本块以及一些基本块包含了哪些指令

  - `CodeGeneration.cpp`：将得到的指令翻译成arm汇编代码，目前正在研讨中

  - `debug.cpp`：用于放置各类调试函数，打印ast、符号表、指令、语句等信息

### 2 开发过程及关键时间戳

从我们仓库的提交来看，总体进度如下

| 完成词法分析 | 完成语法分析，创建AST | 初步语义检查完成 | ①完成语义检查、建立符号表<br />②完成四元式及基本块框架 | 完成四元式生成（80%） |
| :----------: | :-------------------: | :--------------: | :----------------------------------------------------: | :-------------------: |
|     5.18     |          6.8          |       6.13       |                          6.30                          |          7.5          |

### 3 接下来的进度时间安排、技术路线、以及目前仍然存在的问题

#### 3.1 计划安排

我们的核心思想是先完成一个功能正确，性能完全不考虑的编译器出来，先让它跑起来。因此前期并不考虑它的性能。预计：

**7月13日完成第一版V1.0**

方法：目前大家集中火力在查看资料，如何将我们的四元式翻译成arm汇编；一个是看arm相关基础、另一个是看往届别人的代码

#### 3.2 存在问题

1. 目前我们的生成四元式指令可能还存在没有测出来的bug，也无法保证按条翻译就一定能是正确的arm汇编；
2. 还不知道arm汇编代码应该怎样翻译；不过针对这个问题大家已经在采取行动了，例如看相关基础和指令卡细则，以及去年的开源代码的做法