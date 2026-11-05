module GY08 where
import Data.Char (isLower, toUpper)

----------------------------------
-- Gyakorlás
----------------------------------
-- Rekurzív feladatok listákra

-- Definiáljuk azt a függvényt, amely egy szövegből csak a magánhangzókat tartja meg.
-- Magánhangzónak most az "aeiouAEIOU" karaktereket tekintsük.
-- Segítség: őrfeltételben az elem függvénnyel döntsük el, hogy a karakter magánhangzó-e,
-- ha igen, tegyük az eredmény elejére (:), ha nem, hagyjuk ki.
-- Pl. vowels "Hello World" == "eoo"

allVowels :: String
allVowels = "aeiouAEIOU"

vowels :: String -> String
vowels (c:cs)
  | c `elem` allVowels = c : vowels cs
  | otherwise          = vowels cs
vowels [] = []

-- Definiáljuk azt a függvényt, amely megszámolja, hányszor szerepel egy karakter egy szövegben.
-- Pl. countChar 'l' "Hello World" == 3
countChar :: Char -> String -> Int
countChar _ [] = 0
countChar char (c:cs)
  | char == c = 1 + countChar char cs
  | otherwise = countChar char cs

-- Definiáljuk azt a függvényt, amely egy szövegben az első paraméter minden előfordulását a másodikra cseréli.
-- Pl. replaceChar ' ' '_' "a b c" == "a_b_c"
replaceChar :: Char -> Char -> String -> String
replaceChar target replacer (c:cs)
  | c == target = replacer : replaceChar target replacer cs
  | otherwise   = c : replaceChar target replacer cs
replaceChar _ _ [] = []

-- Definiáljuk azt a függvényt, amely a lista minden elemét megduplázza.
-- Pl. stutter "abc" == "aabbcc"
stutter :: [a] -> [a]
stutter []      = []
stutter (a:as)  = a : a : stutter as

-- Definiáljuk azt a függvényt, amely eldönti, hogy egy logikai értékekből álló lista minden eleme igaz-e (Prelude: and).
-- Gondoljuk meg: mi legyen az üres lista esetén az eredmény?
-- Pl. and' [True,False,True] == False
and' :: [Bool] -> Bool
and' [] = True
and' (b:bs)
  | b         = and' bs
  | otherwise = False

and'' :: [Bool] -> Bool
and'' [] = True
and'' (True:bs) = and'' bs
and'' (b:bs) = False  

-- Definiáljuk azt a függvényt, amely egy szövegben a két egymás melletti, azonos kisbetűt egyetlen nagybetűre cseréli.
-- Az összevont pár után a vizsgálat a következő karaktertől folytatódik, így "aaa"-ból "Aa" lesz.
-- Segítség: egyszerre két karaktert válasszunk le az (x:y:xs) mintával. Gondoljuk meg, melyik esetben mit
-- kell továbbvinni a rekurzióban! Az isLower :: Char -> Bool és toUpper :: Char -> Char függvényeket használhatjuk (Data.Char).
-- Pl. compressLetters "aaa"    == "Aa"
--     compressLetters "aabbcc" == "ABC"
--     compressLetters "Hello"  == "HeLo"
--     compressLetters "AAbb11" == "AAB11"
compressLetters :: String -> String
compressLetters [] = []
compressLetters [x] = [x]
compressLetters (x:y:xs)
  | x == y && isLower x = toUpper x : compressLetters xs
  | otherwise           = x : compressLetters (y:xs)

----------------------------------
-- Pont-pont kifejezések
----------------------------------
{-
  [1..5]        -- [1,2,3,4,5]
  [1,3..10]     -- [1,3,5,7,9]   (az első két elem adja meg a lépésközt, a felső korlátot nem kell elérni)
  [5,4..1]      -- [5,4,3,2,1]   (csökkenő sorozathoz kötelező a lépésköz: [5..1] == [] !)
  ['a'..'e']    -- "abcde"       (karakterekre is működik)
  [1..]         -- végtelen lista, pl. take 3 [1..] == [1,2,3]

Figyelem: negatív számnál a .. és a - közé szóköz kell: [-1, -2 .. -5]
-}

-- Definiáljuk azt a függvényt, amely megadja a páratlan számokat 1-től n-ig.
-- Pl. oddsTo 10 == [1,3,5,7,9]
oddsTo :: Integer -> [Integer]
oddsTo n = [1, 3..n]

