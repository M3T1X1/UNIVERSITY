import java.util.Random;

import static java.lang.Math.sin;

public class Figura {

    static double f( double x)
    {
        return sin(2*x + 3.14/2);
    }

    static double g(double x)
    {
        return sin(2*x - 3.14/2);
    }


    public static void main(String[] args)
    {
        Random random = new Random();
        int iloscLosow = 0;
        int iloscTrafien = 0;


        for(int i=0; i<1000; i++)
        {
            double x = random.nextDouble(-1,1);
            double y = random.nextDouble(-1,1);


            if(y <= f(x) && y >= g(x))
            {
                iloscTrafien++;
            }
            iloscLosow++;
        }
        double pole = ((double) iloscTrafien /iloscLosow)*4;
        System.out.println("Pole figury: "+ pole);
    }
}
