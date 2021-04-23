void CreateCalkinWilfTree_h(Btree *B, int numerator, int denumerator, int height)
{
    // your code here
    // this function should be recursive
    if(height < 1) return;

    *B = (Btree)malloc(sizeof(struct node));
    (*B)->data.num = numerator;
    (*B)->data.denum = denumerator;

    CreateCalkinWilfTree_h(&(*B)->left , numerator , denumerator+numerator , height-1);
    CreateCalkinWilfTree_h(&(*B)->right , numerator+denumerator , denumerator , height-1);
}

Btree CreateCalkinWilfTree(int height)
{
    Btree B=NULL;
    CreateCalkinWilfTree_h(&B, 1 , 1, height);
    return B;
}
