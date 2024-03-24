package WprowadzDane;

import ex1.Student;
public class ex4 extends Student
{
    Student[] arr =new Student[100];

    public void tworzObiekt()
    {
        for(int i=0;i< arr.length;i++)
        {
        arr[i] = new Student();
        System.out.println(arr[i].imie+arr[i].rok_studiow);
        }

    }


}
