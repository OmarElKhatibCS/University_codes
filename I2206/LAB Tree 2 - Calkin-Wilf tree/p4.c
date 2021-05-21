int check (Btree B)
{
    // your code here
    if(B == NULL) return 0;
    stack p = CreateStack();
    stack rp = CreateStack();

    int proceed = 1;

    Btree preP = NULL;
    Btree preRe = NULL;

    Btree B1 , B2;
    B1 = B2 = B;
    if(B->data.num <= 0 || B->data.denum <= 0) return 0;

    while(proceed) {
        while(B1 != NULL && B2 != NULL) {
            if(B1->left != NULL && B1->right != NULL)
                if(B1->left->data.denum != B1->data.num+B1->data.denum || B1->left->data.num != B1->data.num) return 0;
            if(!Push(&p , B1)) return 0;
            B1 = B1->left;

            if(B2->left != NULL && B2->right != NULL)
                if(B2->right->data.num != B2->data.num+B2->data.denum || B2->right->data.denum != B2->data.denum) return 0;
            if(!Push(&rp , B2)) return 0;
            B2 = B2->right;
        }
        if(!isEmptyStack(p) || !isEmptyStack(rp)) {
            if(!Top(p , &B1)) return 0;
            if(B1->right==NULL || B1->right==preP) {
                preP = B1;
                B1 = NULL;
                Pop(&p);
            } else B1=B1->right;
            if(!Top(rp , &B2)) return 0;
            if(B2->left==NULL || B2->left==preRe) {
                preRe = B2;
                B2 = NULL;
                Pop(&rp);
            } else B2=B2->left;

        } else return 0;

        if(preP->data.num == 1 && preP->data.denum == 1) break;
        if(preRe->data.num == 1 && preRe->data.denum == 1) break;

        if(preP != NULL && preRe != NULL) {
            if(preP->data.num <=0 || preP->data.denum <= 0 || preRe->data.num <= 0 || preRe->data.denum <= 0) return 0;
            if(preP->data.num != preRe->data.denum && preRe->data.num != preP->data.denum) return 0;
        }
    }
    return isEmptyStack(p) && isEmptyStack(rp);
}
