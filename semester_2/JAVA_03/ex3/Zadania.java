package ex3;

public class Zadania {

    public static void main(String[] args)
    {
        //KOŁO
        Kolo kolo01 = new Kolo(3);
        kolo01.wyswKolo();

        //KULA
        Kula kula01 = new Kula(3);
        kula01.wyswKula();

        //KWADTAT
        Kwadrat kwadrat01 = new Kwadrat(3);
        kwadrat01.wyswKwadrat();

        //PROSTOKĄTK
        Prostokat prostokat01 = new Prostokat(4,3);
        prostokat01.wyswProstokat();

        //PROSTOPADLOSCIAN
        Prostopadloscian prostopadloscian01 = new Prostopadloscian(4,5,6);
        prostopadloscian01.wyswProstopadloscian();

        //STOŻEK
        Stozek stozek01 = new Stozek(4,5,6);
        stozek01.wyswStozek();

        //SZESCIAN

        Szescian szescian01 = new Szescian(5);
        szescian01.wyswSzescian();

    }
}

