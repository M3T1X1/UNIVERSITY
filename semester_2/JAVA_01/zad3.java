import java.util.Scanner;

public class zad3
{
    public static void main(String[] args)
    {
        int[] tab;
        tab = new int[10];
        Scanner skaner = new Scanner(System.in);

        System.out.println("Podaj podpunkt (a,b,c,d): ");
        String pp = skaner.next();

        System.out.println("Twoj podpunkt: "+pp);

        for(int i=0;i<10;i++)
        {
            System.out.println("Podaj liczbe: \n");
            int a = skaner.nextInt();
            //System.out.println(a);
            tab[i] = a;
        }
            //a
            if(pp.equals("a"))
            {
            for (int i = 0; i < 10; i++) {
                System.out.println("A) " + tab[i]);
            }
            System.out.println("\n");
        }
            //b
            if(pp.equals("b")) {
                for (int i = 9; i > 0; i--) {
                    System.out.println("B) " + tab[i]);
                }
                System.out.println("\n");
            }
            //c //d
            for(int i=0; i<10;i++)
            {
                if(i%2==0 && pp.equals("c"))
                {
                    System.out.println("C)(index parzysty) "+tab[i]);
                }
                if(i%2==1 && pp.equals("d"))
                {
                    System.out.println("D)(index nieparzysty) "+tab[i]);
                }
            }
    }
}
