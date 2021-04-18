// Question is to implement following video https://www.youtube.com/watch?v=xSR38kgzyiQ
// code in picture 1 and 2 are already giving
// operation function provided by Dr give segmentation FAULT maybe a Bug, so Implementing one will make this pass.

element returnPop(stack *s) {
    element e;
    Top(*s , &e);
    Pop(s);
    return e;
}

ExpressionTree Build(char *postfix) {
    stack s = CreateStack();
    element left , right;

    for(int i = 0 ; *(postfix+i) != '\0'; i++) {
        left = right = NULL;
        if(is_operator( *(postfix+i) ) ) {
            if( *(postfix+i) != '#') left = returnPop(&s);
            right = returnPop(&s);
        }
        Push(&s , Construct(*(postfix+i) , left , right) );
    }
    return returnPop(&s);
}

float result(ExpressionTree B) {
    if(B == NULL) return 0;
    if(is_digit(B->data)) return to_digit(B->data);
    
    return operation(result(B->left) , B->data , result(B->right));
}
