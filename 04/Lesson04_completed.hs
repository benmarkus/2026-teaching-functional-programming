module GY04 where
import Data.Char
------------------------------------
-- Gyakorlás
------------------------------------

-- Definiáljuk azt a fv.-t ami egy szám abszolút értékét adja vissza
abs' :: Integer -> Integer
abs' x
  | x < 0 = (-1) * x
  | otherwise = x

-- előző órai def
divides :: Integer -> Integer -> Bool
divides x y = y `mod` x == 0

-- Használjuk az abs és divides fv.-ket arra, hogy definiáljuk azt a fv.-t 
-- ami igazat ad vissza, ha az első szám valódi osztója a másodiknak (előző órán csak a pozitívakat adtuk vissza)
isRealDivisorOf :: Integer -> Integer -> Bool
isRealDivisorOf x y = divides (abs' x) (abs' y)

-- Definiáljuk azt a fv.-t ami az előjelét adja vissza egy számnak (matekból ismerős szignum)
signum' :: Integer -> Integer
signum' 0 = 0
signum' x
  | x > 0 = 1
  | otherwise = -1


-- Definiáljuk azt a rekurzív függvényt, ami összeadja n-ig a számokat
sumTo :: Integer -> Integer
sumTo 0 = 0
sumTo x = x + sumTo (x - 1)
{-
 - sumTo
 - 4 + sumTo 3
 - 4 + 3 + sumTo 2 
 - 4 + 3 + 2 + sumTo 1
 - 4 + 3 + 2 + 1 + 0
 - -}
------------------------------------
-- Közös munka
------------------------------------

-- Definiáljunk azt a függvényt, amely a kisbetűt a megfelelő nagybetűre alakítja, és fordítva.
-- használjuk a Data.Char modult, azon belül pedig az isUpper, isLower, toUpper és toLower fv-ket
swapUpperLower :: Char -> Char
swapUpperLower char 
  | isUpper char = toLower char
  | isLower char = toUpper char
  | otherwise = char

-- gömb térfogat 
volumeOfASphere :: Double -> Double
volumeOfASphere r = (4 / 3) * pi * (r ^ 3)

saferFactorial :: Integer -> Integer
saferFactorial 0 = 1
saferFactorial x 
  | x < 0 = 0
  | otherwise = x * saferFactorial (x - 1)

-- Feladat: Számjegyek összege
-- Definiáljuk azt a függvényt, amely egy tetszőleges nemnegatív, 10-es számrendszerben adott
-- számnak megadja a számjegyeinek összegét.
-- Segítség: Használjuk az egészosztás műveleteit (div és mod).
sumOfDigits :: Integer -> Integer
sumOfDigits 0 = 0 
sumOfDigits x = x `mod` 10 + sumOfDigits (x `div` 10)

{- 
 - 12345 div 10 = 1234 
 -
 - -}
-- Feladat: Másodfokú egyenlet gyökeinek száma
-- Definiáld azt a függvényt, amely egy másodfokú egyenlet a, b, és c együtthatóit kapja
-- (ax^2 + bx + c = 0), és megmondja, hogy hány valós gyöke van az egyenletnek.
-- A valós gyökök száma a diszkriminánstól (D = b^2 - 4ac) függ:
--   D > 0: 2 valós gyök
--   D = 0: 1 valós gyök
--   D < 0: 0 valós gyök
numOfRealRoots :: Double -> Double -> Double -> Integer
numOfRealRoots a b c 
  | discriminant > 0 = 2
  | discriminant == 0 = 1 
  | otherwise = 0
  where
    discriminant = b ^ 2 - 4 * a * c

-- A korábbi összegző fv-hez hasonlóan, de most az adott számok négyzetét számoljuk meg
sumSquaresTo :: Integer -> Integer
sumSquaresTo 0 = 0
sumSquaresTo x
  | x < 0 = 0
sumSquaresTo x = x^2 + sumSquaresTo (x - 1)

-- REKURZÍVAN adjuk össze a két szám közötti számokat (beleértve a két számot magát is)
-- az első szám a sor alsó küszöbe, a második a felső
sumBetween :: Integer -> Integer -> Integer
sumBetween x y
  | x == y = x
  | y < x = sumBetween y x
  | otherwise = x + sumBetween (x + 1) y


-- Definiáljuk újra a hatványozást, a viselkedés pontosan megegyezik az általunk ismert szabályokkal
infixr 8 ^|^
(^|^) :: Integer -> Integer -> Integer
(^|^) x 0 = 1
(^|^) x y = x * (x ^|^ (y - 1)) 

------------------------------------
-- Komplex feladat
------------------------------------
-- Az alábbi wikipedia linken megtaláljuk a pí értékére vonatkozó Leibniz formulát
-- https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%8

-- a feladatunk ezt implementálni, a megoldáshoz tetszőleges mennyiségű fv-t készíthettek
leibniz n = 4 * nthLeibniz n

nthLeibniz :: Integer -> Double
nthLeibniz 0 = 1
nthLeibniz n = ((-1) ^ n) / (2 * fromIntegral n + 1) + nthLeibniz (n - 1)
