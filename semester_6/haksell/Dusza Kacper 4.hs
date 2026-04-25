-- Homework 4

-- 4.1 - 4.8

-- lab4 - Task 1 - Task 4

module Lists where

import Data.Char

-- Task 1
{-
(_:x:xs)
[3,5,7] -> [7]

sum1 [3,5,7] = 5 + sum1 [7] = 5 + 0 = 5

(_:x:xs)     (_:x:xs)
[3,5,7,9] -> [7,9] -> []

sum1 [3,5,7,9] = 5 + sum1 [7,9] = 5 + 9 + sum1 [] = 5 + 9 + 0 = 14
-}

-- 4.2.2
sum2 [] = 0
sum2 [x] = x
sum2 (x:_:xs) = x + sum2 xs
{-
ghci> sum2 []
0
ghci> sum2 [3]
3
ghci> sum2 [3, 5, 7]
10
-}

-- Task 2
{-
(x:_:xs)
[3,5,7] -> [7]

sum2 [3,5,7] = 3 + sum2 [7] = 3 + 7 = 10

(x:_:xs)    (x:_:xs)
[3,5,7,9] -> [7,9] -> []

sum2 [3,5,7,9] = 3 + sum2 [7,9] = 3 + 7 + sum2 [] = 3 + 7 + 0 = 10
-}

-- 4.2.3
sum3 (_:_:_:xs) = pom xs
  where
    pom (x:_:_:rest) = x + pom rest
    pom (x:_)          = x
    pom []             = 0
sum3 _ = 0
{-
ghci> sum3 []
0
ghci> sum3 [3]
0
ghci> sum3 [3,5]
0
ghci> sum3 [3,5,7]
0
ghci> sum3 [3,5,7,9]
9
ghci> sum3 [3,5,7,9,11]
9
ghci> sum3 [3,5,7,9,11,13]
9
ghci> sum3 [3,5,7,9,11,13,15]
24
-}

-- Task 3 
{-
(x:xs)           (x:xs)
['B','o','b'] -> ['o','b'] -> ['b'] -> []

countLower ['B','o','b'] = countLower ['o','b'] = 1 + countLower ['b'] = 1 + 1 countLower [] = 1 + 1 + 0 = 2
-}

-- 4.3.2
countLowerUpper [] = (0, 0)
countLowerUpper (x:xs)| 'a' <= x && x <= 'z' = (m + 1, w)
                      | 'A' <= x && x <= 'Z' = (m, w + 1)
                      | otherwise            = (m, w)
                          where
                            (m, w) = countLowerUpper xs
{-
ghci> countLowerUpper []
(0,0)
ghci> countLowerUpper "Cat Bob"
(4,2)
ghci> countLowerUpper "cat bob"
(6,0)
ghci> countLowerUpper "CAT BOB"
(0,6)
-}  

-- 4.4
string2bools xs = map isLower xs
{-
ghci> string2bools "CAt Bob."
[False,False,True,False,False,True,True,False]
-}

-- 4.5.2
cltx x [] = 0
cltx x (y:ys) | x > y = 1 + cltx x ys
              | otherwise = cltx x ys
{-
ghci> cltx 3 []
0
ghci> cltx 3 [1,2,3,4,5,6,7]
2
-}

-- Task 4
{-
(x:xs)     (x:xs)
[2,1,3] -> [1,3] -> [3] -> []

gtx 1 [2,1,3] = 2 : gtx 1 [1,3] = 2 : gtx 1 [3] = 2 : 3 : gtx 1 [] = 2 : 3 : [] = [2,3]
-}

-- 4.5. 4
ltx x [] = []
ltx x (y:ys) | x >= y = y : ltx x ys
             | otherwise = ltx x ys
{-
ghci> ltx 1 []
[]
ghci> ltx 1 [2,1,3]
[1]
ghci> ltx 5 [2,5,3,6]
[2,5,3]
-}
