#include <iostream>
#include <set>
#include "../include/sysy_node.hpp"

void show_node(GrammaNode* root,int layer=0)
{
    for(int i=0;i<layer*3;i++)
        std::cout<<" ";
    std::cout<<"->";
    std::cout << root <<" node string:"<<root->str<<"\t son numbers:"<<root->son.size()<<std::endl;
    for(int i=0;i<root->son.size();i++)
    {
        show_node(root->son[i],layer+1);
    }
}

std::set<GrammaNode*> treeNodesSet;

void putNode2Set(GrammaNode* n)
{
    treeNodesSet.insert(n);
    for(int i = 0; i < n->son.size(); i++)
    {
        putNode2Set(n->son[i]);
    }
}

void releaseAST(GrammaNode* root)
{
    // 先把所有结点指针放进set中
    putNode2Set(root);

    // 遍历set，挨个delete掉
    for(auto n: treeNodesSet)
    {
        delete(n);
    }
    // 最后看下这个set怎么释放掉
    treeNodesSet.clear();
}