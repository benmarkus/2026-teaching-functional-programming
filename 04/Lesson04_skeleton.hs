module GY04 where
------------------------------------
-- Gyakorlás
------------------------------------

-- Definiáljuk azt a fv.-t ami egy szám abszolút értékét adja vissza
abs' :: Integer -> Integer
abs' = undefined

-- előző órai def
divides :: Integer -> Integer -> Bool
divides x y = y `mod` x == 0

-- Használjuk az abs és divides fv.-ket arra, hogy definiáljuk azt a fv.-t 
-- ami igazat ad vissza, ha az első szám valódi osztója a másodiknak (előző órán csak a pozitívakat adtuk vissza)
isRealDivisorOf :: Integer -> Integer -> Bool
isRealDivisorOf = undefined

-- Definiáljuk azt a fv.-t ami az előjelét adja vissza egy számnak (matekból ismerős szignum)
signum' :: Integer -> Integer
signum' = undefined

-- Definiáljuk azt a rekurzív függvényt, ami összeadja n-ig a számokat
sumTo :: Integer -> Integer
sumTo = undefined

------------------------------------
-- Közös munka
------------------------------------

-- Definiáljunk azt a függvényt, amely a kisbetűt a megfelelő nagybetűre alakítja, és fordítva.
-- használjuk a Data.Char modult, azon belül pedig az isUpper, isLower, toUpper és toLower fv-ket
swapUpperLower = undefined

-- gömb térfogat 
volumeOfASphere :: Double -> Double
volumeOfASphere = undefined

saferFactorial :: Integer -> Integer
saferFactorial = undefined

-- Feladat: Számjegyek összege
-- Definiáljuk azt a függvényt, amely egy tetszőleges nemnegatív, 10-es számrendszerben adott
-- számnak megadja a számjegyeinek összegét.
-- Segítség: Használjuk az egészosztás műveleteit (div és mod).
sumOfDigits :: Integer -> Integer
sumOfDigits = undefined

-- Feladat: Másodfokú egyenlet gyökeinek száma
-- Definiáld azt a függvényt, amely egy másodfokú egyenlet a, b, és c együtthatóit kapja
-- (ax^2 + bx + c = 0), és megmondja, hogy hány valós gyöke van az egyenletnek.
-- A valós gyökök száma a diszkriminánstól (D = b^2 - 4ac) függ:
--   D > 0: 2 valós gyök
--   D = 0: 1 valós gyök
--   D < 0: 0 valós gyök
numOfRealRoots :: Double -> Double -> Double -> Integer
numOfRealRoots = undefined

-- A korábbi összegző fv-hez hasonlóan, de most az adott számok négyzetét számoljuk meg
sumSquaresTo :: Integer -> Integer
sumSquaresTo = undefined

-- REKURZÍVAN adjuk össze a két szám közötti számokat (beleértve a két számot magát is)
-- az első szám a sor alsó küszöbe, a második a felső
sumBetween :: Integer -> Integer -> Integer
sumBetween = undefined

-- Definiáljuk újra a hatványozást, a viselkedés pontosan megegyezik az általunk ismert szabályokkal
infixr 8 ^|^
(^|^) :: Integer -> Integer -> Integer
(^|^) = undefined 

------------------------------------
-- Komplex feladat
------------------------------------
-- Az alábbi wikipedia linken megtaláljuk a pí értékére vonatkozó Leibniz formulát
-- https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%8

-- a feladatunk ezt implementálni, a megoldáshoz tetszőleges mennyiségű fv-t készíthettek
leibniz = undefined

nthLeibniz = undefined
