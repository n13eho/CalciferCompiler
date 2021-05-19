Root            -> {CompUnitNode} $^+$          //一个或多个
CompUnitNode    -> **const int** ConstDef {,ConstDef} **;**
                -> **void** FuncDefV
                -> **int Ident** VarDef {**, Ident**VarDef} **;**
                -> **int Idnet (** FuncDefI
FuncDefV        -> **Ident (** [FuncParams] **)** Block
FuncDefI        -> [FuncParams] **)** Block
ConstDef        -> **Ident**{**[** AddExp **]**} **=** InitVal      //const_flag = 1 
VarDef          -> {**[** AddExp **]**}                   //const_flag = 1
                -> {**[** AddExp **]**} **=** InitVal     //const_flag = 1
InitVal         -> AddExp
                -> **{** [ InitVal { **,** InitVal } ] **}**
FuncFParams     -> FuncFParam { **,** FuncFParam }
FuncFParam      -> **int Ident** [ **[]** { **[** AddExp **]** } ]
Block           -> **{** {BlockItem} **}**
BlockItem       -> Stmt
                -> **const int** ConstDef {,ConstDef} **;**
                -> **int Ident** VarDef {,VarDef} **;**
Stmt            -> MulExp LVal **=** AddExp **;**//必须是MulExp--UnaryExp--Ident
                -> [MulExp (**+**|**-**) AddExp] **;**
                -> Block **;** 
                -> **if (** LOrExp **)** Stmt [ **else** Stmt]
                -> **while (** LOrExp **)** Stmt
                -> **break;**
                -> **continue;**
                -> **return** [AddExp] **;**
LVal            -> { **[** AddExp **]**} 
UnaryExp        -> **IntConst**
                -> **Ident(** [FuncRPararms] **)**
                -> **+** UnaryExp
                -> **-** UnaryExp
                -> **!** UnaryExp (仅限制LOrExp)
FuncRParams     -> AddExp {**,** AddExp}
MulExp          -> UnaryExp
                -> UnaryExp **\*** MulExp
                -> UnaryExp **/** MulExp
                -> UnaryExp **%** MulExp
AddExp          -> MulExp
                -> MulExp **+** AddExp
                -> MulExp **-** AddExp
RelExp          -> AddExp
                -> AddExp **<** RelExp
                -> AddExp **>** RelExp
                -> AddExp **<=** RelExp
                -> AddExp **>=** RelExp
EqExp           -> RelExp
                -> RelExp **==** EqExp
                -> RelExp **!=** EqExp
LAndExp         -> EqExp
                -> EqExp **&&** LAndExp
LOrExp         -> EqExp
                -> EqExp **||** LOrExp

`-+3`OK?