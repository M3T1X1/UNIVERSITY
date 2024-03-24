package ex1;

public class Zadania {
    public static void main(String[] args) {
        Student student0 = new Student(1);
        Student student01 = new Student("Kacper", "Mlot");
        Student student02 = new Student("Kacper");
       // Student student03 = new Student("Kacper", "Mlot", 3);

        student0.wyswietl();
        student01.wyswietl();
        student02.wyswietl();
       // student03.wyswietl();
    }
}
