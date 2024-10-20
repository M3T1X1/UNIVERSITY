public class programowanie_dynamiczne
{
    static double poczatkowePKBPolska = 6000;
    static double poczatkowePKBNiemcy = 12000;
    static double stopaWzrostuPolska = 6;
    static double stopaWzrostuNiemcy = 1.2;
    static int lataDoSprawdzenia = 20;


    public static int lataDoPodwojeniaPKB() {
        double[] pkb = new double[1000];
        pkb[0] = poczatkowePKBPolska;
        double celPKB = poczatkowePKBPolska * 2;

        for (int lata = 1; lata < pkb.length; lata++) {
            pkb[lata] = pkb[lata - 1] * (1 + stopaWzrostuPolska / 100);
            if (pkb[lata] >= celPKB) {
                return lata;
            }
        }
        return -1;
    }


    public static boolean czyPolskaDogoniNiemcy() {
        double[] pkbPolskaTablica = new double[lataDoSprawdzenia + 1];
        double[] pkbNiemcyTablica = new double[lataDoSprawdzenia + 1];

        pkbPolskaTablica[0] = poczatkowePKBPolska;
        pkbNiemcyTablica[0] = poczatkowePKBNiemcy;

        for (int i = 1; i <= lataDoSprawdzenia; i++)
        {
            pkbPolskaTablica[i] = pkbPolskaTablica[i - 1] * (1 + stopaWzrostuPolska / 100);
            pkbNiemcyTablica[i] = pkbNiemcyTablica[i - 1] * (1 + stopaWzrostuNiemcy / 100);


            if (pkbPolskaTablica[i] >= pkbNiemcyTablica[i])
            {
                return true;
            }
        }
        return false;
    }

    public static void main(String[] args)
    {

        boolean czyDogoni = czyPolskaDogoniNiemcy();
        System.out.println("Czy PKB Polski dogoni PKB Niemiec w ciągu 20 lat? ");
        if (czyDogoni)
        {
            System.out.println("Tak, Polska dogoni Niemcy w przeciągu 20 lat");
        }
        else
        {
            System.out.println("Nie, Polska nie dogoni Niemcy w przeciągu 20 lat");
        }


        int lataDoPodwojenia = lataDoPodwojeniaPKB();
        System.out.println("Lata potrzebne do podwojenia PKB Polski: " + lataDoPodwojenia);


    }
}
