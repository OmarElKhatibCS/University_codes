import java.util.function.Supplier;
import java.util.*;

class MinMaxArray<T extends Comparable<? super T>> {
    private int size;
    private T max;
    private T min;
    private ArrayList<T> arr;

    // for testing purpose make it random
    MinMaxArray(int size , Supplier<T> newValueSupplier) {
        if(size < 1) return;
        this.size = size;

        arr = new ArrayList();

        for(int i=0;i<size;i++)
            arr.add(newValueSupplier.get());

        max = arr.get(0);
        min = arr.get(0);

        for(int i = 1 ; i < size ; i++) {
            if(max.compareTo(arr.get(i)) <= -1) max = arr.get(i);
            if(min.compareTo(arr.get(i)) >= 1) min = arr.get(i);
        }
    }

    public void replaceAt(int pos , T val) {
        if(pos < 0 || pos >= size) return;
        arr.set(pos , val);
        if(max.compareTo(val) <= -1) max = val;
        if(min.compareTo(val) >= 1) min = val;
    }

    public T getMax() {
        return max;
    }

    public T getMin() {
        return min;
    }

    public void Print() {
        for(int i=0 ; i < this.size ; i++) System.out.print(arr.get(i)+" ");
        System.out.println();
    }
}

public class Main {
    public static String generateString() {
        String alphabet = "bcdefghijklmnopqrstuvwxy";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        int length = 7;

        for(int i = 0; i < length; i++) {
            int index = random.nextInt(alphabet.length());

            char randomChar = alphabet.charAt(index);

            sb.append(randomChar);
        }

        return sb.toString();
    }

    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        System.out.print("size of array : ");
        int size = s.nextInt();
        Random r = new Random();

        MinMaxArray<Integer> intMinMaxArray = new MinMaxArray<>(size, () -> r.nextInt(100));
        intMinMaxArray.Print();
        System.out.printf("min = %d\n",intMinMaxArray.getMin());
        System.out.printf("max = %d\n",intMinMaxArray.getMax());

        intMinMaxArray.replaceAt(5 , 130); // Max in array is < 100 because Generator is between [0-100[
        intMinMaxArray.replaceAt(8 , -10); // Min in array is > 0 because Generator is between [0-100[

        System.out.println("\nAfter Inserting new elements : ");
        intMinMaxArray.Print();
        System.out.printf("min = %d\n",intMinMaxArray.getMin());
        System.out.printf("max = %d\n",intMinMaxArray.getMax());

        System.out.println("\n-------------------------------------------------------------------------------------------\n");

        MinMaxArray<String> stringMinMaxArray = new MinMaxArray<>(size, () -> generateString());
        stringMinMaxArray.Print();
        System.out.println("min = "+stringMinMaxArray.getMin());
        System.out.println("max = "+stringMinMaxArray.getMax());

        stringMinMaxArray.replaceAt(5 , "zzzzzzz"); // should be max because all generated strings are from [b-y]
        stringMinMaxArray.replaceAt(8 , "aaaaaaa"); // should be min because all generated strings are from [b-y]

        System.out.println("\nAfter Inserting new elements : ");
        stringMinMaxArray.Print();
        System.out.println("min = " + stringMinMaxArray.getMin());
        System.out.println("max = " + stringMinMaxArray.getMax());
    }
}