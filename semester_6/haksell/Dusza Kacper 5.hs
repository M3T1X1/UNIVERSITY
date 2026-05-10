-- Homework 5

-- 5.1 - 5.7

-- lab5 - Task 1 - Task 6

-- homework

-- slide 30/71

infix 5 ~=
(~=) :: Double -> Double -> Bool
a ~= b = abs (a - b) < h where h = 0.000001

cubeRoot :: Double -> Double
cubeRoot x = until goodEnough improve 1.0
    where improve y = 1/3 * (2*y + x / (y ** 2))
          goodEnough y = (y * y * y) ~= x

{-
ghci> cubeRoot 12.4
2.3145890545258796
ghci> cubeRoot 2.3
1.3200061242705372
ghci> cubeRoot 1.2
1.0626585693955253
ghci> cubeRoot 4
1.5874010520152706
ghci> cubeRoot 8
2.000000000012062
-}


{- Task 1 *

Provide an analogous deriving for the Left Riemann sum.

-}

leftRiemannSum :: (Double -> Double) -> Double -> Double -> Int -> Double
leftRiemannSum f a b n = sum [f (a + fromIntegral i * h) * h | i <- [0..n-1]]
  where
    h = (b - a) / fromIntegral n

-- 5.3 *

-- homework

trapezoidalRule :: (Double -> Double) -> Double -> Double -> Int -> Double
trapezoidalRule f a b n = (h / 2) * (f a + f b ) + sum [h * f (a + fromIntegral i * h) | i <- [1..n-1]]
    where
        h = (b - a) / fromIntegral n

{-
ghci> trapezoidalRule (\x -> x**2) 0 1 10
0.3350000000000001
ghci> trapezoidalRule (\x -> x**2) 0 1 100
0.33335000000000015
ghci> trapezoidalRule sin 0 pi 100
1.9998355038874436
-}

-- 

-- 5.6.1 *

data Tree a = Null
            | Leaf a
            | Node a (Tree a) (Tree a)
            deriving (Show)

treeSize :: Tree a -> Int

treeSize Null = 0
treeSize (Leaf _) = 1
treeSize (Node _ left right) = 1 + treeSize left + treeSize right

elemTree :: Ord a => a -> Tree a -> Bool

elemTree _ Null = False
elemTree e (Leaf x) = e == x
elemTree e (Node x left right) | e == x    = True
                               | e < x     = elemTree e left
                               | otherwise = elemTree e right

bt1 = Node 7 (Node 4 (Leaf 2) (Leaf 5)) (Leaf 10)
bt2 = Node 7 (Node 4 (Leaf 2) (Leaf 5))
    (Node 10 (Leaf 9) (Node 13 (Leaf 11) (Leaf 15)))
bt3 = Node 7 (Leaf 4) Null


{- Task 2

With the use of data type 'Tree a' define the following trees:

bt_1   o

       5
bt_2   *

       5  
bt_3   *
      / \ 
    3*   o

       5   
bt_4   *   
      / \  
     o   *7
     
       5
bt_5   *
      / \
    3*   *7
-}

-- solution here

-- Zakładając strukturę: data Tree a = Null | Leaf a | Node a (Tree a) (Tree a)

bt_1 :: Tree Int
bt_1 = Null

bt_2 :: Tree Int
bt_2 = Leaf 5  

bt_3 :: Tree Int
bt_3 = Node 5 (Leaf 3) Null

bt_4 :: Tree Int
bt_4 = Node 5 Null (Leaf 7)

bt_5 :: Tree Int
bt_5 = Node 5 (Leaf 3) (Leaf 7)

{-
ghci> elemTree 3 Null
False
ghci> elemTree 3 (Leaf 3)
True
ghci> elemTree 3 (Leaf 5)
False
ghci> elemTree 3 bt3
False
ghci> elemTree 4 bt3
True
-}

{- Task 3

1. Add value 6 to the drawing of the b1 tree.

2. Add value 8 to the result of the previous task.

       7
bt1   / \
     4   10
    / \
   2   5
-}

{-
       7
      / \
     4   10
    / \  /
   2   5 8
        \
         6
-}

{- Task 4 *

Draw stages of the creation of a tree for the list [1,3,5,7,9]

      5
     / \
 [1,3] [7,9]
-}



-- 5.6.2 *

-- solution here

countLeaves :: Tree a -> Int
countLeaves Null         = 0
countLeaves (Leaf _)     = 1
countLeaves (Node _ l r) = countLeaves l + countLeaves r

{-
ghci> countLeaves Null
0
ghci> countLeaves (Leaf 5)
-}

-- 5.7.1 *

-- solution here

tree2list :: Tree a -> [a]
tree2list Null = []
tree2list (Leaf x) = [x]
tree2list (Node x left right) = tree2list left ++ [x] ++ tree2list right

{-
ghci> tree2list Null
[]
ghci> tree2list (Leaf 5)
[5]
ghci> tree2list bt1
[2,4,5,7,10]
-}

-- 5.7.2 *

list2tree :: Ord a => [a] -> Tree a
list2tree [] = Null
list2tree [x] = Leaf x
list2tree xs = Node root (list2tree leftPart) (list2tree rightPart)
  where n = length xs
        mid = n `div` 2
        leftPart = take mid xs
        (root:rightPart) = drop mid xs


{-
ghci> list2tree []
Null
ghci> list2tree [5]
Leaf 5
ghci> list2tree [1,3,5,7]
Node 5 (Node 3 (Leaf 1) Null) (Leaf 7)
-}

{- Task 5 *

1. Draw the tree that comes as a result of (add 6 bt1).

2. Draw the tree that comes as a result of (list2tree (tree2list (add 6 bt1)).

3. Elaborate on the differences between the two above trees.

1.     7
      / \
     4   10
    / \
   2   5
        \
         6

2.    6
     / \
    4   10
   / \  /
  2   5 7


3. The primary difference between the two trees lies in their structural balance and overall efficiency. 
   The first tree, resulting from a simple insertion, remains rooted at 7 and becomes skewed to the left 
   because the new value 6 is smaller than the root but larger than the intermediate nodes 4 and 5. 
   This results in a taller, unbalanced structure where the path to reach the deepest node is longer, 
   making search operations less efficient. In contrast, the second tree, created by transforming 
   the structure into a list and then back into a tree, undergoes a complete reorganization known as rebalancing.
-}