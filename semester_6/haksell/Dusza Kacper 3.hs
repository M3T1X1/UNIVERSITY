-- Homework 3

-- 3.2 - 3.9

-- lab3 - Task 3

-- 3.3
factorial2 :: Integer -> Integer
factorial2 n | n == 0 = 1
             | n == 1 = 1
             | n > 1 = n * factorial2 (n - 2)
{-
ghci> factorial2 4
8
ghci> factorial2 3
3
ghci> 
-}

-- lab3 - Task 3
seq'' :: Integer -> Double
seq'' n | n == 1 = 3
        | n == 2 = 4
        | n > 2 = 0.5 * seq'' (n - 1) + 2 * seq'' (n - 2)
        | otherwise = undefined
{-
ghci> seq'' 2
4.0
ghci> seq'' 3
8.0
ghci> seq'' 6
35.0
-}
        
-- 3.6
gcd' :: Integer -> Integer -> Integer
gcd' a b | a == b = a
         | a > b = gcd' (a - b) b
         | otherwise = gcd' a (b - a)
{-
ghci> gcd' 10 5
5
ghci> gcd' 10 4
2
ghci> gcd' 10 3
1
-}

-- 3.8
infixl 6 +.
(+.) :: (Double, Double) -> (Double, Double) -> (Double, Double)
(a,b) +. (c,d) = (a+c, b+d)
{-
ghci> (2.0, 2.0) +. (1.5, 1.5)
(3.5,3.5)
ghci> (5.0, 2.0) +. (1.5, 1.5)
(6.5,3.5)
-}

infixl 6 -.
(-.) :: (Double, Double) -> (Double, Double) -> (Double, Double)
(a, b) -. (c, d) = (a - c, b - d)
{-
ghci> (2.0, 2.0) -. (1.5, 1.5)
(0.5,0.5)
ghci> (5.0, 2.0) -. (1.5, 1.5)
(3.5,0.5)
-}

infixl 7 *.
(*.) :: (Double, Double) -> (Double, Double) -> (Double, Double)
(a, b) *. (c, d) = (a*c - b*d, a*d + b*c)
{-
ghci> (5.0, 2.0) *. (1.5, 1.5)
(4.5,10.5)
ghci> (2.0, 2.0) *. (1.5, 1.5)
(0.0,6.0)
-}

re :: (Double, Double) -> Double
re (a, _) = a
{-
ghci> re (2.0, 3.0)
2.0
ghci> re (4.0, 3.0)
4.0
-}

im :: (Double, Double) -> Double
im (_, b) = b
{-
ghci> im (2.0, 3.0)
3.0
ghci> im (4.0, 3.0)
3.0
-}

i :: (Double, Double)
i = (0, 1)
{-
ghci> i *. i
(-1.0,0.0)
ghci> i +. (2.0, 3.0)
(2.0,4.0)
-}

-- 3.9
infixl 6 +..
(+..) :: (Double, Double, Double) -> (Double, Double, Double) -> (Double, Double, Double)
(a, b, c) +.. (d, e, f) = (a + d, b + e, c + f)
{-
ghci> (2.0, 3.0, 4.0) +.. (4.0, 5.0, 6.0)
(6.0,8.0,10.0)
-}

infixl 6 -..
(-..) :: (Double, Double, Double) -> (Double, Double, Double) -> (Double, Double, Double)
(a, b, c) -.. (d, e, f) = (a - d, b - e, c - f)
{-
ghci> (2.0, 3.0, 4.0) -.. (4.0, 5.0, 6.0)
(-2.0,-2.0,-2.0)
-}

infixl 7 *..
(*..) :: (Double, Double, Double) -> (Double, Double, Double) -> Double
(a, b, c) *.. (d, e, f) = a*d + b*e + c*f
{-
ghci> (2.0, 3.0, 4.0) *.. (4.0, 5.0, 6.0)
47.0
-}

infixl 7 ***.
(***.) :: (Double, Double, Double) -> (Double, Double, Double) -> (Double, Double, Double)
(a, b, c) ***. (d, e, f) = (b*f - c*e, c*d - a*f, a*e - b*d)
{-
ghci> (2.0, 3.0, 4.0) ***. (4.0, 5.0, 6.0)
(-2.0,4.0,-2.0)
-}