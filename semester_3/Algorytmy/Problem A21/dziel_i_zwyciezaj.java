public class dziel_i_zwyciezaj
{
    static int podwojeniePkbWLatach()
    {
        float aktualnePKB = 6000;
        float podwojonePKB = aktualnePKB *2;
        int lata = 0;

        while(aktualnePKB < podwojonePKB)
        {
            aktualnePKB = aktualnePKB * ((float) 106 /100);
            lata++;
        }
        return lata;
    }

    static int przegonieniePkb()
    {
        float Polska = 6000;
        float Niemcy = 12000;
        int lataDoPrzegonienia =0;

        while (Polska < Niemcy)
        {
            Polska = Polska*((float) 106 /100);
            Niemcy = Niemcy*((float) 1012 /1000);
            lataDoPrzegonienia++;
        }

        return lataDoPrzegonienia;

    }

    public static void main(String[] args) {
        int ilosc_lat = podwojeniePkbWLatach();
        System.out.println("Polska podwoi swoje PKB w przeciągu: "+ilosc_lat+" lat");

        int lataDoPrzegonienia = przegonieniePkb();
        System.out.println("Polska przewyższy w PKB Niemcy w przeciągu: "+lataDoPrzegonienia+" lat");

        if(lataDoPrzegonienia > 20)
        {
            System.out.println("Polska jest w stanie przegonić Niemcy w przeciągu 20 lat");
        }
        else
        {
            System.out.println("Polska nie jest w stanie przegonić Niemiec w przeciągu 20 lat");
        }

    }
}
