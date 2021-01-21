//
//  Stack.h
//  iClCUlator_test
//
//  Created by Liu_zc on 2020/1/3.
//  Copyright © 2020 Liu_zc. All rights reserved.
//

#ifndef Stack_h
#define Stack_h

#include <stdio.h>
#include <stdlib.h>

#endif /* Stack_h */

//定义栈
//typedef struct StackNode  ///定义结点
//{
//    char data;
//    struct StackNode *next;
//} StackNode, *LinkStackPtr;
//
//typedef struct LinkStack  ///定义链式储存栈
//{
//    LinkStackPtr top;
//    int count;
//} LinkStack;
//
//LinkStackPtr * Creat_stack(void); //创建一个含有#的结点，并返回其指针为头指针
//
//int Push (LinkStack *S,char e);  //压栈
//
//int Pop(LinkStack *S,char *e);  //出栈

typedef struct LNode
{
    char data;
    struct LNode * next;
} LNode,*LinkList;

void creatStack(LinkList* L);
int Push(LinkList* L, char e);
char Pop(LinkList* L);

