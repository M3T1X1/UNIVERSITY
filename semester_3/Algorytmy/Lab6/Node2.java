public class Node2 {
    Person person;
    Node2 prev;
    Node2 next;

    public Node2(Person person) {
        this.person = person;
    }

    @Override
    public String toString() {
        return "Node2{" + "person=" + person + '}';
    }

    public static void main(String[] args) {
        Person person = new Person("Kowalski", 30);
        Node2 node = new Node2(person);
        System.out.println(node);
    }
}