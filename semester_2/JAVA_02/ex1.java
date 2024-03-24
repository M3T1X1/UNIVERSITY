import java.util.Scanner;

public class ex1 {
    public static void main(String[] args)
    {
        Scanner skaner = new Scanner(System.in);

        System.out.println("Podaj liczbe A: ");
        int a = skaner.nextInt();

        if(a>=11 && a<19)
        {
            System.out.println("Liczba A nalezy do przedzialu z podpunktu a).");
        }

        if(a>=-3 && a<19)
        {
            System.out.println("Liczba A nalezy do przedzialu z podpunktu b).");
        }

        if(a>=11 && a<19)
        {
            if(a>-9999999 && a<=3)
            {
                System.out.println("Liczba A nalezy do przedzialu z podpunktu c).");
            }
            }

    }
}
