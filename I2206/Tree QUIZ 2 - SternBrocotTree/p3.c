int levelorder(Btree B)
{
    // your code here
     // your code here
    queue q;
    elementq temp;

    if(B==NULL) return 0;
    q = CreateQueue();
    int level = 1 , currentLevel , sumNum = 0 , sumDenum = 0;
    elementq* e = (elementq*)malloc(sizeof(elementq));
    e->B = B;
    e->level = level;
    EnQueue(&q , *e);

    if(B->data.num != B->data.denum) return 0;
    currentLevel = level;

    while(Front(q , &temp)) {
        DeQueue(&q);
        if(temp.level != currentLevel) {
            if(sumNum != sumDenum) return 0;
            sumNum = temp.B->data.num;
            sumDenum = temp.B->data.denum;
            //currentLevel = temp.level;
        }
        else {
            sumNum += temp.B->data.num;
            sumDenum += temp.B->data.denum;
        }
        if(temp.B->left != NULL) {
            e->B = temp.B->left;
            e->level = temp.level+1;
            EnQueue(&q , *e);
        }
        if(temp.B->right != NULL) {
            e->B = temp.B->right;
            e->level = temp.level+1;
            EnQueue(&q , *e);
        }

        currentLevel = temp.level;
    }

    return sumNum == sumDenum;
}
