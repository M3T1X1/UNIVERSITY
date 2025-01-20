import java.util.Objects;

public class Rectangle {
    int a;
    int h;

    public Rectangle(int a, int h)
    {
        this.a=a;
        this.h=h;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Rectangle rectangle = (Rectangle) o;
        return a == rectangle.a && h == rectangle.h;
    }

    @Override
    public int hashCode() {
        return Objects.hash(a, h);
    }

    @Override
    public String toString() {
        return "Rectangle{" +
                "a=" + a +
                ", h=" + h +
                '}';
    }
}
