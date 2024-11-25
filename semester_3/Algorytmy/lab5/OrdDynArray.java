public class OrdDynArray extends DynArray {
    public OrdDynArray(int capacity) {
        super(capacity);
    }

    @Override
    public void add(int value) {
        if (this.size() == 0) {
            super.add(value);
            return;
        }

        for (int i = 0; i < this.size(); i++) {
            if (this.get(i) > value) {
                super.add(value, i);
                return;
            }
        }

        super.add(value);
    }

    @Override
    public void add(int value, int index) {
        throw new UnsupportedOperationException("Operation add(int value, int index) is not supported in OrdDynArray.");
    }

    @Override
    public int indexOf(int value) {
        int left = 0;
        int right = this.size() - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int midValue = this.get(mid);

            if (midValue == value) {
                return mid;
            } else if (midValue < value) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return -1;
    }

    public static void main(String[] args) {
        OrdDynArray array = new OrdDynArray(2);
        array.add(1);
        array.add(5);
        array.add(2);
        array.add(6);
        array.add(8);

        System.out.println(array);

        System.out.println(array.indexOf(5));
        System.out.println(array.indexOf(1));
        System.out.println(array.indexOf(7));
    }
}
