void postorder(Btree B)
{
    // your code here
    if(B == NULL) return;
    postorder(B->left);
    postorder(B->right);
    printf("%d/%d " , B->data.num , B->data.denum);
}

void postorder_reverse(Btree B)
{
    // your code here
    if(B == NULL) return;
    postorder_reverse(B->right);
    postorder_reverse(B->left);
    printf("%d/%d " , B->data.num , B->data.denum);
}

