package ex3;

public class Szescian {
    int a;

    Szescian(int a)
    {
        this.a=a;
    }

    public double poleSzescian()
    {
        return 6*Math.pow(a,2);
    }

    public double objSzescian()
    {
        return Math.pow(a,3);
    }

    public void wyswSzescian()
    {
        System.out.println("Nazwa: SZESCIAN");
        System.out.println("Pole: "+poleSzescian());
        System.out.println("Obj: "+objSzescian());
    }
}
