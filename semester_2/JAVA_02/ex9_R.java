import java.util.Scanner;

public class ex9_R{
    public static int rek(int podstawa, int wykladnik)
    {
        if (wykladnik == 0)
        {
            return 1;
        }
        else if (wykladnik % 2 == 0)
        {
            int wynik = rek(podstawa, wykladnik / 2);
            return wynik * wynik;
        }
        else
        {
            return podstawa * rek(podstawa, wykladnik - 1);
        }
    }

    public static void main(String[] args) {
        Scanner skaner = new Scanner(System.in);
        System.out.println("Podaj podstawe: ");
        int podstawa = skaner.nextInt();
        System.out.println("Podaj wykladnik: ");
        int wykladnik = skaner.nextInt();

        System.out.println("Wynik rekurencyjny: "+rek(podstawa,wykladnik));

    }
}
