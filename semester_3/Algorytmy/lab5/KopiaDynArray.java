import java.util.Arrays;

public class KopiaDynArray<T extends Comparable<T>> {
    public static final int DEFAULT_INITIAL_CAPACITY = 4;
    private T[] tab;
    private int currSize;

    @SuppressWarnings("unchecked")
    public KopiaDynArray(int initialCapacity) {
        this.tab = (T[]) new Comparable[initialCapacity];
        this.currSize = 0;
    }

    public KopiaDynArray() {
        this(DEFAULT_INITIAL_CAPACITY);
    }

    private void increaseCapacityIfNeeded() {
        if (this.tab.length == this.currSize) {
            this.tab = Arrays.copyOf(this.tab, this.tab.length * 2);
        }
    }

    public int size() {
        return this.currSize;
    }

    public void add(T value) {
        this.increaseCapacityIfNeeded();
        this.tab[this.currSize++] = value;
    }

    public T get(int index) {
        if (index < 0 || index >= this.currSize) throw new IndexOutOfBoundsException();
        return this.tab[index];
    }

    public void add(T value, int index) {
        if (index < 0 || index > this.currSize) throw new IndexOutOfBoundsException();
        this.increaseCapacityIfNeeded();
        System.arraycopy(this.tab, index, this.tab, index + 1, this.currSize - index);
        this.tab[index] = value;
        this.currSize++;
    }

    public T remove(int index) {
        if (index < 0 || index >= this.currSize) throw new IndexOutOfBoundsException();
        T deletedValue = this.tab[index];
        System.arraycopy(this.tab, index + 1, this.tab, index, this.currSize - index - 1);
        this.currSize--;
        return deletedValue;
    }

    public int indexOf(T value) {
        for (int i = 0; i < this.currSize; i++) {
            if (this.tab[i].compareTo(value) == 0) return i;
        }
        return -1;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("[ ");
        for (int i = 0; i < this.currSize; i++) {
            sb.append(this.tab[i]).append(" ");
        }
        return sb.append("]").toString();
    }
}