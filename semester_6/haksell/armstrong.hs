import Text.Read (readMaybe)
import System.IO (hFlush, stdout)

isArmstrong :: Int -> Bool
isArmstrong n = n == sum [d^len | d <- digits]
  where
    s = show n
    len = length s
    digits = map (\c -> read [c] :: Int) s


getValidN :: IO Int
getValidN = do
    putStr "n = "
    hFlush stdout
    input <- getLine
    case readMaybe input of
        Just n | n > 100 -> return n
        _                -> getValidN

main :: IO ()
main = do
    n <- getValidN
    let armstrongNumbers = filter isArmstrong [100..n]
    putStrLn $ "\nliczby: " ++ unwords (map show armstrongNumbers)