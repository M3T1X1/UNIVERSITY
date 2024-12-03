
public class LinkedList {
    private Node first;
    private Node last;
    private int size = 0;

    public int size() {
        return size;
    }

    public int getFirst() {
        return this.first.value;
    }

    public void insertLast(int value) {
        Node newNode = new Node(value);
        if (this.size == 0) {
            this.first = newNode;
            this.last = newNode;
        } else {
            Node prevLast = this.last;
            this.last = newNode;
            newNode.prev = prevLast;
            prevLast.next = newNode;
        }
        this.size++;
    }

    public int removeLast() {
        if (this.size == 0) {
            throw new IndexOutOfBoundsException("List is empty.");
        }
        int retVal = this.last.value;
        if (this.size == 1) {
            this.first = null;
            this.last = null;
        } else {
            Node newLast = this.last.prev;
            this.last = newLast;
            newLast.next = null;
        }
        this.size--;
        return retVal;
    }

    public void insertFirst(int value) {
        Node newNode = new Node(value);
        if (this.size == 0) {
            this.first = newNode;
            this.last = newNode;
        } else {
            Node prevFirst = this.first;
            this.first = newNode;
            newNode.next = prevFirst;
            prevFirst.prev = newNode;
        }
        this.size++;
    }

    public int removeFirst() {
        if (this.size == 0) {
            throw new IndexOutOfBoundsException("List is empty.");
        }
        int retVal = this.first.value;
        if (this.size == 1) {
            this.first = null;
            this.last = null;
        } else {
            Node newFirst = this.first.next;
            this.first = newFirst;
            newFirst.prev = null;
        }
        this.size--;
        return retVal;
    }

    public int removeAt(int index) {
        if (index < 0 || index >= this.size) {
            throw new IndexOutOfBoundsException("Index out of bounds.");
        }
        if (index == 0) {
            return removeFirst();
        }
        if (index == this.size - 1) {
            return removeLast();
        }

        Node currNode = this.first;
        for (int i = 0; i < index; i++) {
            currNode = currNode.next;
        }

        int retVal = currNode.value;
        Node prevNode = currNode.prev;
        Node nextNode = currNode.next;

        prevNode.next = nextNode;
        nextNode.prev = prevNode;
        this.size--;
        return retVal;
    }

    @Override
    public String toString() {
        String txt = "[ ";
        if (size == 0)
            return txt + "]";
        Node currNode = this.first;
        for (int i = 0; i < this.size; i++) {
            txt += currNode.value + " ";
            currNode = currNode.next;
        }
        return txt + "]";
    }

    public static void main(String[] args) {
        LinkedList list = new LinkedList();

        list.insertFirst(10);
        list.insertFirst(20);
        list.insertLast(30);
        System.out.println(list);

        System.out.println(list.removeFirst());
        System.out.println(list);

        list.insertFirst(40);
        System.out.println(list);

        System.out.println(list.removeAt(1));
        System.out.println(list);

        System.out.println(list.removeLast());
        System.out.println(list);
    }
}