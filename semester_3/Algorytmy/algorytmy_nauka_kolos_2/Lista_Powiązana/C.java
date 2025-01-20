import java.util.ArrayList;
import java.util.Vector;

public class C {

    public Node first;
    public Node last;

    public int size = 0;

    public void add(Wector vector)
    {
        Node nowyNode = new Node(vector);
        if(this.size == 0)
        {
        this.first = nowyNode;
        this.last = nowyNode;
        }
        else
        {
            Node poprzedniNode = this.last;
            this.last = nowyNode;
            poprzedniNode.next_pointer = nowyNode;
            nowyNode.prev_pointer = poprzedniNode;
        }
        size++;
    }
    public void removeLast()
    {
        if(this.size==0)
        {
            return;
        }
        if(this.size == 1)
        {
         this.last=null;
         this.first=null;
        }
        else
        {
            Node newLast = this.last.prev_pointer;
            this.last = newLast;
            newLast.next_pointer=null;
        }
    }
    public int indexOf(Wector vector)
    {
        if(this.size==0)
        {
            return -1;
        }
        Node aktualny = this.first;
        for(int i=0;i<this.size;i++)
        {
            if(aktualny.vector.equals(vector))
            {
                return i;
            }
            aktualny = aktualny.next_pointer;
        }
        return -1;

    }


    public static void main(String[] args) {
        C lista = new C();

        Wector vector1 = new Wector(1,2,3);
        lista.add(vector1);
        lista.indexOf(vector1);
        lista.removeLast();

    }
}
