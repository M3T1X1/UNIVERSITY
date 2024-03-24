package ex3;

public class Prostokat {
    int a;
    int b;

    Prostokat(int a,int b)
    {
        this.a=a;
        this.b=b;
    }

    public int poleProstokat()
    {
        return a*b;
    }

    public int obwProstokat()
    {
        return (2*a)+(2*b);
    }

    public void wyswProstokat()
    {
        System.out.println("Nazwa: PROSTOKAT");
        System.out.println("Pole: "+poleProstokat());
        System.out.println("Obw: "+obwProstokat());
    }

}
