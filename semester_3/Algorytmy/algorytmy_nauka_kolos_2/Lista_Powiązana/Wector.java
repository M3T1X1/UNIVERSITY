import java.util.Objects;

public class Wector {
    public int x;
    public int y;
    public int z;

    public Wector(int x, int y, int z)
    {
        this.x=x;
        this.y=y;
        this.z=z;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Wector wector = (Wector) o;
        return x == wector.x && y == wector.y && z == wector.z;
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y, z);
    }
}