-- Definiáljuk azt a függvényt, amely n-től 0-ig visszaszámol.
-- Pl. countdown 5 == [5,4,3,2,1,0]
countdown :: Integer -> [Integer]
countdown n = [n, (n-1)..0] 

-- Definiáljuk azt a függvényt, amely n-től indulva k-sával visszaszámol, amíg a szám pozitív.
-- Pl. countdownBy 3 10 == [10,7,4,1]
countdownBy :: Integer -> Integer -> [Integer]
countdownBy step n = [n, (n - step)..0]

-- Definiáljuk azt a függvényt, amely a -1 és -n közötti egészeket adja meg csökkenő sorrendben.
-- Pl. belowZero 4 == [-1,-2,-3,-4]
belowZero :: Integer -> [Integer]
belowZero n = [-1, (-2)..(-n)]

----------------------------------
-- Listakifejezések (list comprehension)
----------------------------------
{-
A pont-pont kifejezésekkel felsorolásokat tudunk készíteni. Ha az elemeket szűrni is szeretnénk, vagy
számításokat végeznénk velük, a rekurzió helyett listakifejezést is használhatunk.

A matematikai halmazkifejezés:   { n^2 | n ∈ N, n páros }
Haskellben:                      [ n^2 | n <- [1..], even n ]

  n^2          -- kimeneti kifejezés: ebből lesznek az eredmény elemei
  |            -- elválasztja a kimeneti kifejezést a generátoroktól és a feltételektől
  n <- [1..]   -- generátor: sorra az n változóhoz köti a lista elemeit
  even n       -- szűrőfeltétel: Bool típusú kifejezés, csak az ezt teljesítő elemek kerülnek be

Tulajdonságok:
  - Tetszőlegesen sok generátort és szűrőfeltételt adhatunk meg, vesszővel elválasztva.
  - Több szűrőfeltétel esetén mindegyiknek teljesülnie kell (&& kapcsolat). "Vagy" kapcsolathoz használjuk a || -t.
  - A generátor vezeti be a változót, így az csak az utána következő részekben (és a kimeneti kifejezésben) használható.

FONTOS: a sorrend számít! Ez hibát ad, mert az n még nincs bevezetve a feltételnél:
  [ n^2 | even n, n <- [1..] ]   -- error: Variable not in scope: n
-}

-- Definiáljuk azt a függvényt, amely megadja egy pozitív szám osztóit növekvő sorrendben.
-- Segítség: milyen tartományban keressük az osztókat? Melyik feltétel dönti el, hogy i osztója-e n-nek?
-- Pl. divisors 12 == [1,2,3,4,6,12]
-- Gondoljuk meg: mit kellene változtatni, ha csökkenő sorrendben szeretnénk megkapni az osztókat?
divisors :: Integer -> [Integer]
divisors n = [x | x <- [1..n], n `mod` x == 0]

-- Definiáljuk azt a függvényt, amely megadja a kettő hatványait 0-tól n kitevőig. Feltehetjük, hogy n nemnegatív.
-- Pl. powersOf2 4 == [1,2,4,8,16]
powersOf2 :: Int -> [Integer]
powersOf2 n = [2 ^ exponent | exponent <- [0..n]] 

-- Definiáljuk azt a függvényt, amely egy n hosszú, False és True értékeket felváltva tartalmazó listát ad meg.
-- Ne használjunk esetszétválasztást!
-- Pl. oddEven 3 == [False,True,False]
oddEven :: Int -> [Bool]
oddEven n = [even x | x <- [1..n]]

-- Definiáljuk listakifejezéssel azt a függvényt, amely egy elemet n-szer ismétel (Prelude: replicate).
-- Segítség: a generátor változójára nem feltétlenül van szükségünk, ilyenkor használhatjuk a _ mintát.
-- Pl. myReplicate 3 'x' == "xxx"
myReplicate :: Int -> a -> [a]
myReplicate count elem = [elem | _ <- [1..count]]

-- Definiáljuk azt a függvényt, amely megadja a legkisebb olyan 2 hatványt, amely nagyobb, mint n.
-- Ne adjunk felső korlátot a keresési tartománynak!
-- Segítség: állítsuk elő az összes 2 hatványt növekvő sorrendben, szűrjük, és vegyük a lista első elemét (head).
-- A lusta kiértékelés miatt a lista csak addig értékelődik ki, amíg a head-nek szüksége van rá.
-- Pl. powerOfTwo 200 == 256
powersOf2Infinite :: [Integer]
powersOf2Infinite = [2 ^ exponent | exponent <- [0..]] 

