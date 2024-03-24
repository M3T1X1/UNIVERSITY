public class ex2 {
    public static void main(String[] args)
    {
        //&& to operator logiczny, a & to operator bitowy
        //&& używany jest booleanach
        //& używany jest do wartosci bitowych liczb

        int a=2;//010
        int b=3;//011
        int c = a&b;//iloczyn bitowy
        int d = a|b;//suma bitowa

        if(a==2 & b==3)
        {
            System.out.println("Wszystkie warunki spelnione");
            //Program sprawdza 2 warunki, jesli pierwszy jest FALSE to program nie sprawdza nastepnych warunkow tylko zwraca FALSE
        }
        System.out.println("C= "+c);

        if(a==2 || b==3)
        {
            //Program sprawdza czy przynajmniej jeden warunek jest TRUE, jesli tak to zwraca TRUE
            System.out.println("Przynajmniej jeden warunek spelniony");
        }
        System.out.println("D= "+d);
    }
}
