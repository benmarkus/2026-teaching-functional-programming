module GY06 where
import Data.Char (isUpper)

----------------------------------
-- Gyakorlás
----------------------------------
-- Az előző órán el nem készült feladatok

-- Definiáljuk azt a függvényt, amely egy szövegből csak a nagybetűket tartja meg ("Hello World" -> "HW").
-- Segítség: az isUpper :: Char -> Bool függvényt használhatjuk (Data.Char)
onlyUppers :: String -> String
onlyUppers = undefined

-- Definiáljuk azt a függvényt, amely egy lista első n elemét eldobja (Prelude: drop).
-- Ne ellenőrizzük a lista hosszát, a minták majd kiderítik, ha elfogytak az elemek!
drop' :: Int -> [a] -> [a]
drop' = undefined

-- Definiáljuk a lista összefűzését (Prelude: (++)).
-- Segítség: az első listát bontjuk fel elemenként, a második listát nem kell vizsgálnunk.
infixr 5 +++
(+++) :: [a] -> [a] -> [a]
(+++) = undefined

-- Definiáljuk a rendezett pár második komponensét visszaadó függvényt (Prelude: snd)
second :: (a, b) -> b
second = undefined

-- Definiáljuk azt a függvényt, amely felcseréli a rendezett pár két komponensét.
swap :: (a, b) -> (b, a)
swap = undefined

-- Definiáljuk azt a függvényt, amely az első pontra tükrözi a második pontot.
mirrorP :: (Integer, Integer) -> (Integer, Integer) -> (Integer, Integer)
mirrorP = undefined

-- Definiáljuk azt a függvényt, amely két listából párok listáját készít (Prelude: zip).
-- Ha az egyik lista rövidebb, akkor a hosszabb felesleges elemeit eldobjuk.
-- zip' [1,2,3] "ab" == [(1,'a'),(2,'b')]
zip' :: [a] -> [b] -> [(a, b)]
zip' = undefined

-- Definiáljuk a zip' fordítottját, amely egy párokból álló listát két listává bont szét (Prelude: unzip).
-- unzip' [(1,'a'),(2,'b')] == ([1,2],"ab")
-- Segítség: a rekurzív hívás eredményét is mintaillesztéssel bonthatjuk fel, pl. let (as, bs) = unzip' xs in ...
unzip' :: [(a, b)] -> ([a], [b])
unzip' = undefined

----------------------------------
-- Listák (folytatás)
----------------------------------

-- Definiáljuk azt a függvényt, amely eldönti egy listáról, hogy szigorúan monoton növekvő-e.
-- Segítség: egyszerre két elemet is leválaszthatunk, de gondoljuk meg, melyiket kell továbbvinni a rekurzióban.
isAscending :: Ord a => [a] -> Bool
isAscending = undefined

----------------------------------
-- Feladatok listákra
----------------------------------

-- Definiáljuk mintaillesztéssel azt a függvényt, amely
--   - egy két elemből álló lista elemeit megcseréli,
--   - egy három elemből álló lista elemeit a következő sorrendbe teszi: második, harmadik, első,
--   - minden egyéb lista esetén az eredmény az üres lista.
-- Segítség: mintaillesztéssel egyszerre több elemet is leválaszthatunk a lista elejéről.
simpleShift :: [a] -> [a]
simpleShift = undefined

-- Definiáljuk mintaillesztéssel azt a függvényt, amely
--   - egy egyelemű lista elemét négyzetre emeli,
--   - egy kételemű lista első elemét a második elem hatványára emeli (feltehetjük, hogy a kitevő nemnegatív),
--   - minden egyéb lista esetén 0-t ad.
squarePow :: [Integer] -> Integer
squarePow = undefined

-- Definiáljuk azt a függvényt, amely egy lista páros számait megnöveli 1-gyel, a páratlanokat változatlanul hagyja.
incEvens :: [Integer] -> [Integer]
incEvens = undefined

-- Definiáljuk azt a függvényt, amely egy számlistából megadja a páros számok összegét.
sumEvens :: [Integer] -> Integer
sumEvens = undefined

-- Definiáljuk azt a függvényt, amely két listán elemenként haladva megadja,
-- hogy hány azonos pozíción lévő elem egyenlő. Feltehetjük, hogy a két lista egyforma hosszú.
numOfEq :: [Integer] -> [Integer] -> Int
numOfEq = undefined

-- Definiáljuk azt a függvényt, amely az első lista elemeit párhuzamosan a második lista elemeinek megfelelő
-- kitevőre emeli. Ha a kitevő negatív, akkor a hatvány helyett 1 kerüljön az eredménybe.
-- Ha valamelyik lista elfogy, ne képezzen több hatványt.
listPow :: [Integer] -> [Integer] -> [Integer]
listPow = undefined