powerOfTwo :: Integer -> Integer
powerOfTwo limit = head [power | power <- powersOf2Infinite, power > limit]

-- Definiáljuk azt a függvényt, amely eldönti egy pozitív egészről, hogy prím-e.
-- Segítség: használjuk a divisors és a length függvényt.
isPrime :: Integer -> Bool
isPrime = undefined

-- Definiáljuk azt a függvényt, amely megadja a prímszámokat n-ig.
-- Pl. primesToN 10 == [2,3,5,7]
primesToN :: Integer -> [Integer]
primesToN = undefined

----------------------------------
-- Több generátor, függő generátorok
----------------------------------
{-
Több generátor olyan, mint az egymásba ágyazott ciklusok: amíg az első generátor egyet lép,
addig a második végigmegy a teljes listáján (Descartes-szorzat).
  [ (c, n) | c <- "abc", n <- [1,2] ]   -- [('a',1),('a',2),('b',1),('b',2),('c',1),('c',2)]

Egy későbbi generátor tartománya függhet egy korábban bevezetett változótól:
  [ (x, y) | x <- [1..3], y <- [x..3] ]  -- [(1,1),(1,2),(1,3),(2,2),(2,3),(3,3)]
-}

-- Definiáljuk azt a konstanst, amely növekvő sorrendben tartalmazza az összes (óra, perc) párt egy napon belül.
-- Pl. take 3 time == [(0,0),(0,1),(0,2)]
time :: [(Int, Int)]
time = undefined

-- Definiáljuk azt a függvényt, amely előállítja az összes dominót, amelyek két fele 0 és n közötti pontot tartalmaz.
-- Ne legyenek ismétlődések: az (1,0) ugyanaz a dominó, mint a (0,1), ezért csak az utóbbi szerepeljen.
-- Először szűrőfeltétellel oldjuk meg, utána függő generátorral is!
-- Pl. dominoes 2 == [(0,0),(0,1),(0,2),(1,1),(1,2),(2,2)]
dominoes :: Integer -> [(Integer, Integer)]
dominoes = undefined

-- Definiáljuk azt a függvényt, amely 1-től n-ig egy olyan monoton növekvő listát ad, amelyben minden i szám i-szer szerepel.
-- Pl. monotonousSeq 3 == [1,2,2,3,3,3]
monotonousSeq :: Int -> [Int]
monotonousSeq = undefined

----------------------------------
-- "Párhuzamos" bejárás: zip
----------------------------------
{-
Két generátor nem párhuzamosan, hanem egymásba ágyazva járja be a listákat. Ha két listát párhuzamosan szeretnénk
bejárni, akkor a zip függvénnyel párosítsuk az elemeiket, és a generátorban a párokra mintaillesszünk:
  [ x + y | (x, y) <- zip [1,2,3] [10,20,30] ]   -- [11,22,33]
-}

-- Definiáljuk azt a függvényt, amely egy szöveg karaktereit 1-től kezdve megsorszámozza.
-- Pl. indexString "abc" == [(1,'a'),(2,'b'),(3,'c')]
indexString :: String -> [(Integer, Char)]
indexString = undefined

----------------------------------
-- concat, words, unwords
----------------------------------
{-
  concat  :: [[a]] -> [a]        -- listák listáját egy szinttel "kilapítja": concat [[1,2],[],[3]] == [1,2,3]
  words   :: String -> [String]  -- whitespace-ek mentén szavakra bont: words "  a  b c" == ["a","b","c"]
  unwords :: [String] -> String  -- szóközzel elválasztva összefűz: unwords ["a","b"] == "a b"
-}

-- Definiáljuk a concat függvényt listakifejezéssel.
-- Segítség: két generátorra lesz szükség, a második az első által kivett listát járja be.
concatLC :: [[a]] -> [a]
concatLC = undefined

-- Definiáljuk azt a függvényt, amely 1-től felmegy n-ig, majd onnan visszacsökken 2-ig.
-- Pl. mountain 3 == [1,2,3,2]
--     mountain 1 == [1]
mountain :: Integer -> [Integer]
mountain = undefined

