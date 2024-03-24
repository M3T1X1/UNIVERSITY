import java.util.Scanner;

public class zad6 {
    public static void main(String[] args)
    {
        for(;;)
        {
            Scanner skaner = new Scanner(System.in);

            System.out.println("Podaj liczbe calkowita mniejsza od 0 by przerwac: ");
            int koniec = skaner.nextInt();
            if(koniec<0)
            {
                break;
            }
        }
    }

}
