public class main {
    public static void main(String[] args) {
        KopiaOrdKopiaDynArray<Person> persons = new KopiaOrdKopiaDynArray<>(2);

        persons.add(new Person("Tytus", "Bomba"));
        persons.add(new Person("Sebek", "Bak"));


        System.out.println(persons);

        Person search = new Person("Janusz", "Esaerem");
        System.out.println(search + ": " + persons.indexOf(search));
    }
}