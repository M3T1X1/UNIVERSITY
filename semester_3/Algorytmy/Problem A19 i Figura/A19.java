import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class A19 {

    public static void main(String[] args) {
        final int WARSZAWA = 0;
        final int KATOWICE = 1;
        final int ZAKOPANE = 2;
        final int LWÓW = 3;
        final int WIEDEŃ = 4;
        final int BUDAPESZT = 5;
        final int BUKARESZT = 6;
        final int ZAGRZEB = 7;
        final int SOFIA = 8;

        final int[][] dystanse =
        {
                {0, 300, 402, 356, 470, 644, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE},
                {300, 0, Integer.MAX_VALUE, Integer.MAX_VALUE, 474, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE},
                {402, Integer.MAX_VALUE, 0, Integer.MAX_VALUE, Integer.MAX_VALUE, 330, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE},
                {356, Integer.MAX_VALUE, Integer.MAX_VALUE, 0, 440, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE},
                {470, 474, Integer.MAX_VALUE, 440, 0, 243, 813, 430, Integer.MAX_VALUE},
                {644, Integer.MAX_VALUE, 330, Integer.MAX_VALUE, 243, 0, 774, 365, 768},
                {Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, 813, 774, 0, 403, 408},
                {Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, 430, 365, 403, 0, 768},
                {Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, 768, 408, 768, 0}
        };


        int najkratszaDroga = Integer.MAX_VALUE;
        List<Integer> najkrotszaTrasa = new ArrayList<>();

        Random random = new Random();

        List<Integer> trasa = new ArrayList<>();

        int obecneMiasto = WARSZAWA;
        int dystans = 0;

        for(int i = 0; i < 1000; i++)
        {
            trasa.add(obecneMiasto);

            while(obecneMiasto != SOFIA)
            {
                List<Integer> sasiedzi = new ArrayList<>();

                for(int j = 0; j < dystanse[obecneMiasto].length; j++)
                {
                    if(dystanse[obecneMiasto][j] != Integer.MAX_VALUE && dystanse[obecneMiasto][j] != 0)
                    {
                        sasiedzi.add(j);
                    }
                }
                if (sasiedzi.isEmpty())
                {
                    dystans = Integer.MAX_VALUE;
                    break;
                }

                int następneMiasto = sasiedzi.get(random.nextInt(sasiedzi.size()));

                dystans += dystanse[obecneMiasto][następneMiasto];
                trasa.add(następneMiasto);
                obecneMiasto = następneMiasto;


                if(dystans >= najkratszaDroga)
                {
                    break;
                }
            }

            if (obecneMiasto == SOFIA && dystans < najkratszaDroga)
            {
                najkratszaDroga = dystans;
                najkrotszaTrasa = new ArrayList<>(trasa);
            }
        }

        System.out.println("Najlepsza droga: " + najkrotszaTrasa);
        System.out.println("Długość : " + najkratszaDroga);
    }
}
