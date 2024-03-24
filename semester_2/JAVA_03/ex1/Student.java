package ex1;

public class Student {
    public String imie;
    public String nazwisko;
    public int nr_indeksu;
    public String nazwa_specjalnosci;
    public int rok_studiow;

    Student(String imie) {
        this.imie = imie;
    }

    Student(String imie, String nazwisko) {
        this.imie = imie;
        this.nazwisko = nazwisko;
    }

    Student(int rok_studiow) {
        this.rok_studiow = rok_studiow;
    }

    public Student(String imie, String nazwisko, int rok_studiow,int nr_indeksu,String nazwa_specjalnosci) {
        this.imie = imie;
        this.nazwisko = nazwisko;
        this.rok_studiow = rok_studiow;
        this.nr_indeksu=nr_indeksu;
        this.nazwa_specjalnosci=nazwa_specjalnosci;
    }
    public Student()
    {
        this.imie = " ";
        this.nazwisko = " ";
        this.nr_indeksu = 0;
        this.nazwa_specjalnosci = " ";
        this.rok_studiow = 0;
    }


    void wyswietl() {
        System.out.println("Imie: " + imie);
        System.out.println("Nazwisko: " + nazwisko);
        System.out.println("Rok Studiow: " + rok_studiow);
    }

}
