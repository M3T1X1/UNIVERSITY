package ex2;

import java.util.Scanner;

public class Zadania {
    static Auto wpisz() {
        Scanner skaner = new Scanner(System.in);
        System.out.println("Podaj marke samochodu: ");
        String marka = skaner.next();

        System.out.println("Podaj model samochodu: ");
        String model = skaner.next();

        System.out.println("Podaj rocznik samochodu: ");
        int rocznik = skaner.nextInt();

        Auto auto01 = new Auto(marka, model, rocznik);

        return auto01;

    }

    public static void main(String[] args) {
        Auto auto02 = wpisz();
        System.out.println("Model marka:" + auto02.marka);
        System.out.println("Model model:" + auto02.model);
        System.out.println("Rocznik: " + auto02.rocznik);
    }
}
