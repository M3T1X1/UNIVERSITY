public class ex6 {
    //zad 6
    public static void main(String[] args) {


    // char[] toCharArray() zmienia string w tablice znaków
/*
        String text = "Kapitan bomba";

        char[] charArray = text.toCharArray();

        for(char x : charArray) {
            System.out.print(x);
        }
        System.out.println();
*/

    // byte[] getBytes() zmienia  tekst na tabalice znaków
    /*
        String text = "Admiral Jachas";

        byte[] byteArray = text.getBytes();

        for(byte b : byteArray) {
            System.out.print(b);
        }
    */

        //boolean equals(String str) porównuje wartość dwóch stringow i zwraca TRUE lub FALSE

    /*
        String A = "a";
        String B = "A";
        String C = "aA";

        System.out.println("A ?= B " + A.equals(B));
        System.out.println("A ?= C " + A.equals(C));
    */

        /* boolean equalsIgnoreCase(String str)porównuje wartość dwóch stringow i zwraca TRUE lub FALSE jenak nie patrzy na wielkosc liter */
        /*
        String A = "AAAAA";
        String B = "aaaaa";

        System.out.println(" A ?= B " + A.equalsIgnoreCase(B));
        */

    // int campareTo(String str) porównuje 2 stringi leksygonalnie
        /*
        String A = "xyz";
        String B = "zyx";

        int result1 = A.compareTo(B);
        System.out.println(result1);

        String C = "ala";
        String D = "ala";

        int result2 = C.compareTo(D);
        System.out.println(result2);
        */

        /* int campareToIgnoreCase(String str) porównuje 2 stringi leksygonalnie
        nie zwracając uwagi na wielkość znaków */
        /*
        String a = "abc";
        String b = "ABC";

        int result = a.compareToIgnoreCase(b);
        System.out.println(result);
        */

    // int indexOf(int i) wyszukuje znak w tekscie i podaje pierwszy jego indeks
        /*
        String a = "jaroslaw";
        int result = a.indexOf((int) 'j');

        System.out.println(result);
        */

        /* int indexOf(String str) wyszukuje pierwszą pozycje wystąpienia ciągu
        znaków w łańcuchu znaków*/
        /*
        String a = "gratis to uczciwa cena";
        String x = "cena";
        int result = a.indexOf(x);

        System.out.println(result);
        */

    // int lastIndexOf(int i) pokazuje ostatnia pozycje wystapienia znaku
        /*
        String a = "Makao";
        int result = a.lastIndexOf((int) 'a');

        System.out.println(result);
        */

        /* int lastIndexOf(String str) zwraca pozycja sotatniego wystąpienia
        ciągu znaków */
        /*
        String a = "Po makale karta stop";
        String x = "stop";
        int result = a.lastIndexOf(x);

        System.out.println(result);
        */

        /* String substring(int startString) pobiera podciąg znaków zaczynając
        od wybranego indexu*/
    /*
        String a = "srednia hawajska dla wszystkich";
        String b = a.substring(17);

        System.out.println(a);
        System.out.println(b + " cieple piwerko");
    */

        /* String substring(int startString, int stopString)pobiera fragment
        znaków od pozycji początkowej do końcowej*/
    /*
        String a = "Ooo wypraszam sobie, ja jestem ze strazy miejskiej";
        String b = a.substring(31, 50);

        System.out.println(a);
        System.out.println(b);
    */

        /* String replace(char orginal, char zamiennik) podmienia w stringu
        dany znak na inny*/
        /*
        String a = "Balkany";
        String b = a.replace("k", "w");

        System.out.println(a);
        System.out.println(b);
        */

    // String trim() usuwa białe znaki z początku i końca stringa
        /*
        String a = "   sum krolem wod     ";
        String b = a.trim();

        System.out.println(a);
        System.out.println(b);
        */

    // String toLowerCase() zamienia duże znaki na małe
        /*
        String a = "AaaaAAAaaAAaa";
        String b = a.toLowerCase();

        System.out.println(a);
        System.out.println(b);
        */

    // String toUpperCase() zmiaenia małę znaki na duże
        /*
        String a = "tanio";
        String b = a.toUpperCase();

        System.out.println(a);
        System.out.println(b);
        */

        /* String[] split(String regex, int limit) dzieli łańcuch znaków na
        podstawie określonego wyrażenia ragularnego. Tworzy tablice stringów
        o podanym limicie */
    /*
        String a = "moto komando";
        String[] result = a.split(" ", 4);

        for(String res : result){
            System.out.println(res);
        }
    */

    // String[] split(String regex) robi to samo tylko bez limitu
        /*
        String a = "moto komando";
        String[] result = a.split("komando");

        for(String res : result){
            System.out.println(res);
        }
        */

}}
