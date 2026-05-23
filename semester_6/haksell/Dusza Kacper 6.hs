-- Homework 6

-- 6.1 - 6.6

-- lab6 - Task 1 - Task 8

-- task 4
{-
m a      :: IO Int
a -> m b :: Int -> IO ()
m b      :: IO ()

where:

m :: IO
a :: Int
b :: ()
-}
-- Task 5
{-
m a      :: IO String
a -> m b :: String -> IO ()
m b      :: IO ()

where:

m :: IO
a :: String
b :: ()
-}

-- 6.4
module Main where 
import System.Environment
import Data.Char

merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) | x <= y    = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys

mergeSort :: Ord a => [a] -> [a]
mergeSort xs | len <= 1  = xs
             | otherwise = merge (mergeSort ys) (mergeSort zs)
  where len  = length xs
        half = len `div` 2
        ys   = take half xs
        zs   = drop half xs

main :: IO ()
main = do
     [inFile, outFile] <- getArgs

     inputString <- readFile inFile

     let sortedContent = unlines (mergeSort (lines inputString))

     writeFile outFile sortedContent
{-
debian@debian:~/Pulpit/UNIVERSITY/semester_6/haksell$ ghc -o test "Dusza Kacper 6.hs"
[1 of 2] Compiling Main             ( Dusza Kacper 6.hs, Dusza Kacper 6.o )
[2 of 2] Linking test
debian@debian:~/Pulpit/UNIVERSITY/semester_6/haksell$ ./test plik1.txt plik2.txt
debian@debian:~/Pulpit/UNIVERSITY/semester_6/haksell$ cat plik1.txt 
Kacper
Robert
Adam
debian@debian:~/Pulpit/UNIVERSITY/semester_6/haksell$ cat plik2.txt 
Adam
Kacper
Robert
-}

-- 6.5
main2 = do
     [searchWord, fileName] <- getArgs

     content <- readFile fileName

     let numberedLines = zip [1..] (lines content)

     let result = [n | (n, line) <- numberedLines, searchWord `elem` words line]

     print result
{-
debian@debian:~/Pulpit/UNIVERSITY/semester_6/haksell$ ghci "Dusza Kacper 6.hs" 
GHCi, version 9.6.7: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( Dusza Kacper 6.hs, interpreted )
Ok, one module loaded.
ghci> :set
:set   :seti
ghci> :set args linia plik1.txt
ghci> main2
[1,2]
ghci> 
-}

-- 6.6.2

decemberCount :: [[Char]] -> Int
decemberCount pesels = length [p | p <- pesels, p !! 2 == '1' && p !! 3 == '2']

main4 :: IO ()
main4 = do
    content <- readFile "pesel.txt"

    let peselList = lines content

    let result = decemberCount peselList

    putStrLn ("Liczba osob urodzonych w grudniu: " ++ show result)
{-
ghci> main4
Liczba osob urodzonych w grudniu: 20
ghci> 
-}

-- Task 8

{-
ghci> ['c']
"c"
ghci> head "c"
'c'
-}
