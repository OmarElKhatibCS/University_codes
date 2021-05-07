void largest_kth(int *A , int n , int k) {
	heap h = CreateHeap(n,2); // 2 mean MaxHeap
	BuildHeap(&h,A,n);
	for(int i=0 ; i < k ; i++) {
		printf("%d",*(h->array));
		DeleteMax(&h);
	}
}
