void insert(Hash h, int val, int N)
{
	 // your code here
	 int hv = HF(val , N);
	 if(h[hv] == -1) {
	     h[hv] = val;
	     return;
	 }
	 int i = hv;
	 int temp;

	 do {
	     if(HF(h[i],N) == hv && val <= h[i]) {
	         temp = val;
	         val = h[i];
	         h[i]= temp;
	     }
	     if(h[i] == -1) {
	         h[i] = val;
	         return;
	     }
	     i = (i+1)%N;
	 } while(i != hv);
}
