package WprowadzDane;

import ex1.Student;

import java.util.Scanner;

public class Main extends ex4 {
    public static void main(String[] args) {
        ex4 student = new ex4();
        student.tworzObiekt();
        Main student01 = new Main();
        student01.input();
        //student01.overwrite();
        //student01.delete();
        //student01.printObj();
        //student01.printAll(); //Program wyświtla błąd ponieważ inne indexy mają wartość null
        //student01.printFromTo();
    }

    public void input()
    {
        Scanner skaner = new Scanner(System.in);

        System.out.println("Podaj index:");
        int index = skaner.nextInt();

        System.out.println("Podaj imie:");
        imie = skaner.next();

        System.out.println("Podaj nazwisko:");
        nazwisko = skaner.next();

        System.out.println("Podaj nazwe specjalnosci: ");
        nazwa_specjalnosci = skaner.next();

        System.out.println("Podaj rok stuidow:");
        rok_studiow = skaner.nextInt();

        if(nr_indeksu>-1 && nr_indeksu<101)
        {
            arr[index]= new Student(imie,nazwisko,rok_studiow,nr_indeksu,nazwa_specjalnosci);
        }
        System.out.println(arr[index].imie+" "+arr[index].nazwisko+" "+arr[index].nazwa_specjalnosci+" "+arr[index].rok_studiow);

    }
    public void overwrite()
    {
        Scanner skaner = new Scanner(System.in);

        System.out.println("Podaj index:");
        int index = skaner.nextInt();

        System.out.println("Podaj imie:");
        imie = skaner.next();

        System.out.println("Podaj nazwisko:");
        nazwisko = skaner.next();

        System.out.println("Podaj nazwe specjalnosci: ");
        nazwa_specjalnosci = skaner.next();

        System.out.println("Podaj rok stuidow:");
        rok_studiow = skaner.nextInt();

        System.out.println("Aktualne dane: "+arr[index].imie+" "+arr[index].nazwisko+" "+arr[index].nazwa_specjalnosci+" "+arr[index].rok_studiow);

        if(nr_indeksu>-1 && nr_indeksu<101)
        {
            arr[index]= new Student(imie,nazwisko,rok_studiow,nr_indeksu,nazwa_specjalnosci);
        }
        System.out.println("Dane po zmianie: "+arr[index].imie+" "+arr[index].nazwisko+" "+arr[index].nazwa_specjalnosci+" "+arr[index].rok_studiow);
    }
    public void delete()
    {
        Scanner skaner = new Scanner(System.in);

        System.out.println("Podaj index:");
        int index = skaner.nextInt();
        imie = " ";
        nazwisko = " ";
        nazwa_specjalnosci = " ";
        rok_studiow = 0;

        if(nr_indeksu>-1 && nr_indeksu<101)
        {
            arr[index]= new Student(imie,nazwisko,rok_studiow,nr_indeksu,nazwa_specjalnosci);
        }
        System.out.println("Usunięto dane z indeksu: "+index);
    }

    public void printObj()
    {
        Scanner skaner = new Scanner(System.in);
        System.out.println("Podaj index: ");
        int index = skaner.nextInt();

        if(nr_indeksu>-1 && nr_indeksu<101)
        {
            arr[index]= new Student(imie,nazwisko,rok_studiow,nr_indeksu,nazwa_specjalnosci);
        }
    }

    public void printAll()
    {
        for(int i=0;i< arr.length;i++)
        {
            System.out.println(arr[i].imie);
            System.out.println(arr[i].nazwisko);
            System.out.println(arr[i].nazwa_specjalnosci);
            System.out.println(arr[i].rok_studiow);
        }
    }
    public void printFromTo()
    {
        Scanner skaner = new Scanner(System.in);
        System.out.println("Podaj index poczatkowy: ");
        int from = skaner.nextInt();
        System.out.println("Podaj index koncowy: ");
        int to = skaner.nextInt();

        for(int i=0;i< arr.length;i++)
        {
            if(i>from && i<to)
            {
                System.out.println(arr[i].imie);
                System.out.println(arr[i].nazwisko);
                System.out.println(arr[i].nazwa_specjalnosci);
                System.out.println(arr[i].rok_studiow);
            }
        }
    }

}
