import java.util.Arrays;
import java.util.Scanner;
import java.util.stream.IntStream;

public class zad4 {
    public static void main(String[] args)
    {
        int[] tab;
        tab = new int[10];
        Scanner skaner = new Scanner(System.in);

        System.out.println("Podaj podpunkt (a,b,c,d,e): \n");
        String pp = skaner.nextLine();
        System.out.println("Twoj podpunkt: "+pp);

        for(int i=0;i<10;i++)
        {
            System.out.println("Podaj liczbe: ");
            int a = skaner.nextInt();
            tab[i] = a;
            System.out.println(a);
        }
        //a
        if(pp.equals("a")) {
            int sum = IntStream.of(tab).sum();
            System.out.println("Suma: "+sum);
        }
        //b
        if(pp.equals("b"))
        {
            int product = 1;

            for(int i=0;i<10;i++)
            {
                product = product * tab[i];

            }
            System.out.println("Iloczyn: "+product);
        }
        //c
        if(pp.equals("c"))
        {
            double suma = 0;
            for(int i=0;i<10;i++)
            {
                suma = suma + tab[i];

            }
            System.out.println("Srednia: "+suma/10);
        }
        //d
        if(pp.equals("d"))
        {
            Arrays.sort(tab);
            System.out.println("Minimum: "+tab[0]);

        }
        //e
        if(pp.equals("e"))
        {
            Arrays.sort(tab);
            System.out.println("Maksimum: "+tab[9]);

        }

    }

}
