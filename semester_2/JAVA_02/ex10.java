import java.util.Scanner;

public class ex10 {
    public static int fib(int element_id)
    {
        int x=0;
        int y=1;
        int suma;

        for(int i=2;i<=element_id;i++)
        {
            suma = x+y;
            x=y;
            y=suma;
            System.out.println(y);
        }
        return y;
    }


    public static void main(String[] args)
    {
        Scanner skaner = new Scanner(System.in);
        System.out.println("Podaj do którego elementu ma program liczyc: ");
        int element_id = skaner.nextInt();
        System.out.println(fib(element_id));

    }
}
