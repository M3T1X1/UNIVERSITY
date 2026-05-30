module Tree where

data Tree a = Null
            | Leaf a
            | Node a (Tree a) (Tree a)

tree2list :: Tree a -> [a]
tree2list Null = []
tree2list (Leaf x) = [x]
tree2list (Node x left right) = tree2list left ++ [x] ++ tree2list right

list2tree :: Ord a => [a] -> Tree a
list2tree [] = Null
list2tree [x] = Leaf x

elemTree :: Ord a => a -> Tree a -> Bool
elemTree _ Null = False
elemTree e (Leaf x) = e == x
elemTree e (Node x left right) | e == x = True
                               | e < x = elemTree e left
                               | e > x = elemTree e right

treeSize :: Tree a -> Int
treeSize Null = 0
treeSize (Leaf _) = 1
treeSize (Node _ left right) = 1 + treeSize left + treeSize right

countLeaves :: Tree a -> Int
countLeaves Null = 0
countLeaves (Leaf _) = 1
countLeaves (Node _ left right) = countLeaves left + countLeaves right

