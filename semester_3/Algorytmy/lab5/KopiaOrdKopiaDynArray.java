public class KopiaOrdKopiaDynArray<T extends Comparable<T>> extends KopiaDynArray<T> {
    public KopiaOrdKopiaDynArray(int initialCapacity) {
        super(initialCapacity);
    }

    @Override
    public void add(T value) {
        if (this.size() == 0) {
            super.add(value);
            return;
        }

        for (int i = 0; i < this.size(); i++) {
            if (this.get(i).compareTo(value) > 0) {
                super.add(value, i);
                return;
            }
        }

        super.add(value);
    }

    @Override
    public void add(T value, int index) {
        throw new UnsupportedOperationException("Metoda add(T value, int index) nie jest obsługiwana przez klasę OrdDynArray.");
    }

    @Override
    public int indexOf(T value) {
        int left = 0, right = this.size() - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            T midValue = this.get(mid);

            int cmp = midValue.compareTo(value);
            if (cmp == 0) return mid;
            else if (cmp < 0) left = mid + 1;
            else right = mid - 1;
        }
        return -1;
    }
}