void CreateSternBrocotTree_h(Btree *B, int a, int b, int c, int d, int height)
{
    // your code here
    // this function should be recursive
    if(height < 1) return;
    *B = (Btree)malloc(sizeof(struct node));
    (*B)->data.num = a+c;
    (*B)->data.denum = b+d;
    CreateSternBrocotTree_h(&(*B)->left , a , b , a+c , b+d , height-1);
    CreateSternBrocotTree_h(&(*B)->right , a+c , b+d , c , d , height-1);
}

Btree CreateSternBrocotTree(int height)
{
	Btree B=NULL;
	CreateSternBrocotTree_h(&B, 0 , 1, 1, 0, height);
	return B;
}
