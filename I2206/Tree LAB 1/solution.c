// Question is to implement following video https://www.youtube.com/watch?v=xSR38kgzyiQ
// code in picture 1 and 2 are already giving

ExpressionTree Build(char *postfix)
{
    stack s = CreateStack();
    element e;
    element1 currChar;

    // your code here
    for(int i=0 ; *(postfix+i) != '\0' ; i++) {
        currChar = *(postfix+i);

        if(is_digit(currChar)) {
            Push(&s , Construct(currChar , NULL , NULL));
        }
        else if(currChar == '#') {
            Top(s , &e);
            Pop(&s);
            Push(&s , Construct(currChar , NULL , e));
        } else {
            Top(s , &e);
            Pop(&s);

            element temp = e;

            Top(s , &e);
            Pop(&s);

            Push(&s , Construct(currChar , e , temp));
        }
    }
    Top(s , &e);
    Pop(&s);

    return e;
}

float result(ExpressionTree B)
{
    if(B == NULL) return 0;

    if(is_digit(B->data)) return to_digit(B->data);

    float left_result = result(B->left);
    float right_result = result(B->right);

    return operation(left_result , B->data , right_result);
}
