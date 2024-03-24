import java.util.Scanner;

public class ex8 {

    public static void main(String[] args) {

        Scanner skaner = new Scanner(System.in);
        System.out.println("Podaj liczbe");
        int liczba = skaner.nextInt();
        int wynik = 1;
        if(liczba==0)
        {
            System.out.println("0");
        }
        else
        {
            while (liczba>0) {
                wynik = wynik * liczba;
                liczba--;
            }
        }
        System.out.println("Wynik silni = "+wynik);
    }
}
