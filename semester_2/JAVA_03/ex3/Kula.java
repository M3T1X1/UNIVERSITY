package ex3;

public class Kula {
    double r;
    Kula(double r) {
        this.r = r;
    }

    public double poleKula()
    {
        double pole = 4*3.14*Math.pow(r,2);
        return pole;
    }
    public double objKula()
    {
        double obj = (4/3*3.14*Math.pow(r,3));
        return obj;
    }

    public void wyswKula()
    {
        double pole_kula=poleKula();
        double obj_kula=objKula();
        System.out.println("Nazwa: KULA");
        System.out.println("Pole: "+pole_kula);
        System.out.println("Obj: "+obj_kula);
    }

}