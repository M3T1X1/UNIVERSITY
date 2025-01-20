public class D
{
    public Point [] array = new Point[100];


    public boolean contains(Point obiekt)
    {
      return array[getIndex(obiekt)] != null;
    }

    public void add(Point obiekt)
    {
        if(contains(obiekt)) return;
        array[getIndex(obiekt)] = obiekt;
    }

    public boolean remove(Point obiekt)
    {
        if(contains(obiekt))
        {
            array[getIndex(obiekt)] = null;
            return true;
        }
        return false;
    }

    private int getIndex(Point objekt)
    {
        return objekt.hashCode() & array.length;
    }

}
