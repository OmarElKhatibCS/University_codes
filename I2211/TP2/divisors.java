import java.util.*;

public class Main
{
    static List<Integer> divosors(int n) {
        List <Integer> divs = new ArrayList <Integer>();
        for (int i=2; i < n; i++)
            if (n % i == 0) divs.add(i);
        return divs;
    }
    
    public static void main (String[]args) {
        System.out.print("Give n : ");
        Scanner s = new Scanner(System.in);
        int n = s.nextInt();
        
        List <Integer> divs = divosors(n);
        Iterator<Integer> it = divs.iterator(); 
        
        System.out.printf("Divisors of %d : [ " , n);
        while (it.hasNext()) System.out.print(it.next()+" ");
        System.out.print("]");
    }
}