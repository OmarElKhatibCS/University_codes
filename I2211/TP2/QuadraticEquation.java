class QuadratiqueEquation {
    private double a , b , c;
    QuadratiqueEquation(double a , double b , double c) {
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public void Solve() {
        double x1, x2 , d;

        d = b * b - 4 * a * c;

        if (d > 0) {
            x1 = (-b + Math.sqrt(d)) / (2 * a);
            x2 = (-b - Math.sqrt(d)) / (2 * a);

            System.out.printf("x1 = %.2f\nx2 = %.2f\n", x1, x2);
        }

        else if (d == 0) {
            x1 = x2 = -b / (2 * a);
            System.out.printf("x1 = x2 = %.2f\n", x1);
        }

        else {
            double r = -b / (2 * a);
            double i = Math.sqrt(-d) / (2 * a);
            System.out.printf("x1 = %.2f+%.2fi\nx2 = %.2f+%.2fi\n", r, i ,r , i);
        }
        System.out.println();
    }

    public void Print() {
        System.out.printf("%.2fX^2+%.2fX+%.2f\n" , a , b , c);
    }
}

public class Main {

    public static void main(String[] args) {
        QuadratiqueEquation eq;
        
        eq = new QuadratiqueEquation(1 , 2 , 1);
        eq.Print();
        eq.Solve();
        
        eq = new QuadratiqueEquation(5 , 5 , 1);
        eq.Print();
        eq.Solve();
        
        eq = new QuadratiqueEquation(4 , 2 , 1);
        eq.Print();
        eq.Solve();
    }
}