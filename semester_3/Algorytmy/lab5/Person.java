public class Person implements Comparable<Person>
{
    private String name;
    private String surname;

    public Person(String name, String surname)
    {
        this.name = name;
        this.surname = surname;
    }

    public String getName()
    {
        return name;
    }

    public String getSurname()
    {
        return surname;
    }

    @Override
    public int compareTo(Person other)
    {
        int surnameComparison = this.surname.compareTo(other.surname);
        return (surnameComparison != 0) ? surnameComparison : this.name.compareTo(other.name);
    }

    @Override
    public String toString()
    {
        return surname + " " + name;
    }
}