package ex3;

public class Stozek {
    int r;
    int l;
    int h;


    Stozek(int r, int l,int h) {
        this.r = r;
        this.l = l;
        this.h=h;
    }

    public double poleStozek() {
        return (3.14 * Math.pow(r, 2) + 3.14 * r * l);
    }

    public double objStozek()
    {
        return (3.14*Math.pow(r,2)/3)*h;
    }
    public void wyswStozek()
    {
        System.out.println("Nazwa: STOZEK");
        System.out.println("Pole: "+poleStozek());
        System.out.println("Obj: "+objStozek());
    }

}