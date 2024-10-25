import java.util.Scanner;

public class A28 {
    public static void main(String[] args) {
        final int[] NOMINALY = {500, 200, 100, 50, 20, 10, 5, 2, 1}; // Nominały w groszach
        final int[] LIMITY = {1, 2, 0, 7, 2, 2, 5, 2, 10}; // Limit liczby monet dla każdego nominału

        System.out.println("Podaj ile reszty należy wydać (w groszach): ");
        Scanner sc = new Scanner(System.in);

        int resztaDoWydania = sc.nextInt();
        int[] monetyWydane = new int[NOMINALY.length];

        for(int i=0;i<NOMINALY.length && resztaDoWydania>0;i++)
        {
            while(resztaDoWydania>=NOMINALY[i] && LIMITY[i]>0)
            {
                resztaDoWydania -= NOMINALY[i];
                monetyWydane[i]++;
                LIMITY[i]--;
            }
        }

        if(resztaDoWydania > 0)
        {
            System.out.println("Nie można wydać pełnej kwoty z dostępnych monet.");
        }
        else
        {
            System.out.println("Użyte monety:");
            for(int i = 0; i < NOMINALY.length; i++)
            {
                if(monetyWydane[i] > 0)
                {
                    System.out.println("Nominał: " + NOMINALY[i] + " groszy, Liczba: " + monetyWydane[i]);
                }
            }
        }
    }
}

