import java.util.HashMap;
import java.util.ArrayList;

public class main {
    //A -> k1,k4 -> 0001 <- "id" kwalifikacji
    //B -> k2,k3,k4 -> 0010
    //C -> k3,k5 -> 0100
    //D -> k1,k2,k5 -> 1000

    //Aby wynik był poprawny łączna "punktacja" astronautów musi wynosić 1111,to znaczy że każda kwalifikacja musi zostać zapełniona.

    public static void main(String[] args)
    {
//         k1 = 0b1001;
//         k2 = 0b1010;
//         k3 = 0b0110;
//         k4 = 0b0011;
//         k5 = 0b1100;

        HashMap<String,Integer> astronauci = new HashMap<>();

        astronauci.put("k1",0b1001);
        astronauci.put("k2",0b1010);
        astronauci.put("k3",0b0110);
        astronauci.put("k4",0b0011);
        astronauci.put("k5",0b1100);

        ArrayList<String> kosmonauci = new ArrayList<>(astronauci.keySet());

        int liczbaKosmonautow = kosmonauci.size();
        int wymaganyWynik = 0b1111;
        int najlepszyZespol = Integer.MAX_VALUE;
        String najlepszyZespolNazwy = "";


        for(int i=1;i<(1 << liczbaKosmonautow);i++)
        {
            int aktualnyWynik = 0;
            StringBuilder wybraniKosmonauci = new StringBuilder();

            for(int j=0;j<liczbaKosmonautow;j++)
            {
                if((i & (1 << j)) > 0)
                {
                    String astronauta = kosmonauci.get(j);
                    aktualnyWynik |= astronauci.get(astronauta);
                    wybraniKosmonauci.append(astronauta).append(" ");
                }
            }

            if(aktualnyWynik == wymaganyWynik)
            {
                int liczbaWybranych = Integer.bitCount(i);
                if(liczbaWybranych < najlepszyZespol)
                {
                    najlepszyZespol = liczbaWybranych;
                    najlepszyZespolNazwy = wybraniKosmonauci.toString();
                }
            }
        }

        System.out.println("Najmniejszy zespół kosmonautów: " + najlepszyZespolNazwy);
        System.out.println("Liczba kosmonautów w zespole: " + najlepszyZespol);
    }
}