-- Definiáljuk azt a függvényt, amely egy lista szomszédos elemeinek hatványát képezi: az első elemet
-- a második, a másodikat a harmadik szerinti kitevőre emeli, és így tovább.
-- Ha a kitevő negatív, akkor az alapszám maradjon változatlan.
-- Legalább kételemű listára van értelme a hatványozásnak, egyébként az eredmény az üres lista.
-- Segítség: gondoljuk meg, melyik elemre lesz szükség a következő lépésben is, azt vigyük tovább a rekurzióban.
powNeighbours :: [Integer] -> [Integer]
powNeighbours = undefined

-- Definiáljuk azt a függvényt, amely megadja, hogy hány közvetlen szomszédos elempár egyenlő egymással.
-- Segítség: itt is gondoljuk meg, melyik elemet kell továbbvinni a rekurzióban.
numOfSameNeighbours :: [Integer] -> Integer
numOfSameNeighbours = undefined

-- Definiáljuk azt a függvényt, amely egy lista i. indexű elemét adja meg (Prelude: (!!)). Az indexelés 0-tól indul.
-- Elég, ha nemnegatív indexre és elég hosszú listára működik.
-- Figyelem: egy-egy elem kikereséséhez jó, de ne használjuk indexeléssel a lista minden elemének feldolgozására!
infixl 9 !:!
(!:!) :: [a] -> Int -> a
(!:!) = undefined

-- Definiáljuk azt a függvényt, amely eldönti egy listáról, hogy adott elemszámnál több elemet tartalmaz-e.
-- Használjunk mintaillesztést és rekurziót, de ne használjuk a length függvényt (így végtelen listára is működik).
isLongerThan :: [a] -> Integer -> Bool
isLongerThan = undefined

-- Definiáljuk azt a függvényt, amely eldönti egy elemről, hogy megtalálható-e a listában (Prelude: elem).
-- Az Eq a megszorítás azt jelenti, hogy az elemek egyenlőségét vizsgálhatjuk (==).
elem' :: Eq a => a -> [a] -> Bool
elem' = undefined

-- Definiáljuk azt a függvényt, amely elhagyja a lista utolsó elemét (Prelude: init).
-- Valójában nem elhagyjuk, hanem egy új listát építünk az eredeti elemeiből.
init' :: [a] -> [a]
init' = undefined

