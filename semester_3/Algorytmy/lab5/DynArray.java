public class DynArray {
    public static final int DEFAULT_CAPACITY = 4;
    private int[] elements;
    private int size;

    public DynArray(int capacity) {
        this.elements = new int[capacity];
        this.size = 0;
    }

    public DynArray() {
        this.elements = new int[DEFAULT_CAPACITY];
        this.size = 0;
    }

    private void ensureCapacity() {
        if (this.elements.length == this.size) {
            int[] newElements = new int[this.elements.length * 2];
            System.arraycopy(this.elements, 0, newElements, 0, this.elements.length);
            this.elements = newElements;
        }
    }

    public int size() {
        return this.size;
    }

    public void add(int value) {
        ensureCapacity();
        this.elements[this.size] = value;
        this.size++;
    }

    public int get(int index) {
        return this.elements[index];
    }

    public void add(int value, int index) {
        if (index < 0 || index > this.size) {
            throw new IndexOutOfBoundsException();
        }
        ensureCapacity();
        System.arraycopy(this.elements, index, this.elements, index + 1, this.size - index);
        this.elements[index] = value;
        this.size++;
    }

    public int remove(int index) {
        if (index < 0 || index >= this.size) {
            throw new IndexOutOfBoundsException();
        }
        int removedValue = this.elements[index];
        System.arraycopy(this.elements, index + 1, this.elements, index, this.size - index - 1);
        this.size--;
        return removedValue;
    }

    public int indexOf(int value) {
        for (int i = 0; i < this.size; i++) {
            if (this.elements[i] == value) {
                return i;
            }
        }
        return -1;
    }

    @Override
    public String toString() {
        StringBuilder result = new StringBuilder("[ ");
        for (int i = 0; i < this.size; i++) {
            result.append(elements[i]).append(" ");
        }
        return result.append("]").toString();
    }

    public static void main(String[] args) {
        DynArray array = new DynArray(2);
        array.add(1);
        array.add(2);
        array.add(99, 1);
        array.add(98, 1);
        array.add(97, 0);
        array.add(13, array.size());
        System.out.println(array);

        array.remove(2);
        System.out.println(array);

        array.remove(2);
        System.out.println(array);

        int index = array.indexOf(13);
        System.out.println(index);
    }
}
