import java.util.Scanner;

public class ex7 {
    public static int silnia(int wartosc)
    {
        if(wartosc==0)
        {
            return 1;
        }
        else
        {
            return wartosc*silnia(wartosc-1);
        }
    }
    public static void main(String[] args)
    {
        Scanner sc = new Scanner(System.in);
        System.out.println("Podaj liczbe: ");
        int liczba = sc.nextInt();
        System.out.println(liczba+"!= "+silnia(liczba));
    }
}
