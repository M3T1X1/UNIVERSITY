package ex3;

public class Kolo {
    double r;

    Kolo(double r) {
        this.r = r;
    }

    public double poleKolo() {
        double pole_kolo = 3.14 * Math.pow(r, 2);
        return pole_kolo;

    }

    public double obwKolo() {
        double obw_kolo = 2 * 3.14 * r;
        return obw_kolo;
    }

    public void wyswKolo()
    {
        double obw_kolo = obwKolo();
        double pole_kolo = poleKolo();
        System.out.println("Nazwa: KOLO");
        System.out.println("Pole: "+pole_kolo);
        System.out.println("Obw: "+obw_kolo);
    }


}



