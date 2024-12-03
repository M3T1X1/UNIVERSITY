public class Person implements Comparable<Person> {
    private String lastName;
    private int age;

    public Person(String lastName, int age) {
        this.lastName = lastName;
        this.age = age;
    }

    public String getLastName() {
        return lastName;
    }

    public int getAge() {
        return age;
    }

    @Override
    public int compareTo(Person other) {
        if (this.age != other.age) {
            return Integer.compare(this.age, other.age);
        }
        return this.lastName.compareTo(other.lastName);
    }

    @Override
    public String toString() {
        return "Person{" +
                "lastName='" + lastName + '\'' +
                ", age=" + age +
                '}';
    }
}