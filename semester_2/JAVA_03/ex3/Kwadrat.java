package ex3;

public class Kwadrat {
    int a;

    Kwadrat(int a)
    {
        this.a=a;
    }

    public int poleKwadrat()
    {
        int pole = a*a;
        return pole;
    }

    public int obwKwadrat()
    {
        int obw = 4*a;
        return obw;
    }

    public void wyswKwadrat()
    {
        System.out.println("Nazwa: KWADRAT");
        System.out.println("Pole: "+poleKwadrat());
        System.out.println("Obw: "+obwKwadrat());
    }




}
