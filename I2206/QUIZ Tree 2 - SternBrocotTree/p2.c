Btree search(Btree B, element e)
{
    // your code here
    if(B == NULL) return NULL;
    if(B->data.num == e.num && B->data.denum == e.denum) return B;
    Btree l = search(B->left , e);
    Btree r = search(B->right , e);
    if(l != NULL) return l;
    else if (r != NULL) return r;
    return NULL;
}