-- Definiáljuk azt a függvényt, amely egy hegyláncot készít: egymás után az 1, 2, ..., n magasságú hegyek.
-- Pl. mountains 3 == [1,1,2,1,2,3,2]
mountains :: Integer -> [Integer]
mountains = undefined

-- Definiáljuk azt a végtelen szöveget, amelyben szóközzel elválasztva egyre több csillag szerepel: "* ** *** **** ..."
-- Segítség: hogyan kapunk egy i darab csillagból álló szöveget? Ne feledjük: String = [Char].
-- Pl. take 10 asteriskSeq == "* ** *** *"
asteriskSeq :: String
asteriskSeq = undefined

----------------------------------
-- Mintaillesztés listakifejezésben
----------------------------------
{-
A generátor bal oldalán minta is állhat. Ami nem illeszkedik a mintára, azt a listakifejezés egyszerűen kihagyja:
  [ c | (c, 1) <- [('a',2), ('d',1), ('e',1)] ]   -- "de"

Néha csak mintaillesztéssel tudunk vizsgálni, mert az egyenlőségvizsgálathoz Eq megszorítás kellene:
  numOfEmpties :: [[a]] -> Int
  numOfEmpties lls = length [ 1 | [] <- lls ]

Érdekesség: generátor nélkül, csak szűrőfeltétellel is írhatunk listakifejezést. Ez egyszerű hibakezelésre jó,
a 0-val osztás üres listát ad hibaüzenet helyett:
  safeDiv :: Integer -> Integer -> [Integer]
  safeDiv n m = [ n `div` m | m /= 0 ]
-}

-- Definiáljuk azt a függvényt, amely megszámolja az 'a' betűket egy szövegben. Az 'a' értékre mintaillesszünk!
-- Pl. numOfAs "almafa" == 3
numOfAs :: String -> Int
numOfAs = undefined

-- Definiáljuk azt a függvényt, amely megadja az "az" névelők számát egy szövegben.
-- Segítség: ne karakterenként dolgozzunk, hanem bontsuk szavakra a szöveget (words).
-- Pl. countOfAs "az alma az asztalon van" == 2
countOfAs :: String -> Int
countOfAs = undefined

{-
A prímvizsgálat javítása:
  Az isPrime 25765442 (egy nagy páros szám) több másodpercig is futhat, mert a length-nek szüksége van
  az összes osztóra. Pedig már a 2-es osztó megtalálásakor tudhatnánk, hogy nem prím.

  A listák egyenlőségvizsgálata elemenként halad, és az első eltérésnél megáll. Mivel a divisors lustán
  állítja elő az osztókat, ez a változat a második (1-nél nagyobb, n-nél kisebb) osztónál leáll:
    isPrime n = divisors n == [1, n]
-}

----------------------------------
-- További gyakorló feladatok
----------------------------------

-- Definiáljuk listakifejezéssel azt a függvényt, amely egy szövegből csak a magánhangzókat ("aeiouAEIOU") tartja meg.
-- Pl. vowelsLC "Hello World" == "eoo"
vowelsLC :: String -> String
vowelsLC = undefined

-- Definiáljuk listakifejezéssel a lista hosszát megadó függvényt (Prelude: length).
-- Segítség: minden elem helyett tegyünk egy 1-est a listába, és adjuk össze őket (sum).
lengthLC :: [a] -> Int
lengthLC = undefined

-- Definiáljuk azt a függvényt, amely két vektor skaláris szorzatát adja meg:
-- az azonos pozíción lévő elemek szorzatainak összege.
-- Pl. dotProduct [1,2,3] [4,5,6] == 32
dotProduct :: [Integer] -> [Integer] -> Integer
dotProduct = undefined

-- Definiáljuk listakifejezéssel azt a függvényt, amely egy elem összes előfordulásának indexét megadja (0-tól indexelve).
-- Pl. elemIdsLC 'a' "banana" == [1,3,5]
elemIdsLC :: Eq a => a -> [a] -> [Int]
elemIdsLC = undefined

-- Definiáljuk azt a függvényt, amely egy szöveg szavainak kezdőbetűit adja meg.
-- Pl. initials "Haskell Brooks Curry" == "HBC"
initials :: String -> String
initials = undefined

-- Definiáljuk a tökéletes számok végtelen listáját. Egy szám tökéletes, ha megegyezik a nála kisebb osztóinak összegével.
-- Segítség: használjuk a divisors függvényt.
-- Pl. take 3 perfects == [6,28,496]
perfects :: [Integer]
perfects = undefined
