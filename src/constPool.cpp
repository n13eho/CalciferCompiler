#include "../include/decl.h"
#include "../include/liveSet.h"
void constpool(DomTreenode* dn){
    BasicBlock* node = dn->block;
    for(auto it = newBlock[node].begin();it!=newBlock[node].end();it++){
        auto ins = *it;

        //只有ldr, str 会发生常量池溢出问题
        if(ins->getType() == armInstr::str){

            armStr* ins_str = (armStr*)ins;
            if(ins_str->rs->gettype() == Decl::memory_decl){
                memoryDecl* mem = (memoryDecl*)ins_str->rs;
                if(abs(mem->bias)>=1024){
                    //需要把偏移放入寄存器,然后[sp,rs]来寻址
                    armMov* add_mov = new armMov();
                    add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                    add_mov->rs = new constDecl(nullptr, node, mem->bias*4);
                    //添加这条指令
                    it = newBlock[node].insert(it,add_mov);
                    it++;

                    //需要一个新的decl来寻址
                    addrDecl* addr_new = new addrDecl(nullptr, node, 13);
                    addr_new->biasR = ((varDecl*)add_mov->rd);

                    //原来的mem就应该修改成为addr_new, 原bias修改为0;
                    ins_str->rs = addr_new;
                    ins_str->bias = 0;
                }
            }
            else if(ins_str->rs->gettype() == Decl::addr_decl){
                //(这一层if展示了sb的我...)
                if(ins_str->bias){
                    //bias 在指令里
                    if(abs(ins_str->bias)>=1024){
                        //需要把偏移放入寄存器,然后[sp,rs]来寻址
                        armMov* add_mov = new armMov();
                        add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                        add_mov->rs = new constDecl(nullptr, node, ins_str->bias*4);
                        //添加这条指令
                        it = newBlock[node].insert(it,add_mov);
                        it++;

                        //需要一个新的decl来寻址
                        addrDecl* addr_new = new addrDecl(nullptr, node, ((addrDecl*)ins_str->rs)->Vreg);
                        addr_new->biasR = ((varDecl*)add_mov->rd);

                        //原来的mem就应该修改成为addr_new, 原bias修改为0;
                        ins_str->rs = addr_new;
                        ins_str->bias = 0;
                    }
                }
                else{
                    //bias 在decl里
                    addrDecl* addr = (addrDecl*)ins_str->rs;
                    if(abs(addr->bias)>=1024){
                        //需要把偏移放入寄存器,然后[sp,rs]来寻址
                        armMov* add_mov = new armMov();
                        add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                        add_mov->rs = new constDecl(nullptr, node, addr->bias*4);
                        //添加这条指令
                        it = newBlock[node].insert(it,add_mov);
                        it++;

                        //需要一个新的decl来寻址
                        addrDecl* addr_new = new addrDecl(nullptr, node, addr->Vreg);
                        addr_new->biasR = ((varDecl*)add_mov->rd);

                        //原来的mem就应该修改成为addr_new, 原bias修改为0;
                        ins_str->rs = addr_new;
                        ins_str->bias = 0;
                    }
                }
            }
        }
        else if(ins->getType() == armInstr::ldr){
            armLdr* ins_ldr = (armLdr*)ins;
            if(ins_ldr->rs->gettype() == Decl::memory_decl){
                memoryDecl* mem = (memoryDecl*)ins_ldr->rs;
                if(abs(mem->bias)>=1024){
                    //需要把偏移放入寄存器,然后[sp,rs]来寻址
                    armMov* add_mov = new armMov();
                    add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                    add_mov->rs = new constDecl(nullptr, node, mem->bias*4);
                    //添加这条指令
                    it = newBlock[node].insert(it,add_mov);
                    it++;

                    //需要一个新的decl来寻址
                    addrDecl* addr_new = new addrDecl(nullptr, node, 13);
                    addr_new->biasR = ((varDecl*)add_mov->rd);

                    //原来的mem就应该修改成为addr_new, 原bias修改为0;
                    ins_ldr->rs = addr_new;
                    ins_ldr->bias = 0;
                }
            }
            else if(ins_ldr->rs->gettype() == Decl::addr_decl){
                //(这一层if展示了sb的我...)
                if(ins_ldr->bias){
                    //bias 在指令里
                    if(abs(ins_ldr->bias)>=1024){
                        //需要把偏移放入寄存器,然后[sp,rs]来寻址
                        armMov* add_mov = new armMov();
                        add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                        add_mov->rs = new constDecl(nullptr, node, ins_ldr->bias*4);
                        //添加这条指令
                        it = newBlock[node].insert(it,add_mov);
                        it++;

                        //需要一个新的decl来寻址
                        addrDecl* addr_new = new addrDecl(nullptr, node, ((addrDecl*)ins_ldr->rs)->Vreg);
                        addr_new->biasR = ((varDecl*)add_mov->rd);

                        //原来的mem就应该修改成为addr_new, 原bias修改为0;
                        ins_ldr->rs = addr_new;
                        ins_ldr->bias = 0;
                    }
                }
                else{
                    //bias 在decl里
                    addrDecl* addr = (addrDecl*)ins_ldr->rs;
                    if(abs(addr->bias)>=1024){
                        //需要把偏移放入寄存器,然后[sp,rs]来寻址
                        armMov* add_mov = new armMov();
                        add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                        add_mov->rs = new constDecl(nullptr, node, addr->bias*4);
                        //添加这条指令
                        it = newBlock[node].insert(it,add_mov);
                        it++;

                        //需要一个新的decl来寻址
                        addrDecl* addr_new = new addrDecl(nullptr, node, addr->Vreg);
                        addr_new->biasR = ((varDecl*)add_mov->rd);

                        //原来的mem就应该修改成为addr_new, 原bias修改为0;
                        ins_ldr->rs = addr_new;
                        ins_ldr->bias = 0;
                    }
                }
            }
        }
        else if(ins->getType()==armInstr::mov){
            armMov* ins_mov = (armMov*)ins;
            //先讨论rs
            if(ins_mov->rs->gettype() == Decl::memory_decl){
                memoryDecl* mem = (memoryDecl*)ins_mov->rs;
                if(abs(mem->bias)>=1024){
                    //需要把偏移放入寄存器,然后[sp,rs]来寻址
                    armMov* add_mov = new armMov();
                    add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                    add_mov->rs = new constDecl(nullptr, node, mem->bias*4);
                    //添加这条指令
                    it = newBlock[node].insert(it,add_mov);
                    it++;

                    //需要一个新的decl来寻址
                    addrDecl* addr_new = new addrDecl(nullptr, node, 13);
                    addr_new->biasR = ((varDecl*)add_mov->rd);

                    //原来的mem就应该修改成为addr_new, 原bias修改为0;
                    ins_mov->rs = addr_new;
                }
            }
            else if(ins_mov->rs->gettype() == Decl::addr_decl){
                //bias 在decl里
                addrDecl* addr = (addrDecl*)ins_mov->rs;
                if(abs(addr->bias)>=1024){
                    //需要把偏移放入寄存器,然后[sp,rs]来寻址
                    armMov* add_mov = new armMov();
                    add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                    add_mov->rs = new constDecl(nullptr, node, addr->bias*4);
                    //添加这条指令
                    it = newBlock[node].insert(it,add_mov);
                    it++;

                    //需要一个新的decl来寻址
                    addrDecl* addr_new = new addrDecl(nullptr, node, addr->Vreg);
                    addr_new->biasR = ((varDecl*)add_mov->rd);

                    //原来的mem就应该修改成为addr_new, 原bias修改为0;
                    ins_mov->rs = addr_new;
                }
            }

            //讨论rd
            if(ins_mov->rd->gettype() == Decl::memory_decl){
                memoryDecl* mem = (memoryDecl*)ins_mov->rd;
                if(abs(mem->bias)>=1024){
                    //需要把偏移放入寄存器,然后[sp,rs]来寻址
                    armMov* add_mov = new armMov();
                    add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                    add_mov->rs = new constDecl(nullptr, node, mem->bias*4);
                    //添加这条指令
                    it = newBlock[node].insert(it,add_mov);
                    it++;

                    //需要一个新的decl来寻址
                    addrDecl* addr_new = new addrDecl(nullptr, node, 13);
                    addr_new->biasR = ((varDecl*)add_mov->rd);

                    //原来的mem就应该修改成为addr_new, 原bias修改为0;
                    ins_mov->rd = addr_new;
                }
            }
            else if(ins_mov->rd->gettype() == Decl::addr_decl){
                //bias 在decl里
                addrDecl* addr = (addrDecl*)ins_mov->rd;
                if(abs(addr->bias)>=1024){
                    //需要把偏移放入寄存器,然后[sp,rs]来寻址
                    armMov* add_mov = new armMov();
                    add_mov->rd = new varDecl(nullptr,node,Rcnt++);
                    add_mov->rd = new constDecl(nullptr, node, addr->bias*4);
                    //添加这条指令
                    it = newBlock[node].insert(it,add_mov);
                    it++;

                    //需要一个新的decl来寻址
                    addrDecl* addr_new = new addrDecl(nullptr, node, addr->Vreg);
                    addr_new->biasR = ((varDecl*)add_mov->rd);

                    //原来的mem就应该修改成为addr_new, 原bias修改为0;
                    ins_mov->rd = addr_new;
                }
            }
        }
    }
    for(auto son : dn->son){
        constpool(son);
    }
}