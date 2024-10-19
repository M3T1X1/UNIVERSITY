public class wlasne_rozwiazanie {

    static void pkb(int rok1998_Polska,int rok1998_Niemcy)
    {
        int rok = 1998;
        int ilosc_lat = 0;
        boolean podwojeniePKB = true;

        while(rok1998_Polska < rok1998_Niemcy)
        {
            rok1998_Polska = rok1998_Polska*1060/1000;
            rok1998_Niemcy = rok1998_Niemcy*1012/1000;

            rok++;
            ilosc_lat++;

            System.out.println("Rok: "+rok);
            System.out.println("Niemcy: "+rok1998_Niemcy);
            System.out.println("Polska: "+rok1998_Polska);
            System.out.println("\n");

            if((rok1998_Polska > 6000*2 || rok1998_Polska == 6000*2) && podwojeniePKB)
            {
                System.out.println("PKB polski podwoi się po "+ilosc_lat+" latach\n");
                podwojeniePKB = false;
            }
        }

        if(ilosc_lat < 20)
        {
            System.out.println("PKB Polski przewyższy PKB niemiec po "+ilosc_lat+" latach, więc jest w stanie dorównać w przeciągu 20 lat");
        }
        else
        {
            System.out.println("PKB Polski nie jest w stanie dorównać PKB Niemiec w przeciągu 20 lat");
        }
    }

    public static void main(String[] args)
    {
        pkb(6000,12000);
    }
}
