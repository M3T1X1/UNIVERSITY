public class ex4 {
    public static void main(String[] args) {
        // ! NOT
        //1=0;0=1
        // ^ XOR
        //1,1=1;0,0=1
        int a = 4;//0100
        int b = 2;//0010
        int c = a^b;//1001

        if(b!=11)
        {
            System.out.println("B nie jest rowne 11");
        }
        System.out.println(c);
    }
}
