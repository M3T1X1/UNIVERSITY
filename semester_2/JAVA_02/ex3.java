public class ex3 {
    public static void main(String[] args)
    {
        // << przemieszta wartosc o jeden bit w lewo
        // >> przemieszta wartosc o jeden bit w prawo
        int a = 10;
        int res_1 = a >> 1;
        int res_2 = a << 1;
        System.out.println("A = "+a);
        System.out.println("A jeden bit w prawo = "+res_1);
        System.out.println("A jeden bit w lewo = "+res_2);

    }
}
