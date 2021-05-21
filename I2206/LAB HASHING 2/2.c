void deleteHash(Hash h, int val, int N)
{
     // your code here
     int temp;
     int i = HF(val , N);

     while(h[i] != val) {
         if(h[i] == -1 || (HF(h[i],N) == HF(val,N) && h[i] > val)) return;
         i = (i+1)%N;
     }
     h[i] = -1;
     int curr = (i+1)%N;
     while(h[curr] != -1) {
         if(HF(h[curr],N) != curr) {
            temp = h[curr];
            h[curr] = -1;
            insert(h,temp,N);
            if(h[curr] != temp) i = curr;
         }
         curr = (curr+1)%N;
     }
}
