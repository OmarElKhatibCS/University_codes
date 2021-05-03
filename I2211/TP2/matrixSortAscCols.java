import java.util.*;

class Matrix {
    private int M[][] , n , m;
    
    Matrix() {
        Scanner s = new Scanner(System.in);
        
        System.out.print("How many rows ? ");
        n = s.nextInt();
        System.out.print("How many columns ? ");
        m = s.nextInt();
        
        System.out.printf("Enter %d elements (row by row) : " , n*m);
        
        M = new int[n][m];
        
        for(int i=0;i<n;i++)
           for(int j=0;j<m;j++)
               M[i][j] = s.nextInt();
               
        s.close();
    }
    
    // Random Matrix for testing purpose
    Matrix(int n , int m) {
        this.n = n;
        this.m = m;
        
        M = new int[n][m];
        Random random = new Random();
        for(int i=0;i<n;i++)
            for(int j=0;j<m;j++)
                M[i][j] = random.nextInt(40);;
    }
    
    public void Print() {
        for(int i=0;i<n;i++) {
            for(int j=0;j<m;j++)
                System.out.printf("%d\t",M[i][j]);
            System.out.println();
        }
        System.out.println();
    }
    
    public void SortByColumns() {
        int k;
        for(int i = 0 ; i < m ; i++) {
            for(int j = 0 ; j < m ; j++) {
                k=0;
                int temp = M[k][i]; // Column Is Changed After Swapping so saving it make life easier :)
                if(i == j) continue;
                
                while(temp == M[k][j]) {
                    k++;
                    if(k == n) return;
                    temp = M[k][i];
                    if(M[k][i] < M[k][j])
                        swapCols(i , j);
                }
                
                if(temp < M[k][j])
                    swapCols(i , j);
            }
        }
    }
    
    private void swapCols(int col1 , int col2) {
        int temp;
        for(int i = 0 ; i < n ; i++) {
            temp = M[i][col1];
            M[i][col1] = M[i][col2];
            M[i][col2] = temp;
        }
    }
}

public class Main
{
    public static void main (String[]args) {
        Matrix M = new Matrix(6,7);
        System.out.println("Before Sorting : ");
        M.Print();
        System.out.println("After Sorting : ");
        M.SortByColumns();
        M.Print();
    }
}
