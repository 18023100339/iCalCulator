//
//  Stack.c
//  iClCUlator_test
//
//  Created by Liu_zc on 2020/1/3.
//  Copyright © 2020 Liu_zc. All rights reserved.
//

#include "Stack.h"



//--------------------------//
//定义栈操作
void creatStack(LinkList* L)  //初始化栈
{
    *L = (LinkList) malloc(sizeof(LinkList));
    (*L)->next = NULL;
}

int Push(LinkList *L, char e)  //进栈
    {
    LinkList newNode = (LinkList) malloc(sizeof(LinkList));
        newNode->data = e;
    newNode->next = (*L)->next;
    (*L)->next = newNode;
        printf("这个是printf");
    return 1;
}

char Pop(LinkList* L)  //出栈
{
    char popchar = '\0';
    if((*L)->next == NULL)
    {
        return 0;
    }
    
    LinkList temp = (*L)->next;
    printf("看看是什么:::%d",temp->data);
    (*L)->next = temp->next;
    free(temp);
    return popchar;
}






//int Push (LinkStack *S,char e)  //压栈
//{
//    LinkStackPtr s = (LinkStackPtr) malloc(sizeof(StackNode));
//
//    s->data=e;
//    s->next=S->top;  //当前栈顶元素给新结点的后继
//    S->top=s;  //top指向新结点
//    S->count++;
//
//    return 1;
//};
//
//int Pop(LinkStack *S,char *e)  //出栈
//{
//    LinkStackPtr p;
//    if (S->top == NULL) {
//        return 0;
//    }
//
//    *e=S->top->data;
//    p=S->top;
//    S->top=S->top->next;
//    free(p);
//    S->count--;
//    return 1;
//};
