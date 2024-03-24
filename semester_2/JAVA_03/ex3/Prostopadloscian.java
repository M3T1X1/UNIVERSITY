package ex3;

public class Prostopadloscian {
    int a;
    int b;
    int c;
    Prostopadloscian(int a, int b, int c)
    {
        this.a=a;
        this.b=b;
        this.c=c;
    }

    public double poleProstopadloscian()
    {
        return 2*(a*b+a*c+b*c);
    }

    public double objProstopadloscian()
    {
        return a*b*c;
    }

    public void wyswProstopadloscian()
    {
        System.out.println("Nazwa: PROSTOPADLOSCIAN");
        System.out.println("Pole: "+poleProstopadloscian());
        System.out.println("Obj: "+objProstopadloscian());
    }


}
