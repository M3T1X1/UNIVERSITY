
import java.util.Scanner;
public class zad1i2 {


        public static void main(String[] args) {

            //ZD.1
            // DELTA = b^2-4*a*c

            Scanner Obj = new Scanner(System.in);

            System.out.println("Podaj a:");
            int a = Obj.nextInt();
            System.out.println("Podaj b:");
            int b = Obj.nextInt();
            System.out.println("Podaj c:");
            int c = Obj.nextInt();

            double delta = (Math.pow(b, 2) - 4 * a * c);
            System.out.println("Delta wynosi: " + delta);
            double pierw_delta = Math.sqrt(delta);

            double x1 = (Math.pow(b, 2) - pierw_delta) / (2 * a);
            double x2 = (Math.pow(b, 2) + pierw_delta) / 2 * a;
            if(delta<0) {
                System.out.println("Brak wynikow");
            }
            else if (delta==0)
            {
                System.out.println("x1: "+pierw_delta/2*a);
            }
            else
            {
                System.out.println("x1 wynosi: " + x1);
                System.out.println("x2 wynosi: " + x2);
            }
            }

         /*
            //ZD.2

            System.out.println("Podaj działanie: +, -, /, *, ^, //, sin, tg )");

            Scanner skaner = new Scanner(System.in);

            String dzialanie = skaner.nextLine();
            System.out.println(dzialanie);

            if ("+".equals(dzialanie)) {
                System.out.println("Podaj a:");
                int a = skaner.nextInt();
                System.out.println("Podaj b:");
                int b = skaner.nextInt();

                System.out.println(a + b);
            } else if ("-".equals(dzialanie)) {
                System.out.println("Podaj a:");
                int a = skaner.nextInt();
                System.out.println("Podaj b:");
                int b = skaner.nextInt();

                System.out.println(a - b);
            } else if ("/".equals(dzialanie)) {
                System.out.println("Podaj a:");
                int a = skaner.nextInt();
                System.out.println("Podaj b:");
                int b = skaner.nextInt();

                System.out.println(a / b);
            } else if ("*".equals(dzialanie)) {
                System.out.println("Podaj a:");
                int a = skaner.nextInt();
                System.out.println("Podaj b:");
                int b = skaner.nextInt();

                System.out.println(a * b);
            } else if ("^".equals(dzialanie)) {
                System.out.println("Podaj podstawe potegi: ");
                int a = skaner.nextInt();
                System.out.println("Podaj wykladnik potegi: ");
                int b = skaner.nextInt();
                double potega = Math.pow(a, b);

                System.out.println(potega);
            } else if ("//".equals(dzialanie)) {
                System.out.println("Podaj podpierwiastkowa: ");
                int a = skaner.nextInt();

                double pierw = Math.sqrt(a);

                System.out.println(pierw);
            } else if ("<".equals(dzialanie) || ">".equals(dzialanie)) {
                System.out.println("Podaj kat:");
                int a = skaner.nextInt();
                System.out.println("Sin:"+Math.sin(a));
                System.out.println("Cos:"+Math.cos(a));
                System.out.println("Tan:"+Math.tan(a));
                System.out.println("Ctg:"+(1/Math.tan(a)));
            }

          */
        }

