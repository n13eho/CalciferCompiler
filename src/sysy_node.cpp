#include <iostream>
#include <stdio.h>
#include "sysy_node.hpp"

void show_node(GrammaNode* root,int layer=0)
{
    for(int i=0;i<layer*3;i++)
        std::cout<<" ";
    std::cout<<"->";
    std::cout<<"node string:"<<root->str<<"\t son numbers:"<<root->son.size()<<std::endl;
    for(int i=0;i<root->son.size();i++)
    {
        show_node(root->son[i],layer+1);
    }
}