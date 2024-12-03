public class Node {
    int value;
    Node prev;
    Node next;

    public Node(int value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Node(" + this.value + ")";
    }

    public static void main(String[] args) {
        Node node = new Node(4);
        System.out.println(node);
    }
}
