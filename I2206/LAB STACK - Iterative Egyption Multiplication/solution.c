// Iterative Implementation of Egyption Multiplication using stack

#include <stdio.h>
#include <string.h>

#define N 10

typedef struct element {
    int a,b;
} element;

typedef struct
{
  element data[N];
  int top;
} stack;

stack
CreateStack ()
{
  stack p;
  p.top = -1;
  return p;
}

int
isEmptyStack (stack p)
{
  return (p.top == -1);
}

int
isFullStack (stack p)
{
  return (p.top == N - 1);
}

int
Push (stack * p, element e)
{
  if (isFullStack (*p))
    return 0;
  p->data[++p->top] = e;
  return 1;
}

int
Pop (stack * p)
{
  if (isEmptyStack (*p))
    return 0;
  p->top--;
  return 1;
}

int
Top (stack p, element * e)
{
  if (isEmptyStack (p))
    return 0;
  *e = p.data[p.top];
  return 1;
}

void printStack(stack s) {
    element e;
    while(Top(s,&e)) {
        Pop(&s);
        printf("%d\t%d\n",e.a,e.b);
    }
}

int egyptian_it(int a,int b) {
    element e = {a,b};
    stack s = CreateStack();
    int res = 0;
    while(e.a != 1) {
        Push(&s , e);
        e.a /= 2;
        e.b += e.b;
    }
    res += e.b;
    while(Top(s,&e)) {
        Pop(&s);
        if(e.a % 2 != 0) {
            res += e.b;
        }
    }
    return res;
}

int
main ()
{
  printf("result = %d" , egyptian_it(11,-3));
  return 0;
}
