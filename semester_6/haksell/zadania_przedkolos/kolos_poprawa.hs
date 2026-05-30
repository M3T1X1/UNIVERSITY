module Kolos_poprawa where

{-zd1-}

f :: Double -> Double
f x | x < -10 = x*x
    | -10 <= x && x < 0 = sin x
    | 0 <= x && x <= 2 = sqrt x
    | x > 2 = undefined

{-zd2-}
(*.) :: (Double, Double) -> (Double, Double) -> (Double, Double)
(a,b) *. (c,d) = (a * c - b * d, a * d + b * c)

{-zd3-}

seq' 1 = 3
seq' 2 = 4

seq' n | n < 1 = undefined
       | otherwise = 0.5 * seq' (n - 1) + 2 * seq' (n - 2)

{-zd4-}

ltx :: Int -> [Int] -> [Int]
ltx x [] = []
ltx x (y:ys) | y <= x = y:ltx x ys
             | otherwise = ltx x ys

{-zd5-}

data Tree a = Leaf a
            | Node a (Tree a) (Tree a)
            | Null

tree2list :: Tree a -> [a]
tree2list Null = []
tree2list (Leaf a) = [a]
tree2list (Node a left right) = tree2list left ++ [a] ++ tree2list right 

bt1 = Node 7 (Node 4 (Leaf 2) (Leaf 5)) (Leaf 10)
 
bt2 = Node 7 (Node 4 (Leaf 2) (Leaf 5)) 
             (Node 10 (Leaf 9) (Node 13 (Leaf 11) (Leaf 15)))
 
bt3 = Node 7 (Leaf 1) Null

