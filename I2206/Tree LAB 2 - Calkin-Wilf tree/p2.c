int levelorder(Btree B)
{
    if(B == NULL) return 0;
    if(B->data.num <= 0 || B->data.denum <= 0) return 0;

    queue q = CreateQueue();
    Btree prev , next;

    EnQueue(&q , B);

    // your code here
    while(Front(q , &prev)) {
        if(prev->data.num <= 0 || prev->data.denum <= 0) return 0;

        DeQueue(&q);
        if(prev->left != NULL) {
            if(prev->left->data.denum != prev->data.num+prev->data.denum || prev->left->data.num != prev->data.num) return 0;
            EnQueue(&q , prev->left);
        }
        if(prev->right != NULL) {
            if(prev->right->data.num != prev->data.num+prev->data.denum || prev->right->data.denum != prev->data.denum) return 0;
            EnQueue(&q , prev->right);
        }
        if(Front(q , &next)) {
            if(next->data.num <= 0 || next->data.denum <= 0) return 0;
            if(prev->data.denum != next->data.num) return 0;
        }
    }
    return 1;
}
