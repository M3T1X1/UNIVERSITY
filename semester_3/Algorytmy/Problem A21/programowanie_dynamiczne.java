public class programowanie_dynamiczne
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

    public static void main(String[] args) {
        int ilosc_lat = podwojeniePkbWLatach();
        System.out.println("Polska podwoi swoje PKB w przeciągu: "+ilosc_lat+" lat");
    }
}
