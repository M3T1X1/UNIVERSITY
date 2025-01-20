import java.util.Arrays;

public class B {
    private int capacity = 2;
    private int size = 0;

    private Rectangle [] array = new Rectangle[capacity];

    public void add(Rectangle obiekt)
    {
        if(size >= capacity)
        {
            capacity *=2;
            array = Arrays.copyOf(array,capacity);
        }
        array[size] = obiekt;
        size++;
    }

    public Rectangle remove(int index)
    {
        if (index < 0 || index >= this.size)
            throw new IndexOutOfBoundsException();

        Rectangle deletedValue = this.array[index];
        System.arraycopy(this.array, index + 1, this.array, index, this.size - index - 1);
        this.size--;

        return deletedValue;
    }

    public int indexOf(Rectangle objekt)
    {
        if(array.length==0)
        {
            return -1;
        }

        for(int i=0;i<array.length;i++)
        {
            if(array[i].equals(objekt))
            {
                return i;
            }
        }
        return -1;
    }


    public static void main(String[] args) {
        Rectangle t1 = new Rectangle(2,4);
        B lista = new B();

        lista.add(t1);
        lista.add(t1);
        lista.add(t1);


        for(int i=0; i<lista.size;i++)
        {
            System.out.println(lista.array[i].toString());
        }
    }
}
