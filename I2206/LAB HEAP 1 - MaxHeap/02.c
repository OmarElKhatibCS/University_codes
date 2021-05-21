int countNodes(Btree root) {
    if(root == NULL) return 0;
    return 1+countNodes(root->left)+countNodes(root->right);
}

int isCompleteBT(Btree root , int index , int count) {
    if(root == NULL) return 1;
    if(index >= count) return 0;

    return isCompleteBT(root->left , 2*index+1 , count) && isCompleteBT(root->right , 2*index+2 , count);
}

int isHeapHelper(Btree root) {
    if(root == NULL) return 1;

    Btree left = root->left;
	Btree right = root->right;

	if( (left != NULL && root->data < left->data) || (right != NULL && root->data < right->data)) return 0;

	return isHeapHelper(root->left) && isHeapHelper(root->right);
}

int isHeap(Btree root)
{
	// your code here
	if(root == NULL) return 1;
	return isCompleteBT(root , 0 , countNodes(root)) && isHeapHelper(root);
}
