public class OrderedLinkedList {
    private Node2 first;
    private Node2 last;
    private int size = 0;

    public void insert(Person person) {
        Node2 insertedNode = new Node2(person);

        if (this.size == 0) {
            this.first = insertedNode;
            this.last = insertedNode;
        } else {
            Node2 insNext = this.first;
            while (insNext != null && insNext.person.compareTo(person) <= 0) {
                insNext = insNext.next;
            }

            if (insNext == null) {
                Node2 prevLast = this.last;
                this.last = insertedNode;

                insertedNode.prev = prevLast;
                prevLast.next = insertedNode;
            } else if (insNext == this.first) {
                Node2 prevFirst = this.first;
                this.first = insertedNode;

                insertedNode.next = prevFirst;
                prevFirst.prev = insertedNode;
            } else {
                Node2 newPrev = insNext.prev;

                insertedNode.prev = newPrev;
                newPrev.next = insertedNode;

                insertedNode.next = insNext;
                insNext.prev = insertedNode;
            }
        }

        this.size++;
    }

    @Override
    public String toString() {
        StringBuilder txt = new StringBuilder("[ ");
        Node2 currNode = this.first;
        while (currNode != null) {
            txt.append(currNode.person).append(" ");
            currNode = currNode.next;
        }
        txt.append("]");
        return txt.toString();
    }

    public static void main(String[] args) {
        OrderedLinkedList list = new OrderedLinkedList();

        list.insert(new Person("Kapitan", 30));
        list.insert(new Person("Bomba", 25));
        list.insert(new Person("Tytus", 25));


        System.out.println(list);
    }
}