-- Definiáljuk azt a függvényt, amely egy elemet végtelen sokszor ismétel meg (Prelude: repeat).
-- Figyelem: végtelen listát építünk, ezért ennek a függvénynek nincs alapesete!
-- Próbáljuk ki: take 5 (repeat' 'a')
repeat' :: a -> [a]
repeat' = undefined

-- Definiáljuk azt a függvényt, amely egy lista elemeit felváltva veszi két listából.
-- Ha valamelyik lista hamarabb elfogy, a másik maradékát változatlanul fűzzük az eredmény végére.
-- Segítség: mindkét listát mintaillesztenünk kell, ne feledkezzünk meg az egyik lista elfogyásáról.
-- Pl. interleave [1,2,3] [4,5,6] == [1,4,2,5,3,6]
interleave :: [a] -> [a] -> [a]
interleave = undefined

-- Definiáljuk azt a függvényt, amely egy listák listáját egyetlen listává fűz össze (Prelude: concat).
-- Segítség: a megszokott (x:xs) mintát és az (++) műveletet használjuk.
concat' :: [[a]] -> [a]
concat' = undefined

-- Definiáljuk azt a függvényt, amely eldönti, hogy az első lista kezdőszelete-e a másodiknak (Data.List: isPrefixOf).
-- Segítség: mindkét listáról egyszerre vegyünk le egy-egy elemet, és hasonlítsuk össze őket.
isPrefixOf' :: Eq a => [a] -> [a] -> Bool
isPrefixOf' = undefined

-- Definiáljuk azt a függvényt, amely elhagyja az ismétlődéseket a listából úgy, hogy minden elem UTOLSÓ előfordulását
-- tartja meg. Használjuk az elem' függvényt!
-- Segítség: ha az elem a maradékban még megtalálható, akkor ezt a példányt eldobhatjuk, mert még lesz belőle.
-- Pl. removeDups [1,3,1,2,3] == [1,2,3]
removeDups :: Eq a => [a] -> [a]
removeDups = undefined

-- Definiáljuk azt a függvényt, amely megadja egy lista összes szuffixumát (Data.List: tails).
-- Pl. suffixes [1,2,3] == [[1,2,3],[2,3],[3],[]]
suffixes :: [a] -> [[a]]
suffixes = undefined

-- Definiáljuk azt a függvényt, amely egy elem összes előfordulásának indexét megadja egy listában (0-tól indexelve).
-- Segítség: használjunk segédfüggvényt, amely a bejárás közben számon tartja az aktuális elem indexét.
-- Pl. elemIds 'a' "banana" == [1,3,5]
elemIds :: Eq a => a -> [a] -> [Int]
elemIds = undefined

-- Definiáljuk azt a függvényt, amely egy elemet beszúr egy rendezett listába úgy, hogy az rendezett maradjon.
ordInsert :: Ord a => a -> [a] -> [a]
ordInsert = undefined

----------------------------------
-- Pont-pont kifejezések (range)
----------------------------------
{-
Számsorozatokat, karaktersorozatokat nem kell kézzel felsorolnunk, használhatjuk a pont-pont kifejezést:
  [1..10]        -- [1,2,3,4,5,6,7,8,9,10]
  [1,3..10]      -- [1,3,5,7,9]  (az első két elem megadja a lépésközt)
  [10,8..1]      -- [10,8,6,4,2]  (csökkenő sorozathoz meg kell adni a lépésközt!)
  ['a'..'z']     -- "abcdefghijklmnopqrstuvwxyz"
  [1..]          -- végtelen lista! (GHCi-ben a Ctrl + C megszakítja)

A végtelen lista nem probléma, mert Haskellben lusta kiértékelés van: csak annyit számol ki, amennyire
szükség van. Így például take 5 [1..] == [1,2,3,4,5].

Figyelem: negatív szám esetén a .. és a - közé szóköz kell: [10, 9 .. -10]
-}

-- Definiáljuk azt a függvényt, amely az n és -n közötti egész számokat csökkenő sorrendben adja meg.
-- descending 3 == [3,2,1,0,-1,-2,-3]
descending :: Integer -> [Integer]
descending = undefined

-- Definiáljuk azt a függvényt, amely az angol ábécé n-edik betűjét adja meg (0-tól indexelve).
-- Ha a Bool paraméter True, nagybetűt, különben kisbetűt adjon.
-- A 0-25 tartományon kívül nem kell működnie (hibával is elszállhat).
nthLetter :: Int -> Bool -> Char
nthLetter = undefined

-- Definiáljuk azt a függvényt, amely az n-nel osztható nemnegatív számok végtelen, növekvő sorozatát adja meg.
-- Ha n nem pozitív, az eredmény legyen az üres lista.
-- Próbáljuk ki: take 5 (divByN 3)
divByN :: Integer -> [Integer]
divByN = undefined

-- Definiáljuk azt a függvényt, amely a számtani sorozat i. elemét adja meg (0-tól indexelve).
-- Az első két paraméter a sorozat első két eleme, a harmadik az index. Használjunk pont-pont kifejezést.
-- Gyakorlásként oldjuk meg rekurzívan is, segédfüggvénnyel.
ithInSeq :: Integer -> Integer -> Int -> Integer
ithInSeq = undefined

-- Definiáljuk a faktoriális függvényt pont-pont kifejezés és a product' függvény felhasználásával.
fact :: Integer -> Integer
fact = undefined

-- Definiáljuk azt a függvényt, amely megadja, hogy n különböző elemet hányféleképpen lehet sorba rendezni.
-- Feltehetjük, hogy n pozitív.
perm :: Integer -> Integer
perm = undefined

-- Definiáljuk azt a függvényt, amely megadja, hogy n különböző elemből hányféleképpen választhatunk ki m elemet.
-- Segítség: használjuk a fact függvényt, és vigyázzunk a kötési erősségekre. Egész számokkal dolgozunk,
-- tehát egészosztást (div) kell használnunk.
comb :: Integer -> Integer -> Integer
comb = undefined

-- A pont-pont kifejezések szintaktikai cukorkák, valójában négy függvényt rejtenek:
--   enumFrom, enumFromThen, enumFromTo, enumFromThenTo
-- Definiáljuk ezeket rekurzívan, Integer-ekre specializálva!
-- (Ne használjunk pont-pont kifejezést a megoldásban.)

-- m-től n-ig, +1 lépésközzel
enumFromTo' :: Integer -> Integer -> [Integer]
enumFromTo' = undefined

-- m-től végtelenig, +1 lépésközzel
enumFrom' :: Integer -> [Integer]
enumFrom' = undefined

-- m-től végtelenig, a lépésközt az első két elem határozza meg
enumFromThen' :: Integer -> Integer -> [Integer]
enumFromThen' = undefined

-- m-től n-ig, a lépésközt az első két elem határozza meg (csökkenő sorozat is lehet)
-- Pl. enumFromThenTo' 7 5 0 == [7,5,3,1]
enumFromThenTo' :: Integer -> Integer -> Integer -> [Integer]
enumFromThenTo' = undefined
