import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class A4 {

    public static void main(String[] args)
    {
        int[][] kwalifikacjeKosmonautow =
                {
                // A  B  C  D  E  F
                {1, 0, 0, 0, 1, 0}, // k1
                {0, 1, 0, 1, 0, 1}, // k2
                {1, 1, 0, 0, 1, 0}, // k3
                {0, 1, 0, 0, 1, 1}, // k4
                {0, 0, 1, 1, 0, 0}  // k5
                };

        int iloscKosmonautow = kwalifikacjeKosmonautow.length;
        int liczbaKwalifikacji = kwalifikacjeKosmonautow[0].length;

        Set<Integer> spelnioneKwalifikacje = new HashSet<>();
        List<Integer> wybraniKosmonauci = new ArrayList<>();

        while(spelnioneKwalifikacje.size() < liczbaKwalifikacji)
        {
            int najlepszyKosmonauta = -1;
            int najlepszeSpelnienie = 0;

            for(int i = 0; i < iloscKosmonautow; i++)
            {
                if(wybraniKosmonauci.contains(i)) {
                    continue;
                }

                int spelnienie = 0;

                    for(int j = 0; j < liczbaKwalifikacji; j++)
                    {
                        if (kwalifikacjeKosmonautow[i][j] == 1 && !spelnioneKwalifikacje.contains(j))
                        {
                            spelnienie++;
                        }
                    }

                if (spelnienie > najlepszeSpelnienie)
                {
                    najlepszeSpelnienie = spelnienie;
                    najlepszyKosmonauta = i;
                }
            }

            if(najlepszyKosmonauta != -1)
            {
                wybraniKosmonauci.add(najlepszyKosmonauta);
                for(int j = 0; j < liczbaKwalifikacji; j++)
                {
                    if(kwalifikacjeKosmonautow[najlepszyKosmonauta][j] == 1)
                    {
                        spelnioneKwalifikacje.add(j);
                    }
                }
            }
        }

        System.out.print("Kosmonauci wybrani do ekspedycji: ");
        for(int kosmonauta : wybraniKosmonauci)
        {
            System.out.print("k" + (kosmonauta+1) + " ");
        }
        System.out.println("\n" + "Liczba wybranych kosmonautow do ekspedycji: " + wybraniKosmonauci.size());
    }
}


