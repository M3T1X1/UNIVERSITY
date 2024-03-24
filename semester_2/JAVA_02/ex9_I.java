import java.util.Scanner;

public class ex9_I
{
    public static int ite(int podstawa, int wykladnik) {
        int wynik = 1;
        while (wykladnik > 0)
        {
            if (wykladnik % 2 != 0)
            {
                wynik = wynik*podstawa;
            }
            podstawa =podstawa*podstawa;
            wykladnik = wykladnik/2;
        }
        return wynik;
    }

    public static void main(String[] args)
    {
        Scanner skaner = new Scanner(System.in);
        System.out.println("Podaj podstawe: ");
        int podstawa = skaner.nextInt();
        System.out.println("Podaj wykladnik: ");
        int wykladnik = skaner.nextInt();

        System.out.println("Wynik wynik interacyjnie: " + ite(podstawa, wykladnik));
    }
}
