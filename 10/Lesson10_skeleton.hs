module GY10 where
import Data.Char (isDigit, digitToInt, isUpper)

----------------------------------
-- Gyakorló feladatok
----------------------------------
{-
Az alábbi függvények bizonyos paraméterekre nem tudnak értelmes eredményt adni (pl. mi az üres lista első eleme?).
Ezeket az eseteket most egyszerűen hagyjuk ki a definícióból
-}

-- Definiáljuk azt a függvényt, amely egy lista első elemét adja meg (Prelude: head).
-- Pl. myHead [1,2,3] == 1
--     myHead "alma" == 'a'
myHead :: [a] -> a
myHead = undefined

-- Definiáljuk azt a függvényt, amely egy lista utolsó elemét adja meg (Prelude: last).
-- Pl. myLast [1,2,3] == 3
--     myLast "alma" == 'a'
myLast :: [a] -> a
myLast = undefined

-- Definiáljuk azt a függvényt, amely egy lista legnagyobb elemét adja meg rekurzívan (Prelude: maximum).
-- Pl. myMaximum [3,1,4,1,5] == 5
--     myMaximum "alma" == 'm'
myMaximum :: Ord a => [a] -> a
myMaximum = undefined

-- Definiáljuk azt a függvényt, amely egy listában megadja egy elem első előfordulásának indexét. Az indexelés 0-tól indul.
-- Pl. myElemIndex 1 [1,2,3] == 0
--     myElemIndex 'l' "alma" == 1
--     myElemIndex 5 [1,2,3,4,5,5] == 4
myElemIndex :: Eq a => a -> [a] -> Int
myElemIndex = undefined

-- Kulcs-érték párokból álló listákban gyakran keresünk egy kulcshoz tartozó értéket.
phoneBook :: [(String, String)]
phoneBook = [("Anna", "06-30-123-4567"), ("Bela", "06-20-987-6543"), ("Cecil", "06-70-555-1234")]

-- Definiáljuk azt a függvényt, amely megadja egy kulcshoz tartozó első értéket.
-- Pl. myLookup "Bela" phoneBook == "06-20-987-6543"
--     myLookup 2 [(1,'a'), (2,'b'), (2,'c')] == 'b'
myLookup :: Eq k => k -> [(k, v)] -> v
myLookup = undefined

-- Definiáljuk azt a függvényt, amely egy lista elemeinek átlagát adja meg egész osztással.
-- Pl. myAverage [1,2,3,4] == 2
--     myAverage [10] == 10
myAverage :: [Int] -> Int
myAverage = undefined

{-
Próbáljuk ki GHCi-ben:
  myHead []
  myMaximum ""
  myElemIndex 'x' "alma"
  myLookup "Dora" phoneBook
  myAverage []

Mindegyik futásidejű hibával elszáll: ezek parciális függvények, nem minden paraméterre adnak eredményt.
A típusukból (pl. myHead :: [a] -> a) ez nem derül ki, a hívónak magának kell vigyáznia.
Ugyanilyenek a Prelude-ben is vannak: div, mod, head, tail, (!!), ...
  div 5 0      -- *** Exception: divide by zero
  head []      -- *** Exception: Prelude.head: empty list
Az óra során ezeket a függvényeket totálissá tesszük, és a hiba lehetőségét a típusban is jelezzük.
-}

----------------------------------
-- Paraméteres típusok
----------------------------------
{-
Az előző órán saját típusokat definiáltunk, de a konstruktorok mezőinek mindig konkrét típust adtunk meg
(Int, Double, Point, ...). Ez erősen beszűkíti a felhasználhatóságot. Ahogy a függvényeknél is tettük,
a típusoknál is segíthet a paraméterezés (polimorfizmus).

Motivációs példa:
A gyakorló feladatok függvényei bizonyos paraméterekre nem tudnak eredményt adni.

Jó lenne, ha a hibás esetet egy "speciális értékkel" ki tudnánk fejezni. Ehhez egy új típust "húzunk" az Int fölé:

  data MaybeInt = NotInt | JustInt Int deriving (Show)

  safeIntDiv :: Int -> Int -> MaybeInt
  safeIntDiv n 0 = NotInt
  safeIntDiv n m = JustInt (n `div` m)

A NotInt a "hiányzó" értéket fejezi ki, a JustInt pedig az eddig is kifejezhető értékeket csomagolja be.
Ezzel a parciális div függvényből totális függvényt készítettünk: minden bemenetre ad eredményt.

Ha ugyanezt Integer-re is szeretnénk, egy szinte teljesen azonos típust kellene definiálnunk:

  data MaybeInteger = NotInteger | JustInteger Integer deriving (Show)

A két definíció csak a nevekben és a mező típusában különbözik. Ehelyett paraméterezzük a típust!

  data Maybe a = Nothing | Just a

Itt a Maybe egy típuskonstruktor: kap egy konkrét típust (a), és abból készít egy újat.
A Maybe Int, Maybe Char, Maybe [Bool] mind különböző konkrét típusok.
A Maybe típus már létezik a Prelude-ben, ezért nem definiáljuk újra, hanem a meglévőt használjuk.

Ilyen paraméteres típust már eddig is használtunk: a lista is az!
  head :: [a] -> a       ugyanaz, mint    head :: [] a -> a
  (:)  :: a -> [a] -> [a]

Próbáljuk ki GHCi-ben:
  :t Just 'a'
  :t Just True
  :t Just [1,2,3]
  :t Nothing          -- nincs információ a típusparaméterről, ezért Maybe a (mint az üres lista: [a])
  :t Just             -- az adatkonstruktor egy függvény: a -> Maybe a

FONTOS: Az adatkonstruktorok speciális függvények: ha megkapják a paramétereiket, egy értéket hoznak létre.

A Maybe típusra van Show, Eq és Ord példány is (ha az a típusra is van). Próbáljuk ki:
  Just 3 == Just 3
  Nothing < Just 3                     -- a Nothing az első konstruktor, ezért ez a kisebb
  maximum [Just 3, Nothing, Just 7]
-}

----------------------------------
-- Maybe értékek előállítása
----------------------------------
-- Tegyük totálissá a gyakorló feladatok függvényeit: ahol nincs eredmény, ott Nothing legyen az eredmény!

-- Definiáljuk az egész osztást úgy, hogy 0-val való osztás esetén Nothing legyen az eredmény.
-- Pl. safeDiv 7 2 == Just 3
--     safeDiv 7 0 == Nothing
--     safeDiv 0 5 == Just 0
safeDiv :: Int -> Int -> Maybe Int
safeDiv = undefined

-- Definiáljuk azt a függvényt, amely egy lista első elemét adja meg, ha van ilyen (vö. myHead).
-- Pl. safeHead [1,2,3] == Just 1
--     safeHead "alma" == Just 'a'
--     safeHead [] == Nothing
safeHead :: [a] -> Maybe a
safeHead = undefined

-- Definiáljuk azt a függvényt, amely egy lista első elem nélküli részét adja meg, ha van ilyen.
-- Figyeljük meg: most a Maybe paramétere maga is lista!
-- Pl. safeTail [1,2,3] == Just [2,3]
--     safeTail [1] == Just []
--     safeTail [] == Nothing
safeTail :: [a] -> Maybe [a]
safeTail = undefined

-- Definiáljuk azt a függvényt, amely egy lista utolsó elemét adja meg, ha van ilyen (vö. myLast).
-- Pl. safeLast [1,2,3] == Just 3
--     safeLast "a" == Just 'a'
--     safeLast [] == Nothing
safeLast :: [a] -> Maybe a
safeLast = undefined

-- Definiáljuk a lista indexelését (!!) úgy, hogy a lista határain kívül eső indexre Nothing legyen az eredmény.
-- Az indexelés 0-tól indul. Negatív indexre is Nothing legyen az eredmény.
-- Pl. safeIndex "alma" 0 == Just 'a'
--     safeIndex "alma" 3 == Just 'a'
--     safeIndex "alma" 4 == Nothing
--     safeIndex "alma" (-1) == Nothing
--     safeIndex [] 0 == Nothing
safeIndex :: [a] -> Int -> Maybe a
safeIndex = undefined

----------------------------------
-- Maybe értékek feldolgozása mintaillesztéssel
----------------------------------
{-
Egy Maybe értéket ugyanúgy mintaillesztéssel dolgozunk fel, mint bármelyik saját típusunkat:
a Nothing és a Just x mintákra kell felkészülnünk.
-}

-- Definiáljuk azt a függvényt, amely eldönti, hogy egy Maybe érték Just konstruktorral készült-e (Data.Maybe: isJust).
-- Pl. isJust' (Just 5)
--     not (isJust' Nothing)
isJust' :: Maybe a -> Bool
isJust' = undefined

-- Definiáljuk azt a függvényt, amely kicsomagolja a Just konstruktorba csomagolt értéket.
-- Ha nincs érték (Nothing), az első paraméterként kapott alapértelmezett értéket adja (Data.Maybe: fromMaybe).
-- Pl. fromMaybe' 0 (Just 5) == 5
--     fromMaybe' 0 Nothing == 0
--     fromMaybe' "nincs" (Just "van") == "van"
fromMaybe' :: a -> Maybe a -> a
fromMaybe' = undefined

-- Definiáljuk két Maybe érték összeadását.
--   - Két Just esetén az eredmény az összeg, Just konstruktorba csomagolva.
--   - Ha csak az egyik Just, akkor az eredmény ez a Just érték változatlanul.
--   - Két Nothing esetén az eredmény Nothing.
-- Pl. maybeAdd (Just 3) (Just 5) == Just 8
--     maybeAdd (Just 5) Nothing == Just 5
--     maybeAdd Nothing (Just 10) == Just 10
--     maybeAdd Nothing Nothing == Nothing
maybeAdd :: Num a => Maybe a -> Maybe a -> Maybe a
maybeAdd = undefined

-- Definiáljuk azt a függvényt, amely egy Maybe értékeket tartalmazó listából összegzi a Just konstruktorba csomagolt
-- értékeket.
-- Pl. maybeSum [] == 0
--     maybeSum [Just 5] == 5
--     maybeSum [Nothing, Just 5] == 5
--     maybeSum [Just 5, Nothing, Nothing] == 5
--     maybeSum [Just 5, Nothing, Just 10, Just 13] == 28
maybeSum :: Num a => [Maybe a] -> a
maybeSum = undefined

-- Definiáljuk azt a függvényt, amely egy Maybe értékeket tartalmazó listából kigyűjti a Just konstruktorba
-- csomagolt értékeket (Data.Maybe: catMaybes). Oldjuk meg rekurzívan és listagenerátorral is!
-- Ekkor a mintára nem illeszkedő elemeket a generátor egyszerűen kihagyja.
-- Pl. catMaybes' [Just 1, Nothing, Just 3] == [1,3]
--     catMaybes' [Nothing, Nothing :: Maybe Int] == []
--     catMaybes' [safeHead "alma", safeHead "", safeHead "fa"] == "af"
catMaybes' :: [Maybe a] -> [a]
catMaybes' = undefined

catMaybesLC :: [Maybe a] -> [a]
catMaybesLC = undefined

----------------------------------
-- Feladat: Repülési napló
----------------------------------
{-
Egy repülőgép naplója a magasságváltozásokat rögzíti méterben: Just d, ha a gép d métert emelkedett
(negatív d esetén süllyedt), és Nothing, ha a gép leszállt. A magasságot a tengerszinthez mérjük,
a gép egy tengerszinten (0 méteren) lévő repülőtérről indul. A repülőterek különböző magasságon lehetnek,
így leszálláskor a gép magassága nem feltétlenül 0.
-}

flightLog :: [Maybe Integer]
flightLog = [Just 300, Just 200, Just (-100), Just (-400), Nothing, Just 500, Just (-350), Nothing, Just 1000]

-- Definiáljuk azt a függvényt, amely megadja, hány métert tett meg a gép függőlegesen az első leszállásig.
-- Az emelkedés és a süllyedés is számít (abs). Ha a gép nem szállt le, a teljes naplót vegyük figyelembe.
-- Pl. verticalDistance flightLog == 1000
--     verticalDistance [Just 100, Just (-50)] == 150
--     verticalDistance [Nothing, Just 100] == 0
--     verticalDistance [] == 0
verticalDistance :: [Maybe Integer] -> Integer
verticalDistance = undefined

-- Definiáljuk azt a függvényt, amely megszámolja a leszállásokat.
-- Pl. landings flightLog == 2
--     landings [Just 100, Just (-100)] == 0
--     landings [] == 0
landings :: [Maybe Integer] -> Int
landings = undefined

-- Definiáljuk azt a függvényt, amely megadja a gép magasságát minden naplóbejegyzés után.
-- Leszálláskor a magasság nem változik.
-- Segítség: használjunk segédfüggvényt, amely egy segédparaméterben számon tartja az aktuális magasságot.
-- Pl. altitudes flightLog == [300,500,400,0,0,500,150,150,1150]
--     altitudes [Just 100, Just 50, Nothing, Just 20] == [100,150,150,170]
--     altitudes [] == []
altitudes :: [Maybe Integer] -> [Integer]
altitudes = undefined


----------------------------------
-- Függvényhívás eredményének feldolgozása
----------------------------------
{-
Gyakran egy függvényhívás (akár a rekurzív hívás) eredménye Maybe típusú, és ezt kellene tovább feldolgoznunk.
Ilyenkor adjuk át egy segédfüggvénynek, amely mintaillesztéssel dolgozza fel:

  halfOfHead :: [Int] -> Maybe Int
  halfOfHead xs = halfOf (safeHead xs)

  halfOf :: Maybe Int -> Maybe Int
  halfOf Nothing  = Nothing
  halfOf (Just x) = safeDiv x 2
-}

-- Definiáljuk azt a függvényt, amely egy listában megadja egy elem első előfordulásának indexét (Data.List: elemIndex, vö. myElemIndex).
-- Az indexelés 0-tól indul. Ha az elem nem szerepel a listában, az eredmény Nothing.
-- Segítség: ha a fej nem a keresett elem, a rekurzív hívás eredményét eggyel növelni kell, de csak ha Just!
-- Ehhez írjunk egy Maybe Int -> Maybe Int segédfüggvényt.
-- (Másik lehetőség: egy segédfüggvény, amely számon tartja az aktuális indexet, mint a 07. órán az elemIds-nél.)
-- Pl. safeElemIndex 1 [] == Nothing
--     safeElemIndex 1 [1,2,3] == Just 0
--     safeElemIndex 'l' "alma" == Just 1
--     safeElemIndex 5 [1,2,3,4,5,5] == Just 4
--     safeElemIndex 'x' "alma" == Nothing
safeElemIndex :: Eq a => a -> [a] -> Maybe Int
safeElemIndex = undefined

-- Definiáljuk azt a függvényt, amely megadja egy kulcshoz tartozó első értéket, ha van ilyen (Prelude: lookup, vö. myLookup).
-- Pl. safeLookup "Bela" phoneBook == Just "06-20-987-6543"
--     safeLookup "Dora" phoneBook == Nothing
--     safeLookup 2 [(1,'a'), (2,'b'), (2,'c')] == Just 'b'
safeLookup :: Eq k => k -> [(k, v)] -> Maybe v
safeLookup = undefined

-- Definiáljuk azt a függvényt, amely egy lista elemeinek átlagát (egész osztással) adja meg (vö. myAverage).
-- Üres lista esetén az eredmény Nothing. Használjuk a safeDiv függvényt!
-- Pl. safeAverage [1,2,3,4] == Just 2
--     safeAverage [10] == Just 10
--     safeAverage [] == Nothing
safeAverage :: [Int] -> Maybe Int
safeAverage = undefined

-- Definiáljuk azt a függvényt, amely egy lista legnagyobb elemét adja meg, ha van ilyen (vö. myMaximum). Oldjuk meg rekurzívan!
-- Pl. safeMaximum [3,1,4,1,5] == Just 5
--     safeMaximum "alma" == Just 'm'
--     safeMaximum [] == Nothing
safeMaximum :: Ord a => [a] -> Maybe a
safeMaximum = undefined

-- Definiáljuk azt a függvényt, amely megadja az első befejezett (leszállással végződő) repülés magasságváltozásait.
-- Ha a gép még egyszer sem szállt le, az eredmény Nothing.
-- Pl. firstFlight flightLog == Just [300,200,-100,-400]
--     firstFlight [Nothing, Just 100] == Just []
--     firstFlight [Just 100, Just (-100)] == Nothing
--     firstFlight [] == Nothing
firstFlight :: [Maybe Integer] -> Maybe [Integer]
firstFlight = undefined

-- Definiáljuk azt a függvényt, amely a naplót repülésekre bontja: minden leszállás lezár egy repülést.
-- Az eredmény utolsó eleme a még tartó repülés (üres, ha a gép éppen a földön van).
-- Segítség: az eredmény sosem üres lista. Ha a fej Just d, akkor a d-t a rekurzív hívás eredményének
-- első repüléséhez kell hozzáfűzni. Ehhez írjunk segédfüggvényt: addToFirst :: Integer -> [[Integer]] -> [[Integer]]
-- Pl. flights flightLog == [[300,200,-100,-400],[500,-350],[1000]]
--     flights [Just 100, Nothing] == [[100],[]]
--     flights [] == [[]]
flights :: [Maybe Integer] -> [[Integer]]
flights = undefined

----------------------------------
-- Feladat: Természetes szám beolvasása
----------------------------------
{-
Definiáljuk azt a függvényt, amely egy szövegként megadott nemnegatív egész számot számmá alakít.
Ha a szöveg üres, vagy nem csak számjegyekből áll, az eredmény Nothing.

Segítség:
  - Használjuk a Data.Char modul isDigit és digitToInt függvényeit.
  - Definiáljunk egy akkumulátoros segédfüggvényt, amely egy segédparaméterben tárolja a szám eddig
    feldolgozott részének értékét:

      Feldolgozandó    Akkumulátor
      "1234"           0
      "234"            0 * 10 + 1 = 1
      "34"             1 * 10 + 2 = 12
      "4"              12 * 10 + 3 = 123
      ""               123 * 10 + 4 = 1234

  - A segédfüggvényt a where kulcsszóval lokálisan is megadhatjuk, így kívülről nem látszik:

      f x = g x 0
        where
          g ... = ...
-}
-- Pl. readNat "0" == Just 0
--     readNat "007" == Just 7
--     readNat "" == Nothing
--     readNat "-1" == Nothing
--     readNat "123" == Just 123
--     readNat "12a4" == Nothing
--     readNat "1234233121223" == Just 1234233121223
readNat :: String -> Maybe Int
readNat = undefined

-- Definiáljuk azt a függvényt, amely Maybe értékek listájából akkor és csak akkor ad Just eredményt,
-- ha a lista minden eleme Just. Ekkor az eredmény a kicsomagolt értékek listája.
-- Gondoljuk meg: mi legyen az üres lista esetén az eredmény?
-- Pl. allJust [Just 1, Just 2, Just 3] == Just [1,2,3]
--     allJust [Just 1, Nothing, Just 3] == Nothing
--     allJust ([] :: [Maybe Int]) == Just []
allJust :: [Maybe a] -> Maybe [a]
allJust = undefined

-- Definiáljuk azt a függvényt, amely szövegek listáját számok listájává alakítja, ha mindegyik szám.
-- Használjuk a readNat és allJust függvényeket!
-- Pl. readNats ["1", "22", "333"] == Just [1,22,333]
--     readNats ["1", "egy", "3"] == Nothing
readNats :: [String] -> Maybe [Int]
readNats = undefined

-- Definiáljuk azt a függvényt, amely egy szóközökkel elválasztott számokat tartalmazó szöveg összegét adja meg.
-- Segítség: a Prelude words függvénye szóközök mentén darabolja a szöveget: words "1 22 333" == ["1","22","333"]
-- Pl. sumOfText "1 2 3 4" == Just 10
--     sumOfText "" == Just 0
--     sumOfText "1 2 harom" == Nothing
sumOfText :: String -> Maybe Int
sumOfText = undefined

----------------------------------
-- Nevezetes paraméteres típus: Either a b
----------------------------------
{-
A Maybe arra jó, hogy jelezzük: nincs eredmény. Azt viszont nem tudjuk vele elmondani, hogy MIÉRT nincs.
Az Either ezt egészíti ki: a hibás esetben is csomagolhatunk be egy értéket, például egy hibaüzenetet.

  data Either a b = Left a | Right b

Az Either típuskonstruktornak két típusparamétere van: az első a Left, a második a Right mezőjének típusa.
Megállapodás szerint a Left a hibás esetet, a Right a helyes ("right") eredményt jelöli.

  safePower :: Int -> Int -> Either String Int
  safePower x i
    | i < 0     = Left "Negative exponent"
    | otherwise = Right (x ^ i)

Próbáljuk ki GHCi-ben:
  :t Left 'a'
  :t Right True          -- a konstruktorokat külön nézve az egyik típusparaméter ismeretlen marad
  :t Left
  :t [Left 1, Right "egy"]
-}

-- Definiáljuk az egész osztást úgy, hogy 0-val való osztás esetén a Left "Division by zero" legyen az eredmény.
-- Pl. safeDivE 7 2 == Right 3
--     safeDivE 7 0 == Left "Division by zero"
safeDivE :: Int -> Int -> Either String Int
safeDivE = undefined

-- Definiáljuk a readNat függvényt úgy, hogy hiba esetén megmondja, mi volt a baj:
--   - üres szöveg esetén: Left "Empty input"
--   - ha nem számjegy karaktert talál: Left ("Invalid character: " ++ show c), ahol c az első hibás karakter.
-- Pl. readNatE "123" == Right 123
--     readNatE "" == Left "Empty input"
--     readNatE "12a4" == Left "Invalid character: 'a'"
--     readNatE "1-2+" == Left "Invalid character: '-'"
readNatE :: String -> Either String Int
readNatE = undefined

-- Definiáljuk az átalakítást Either-ből Maybe-be: a hibaüzenet elveszik.
-- Pl. eitherToMaybe (Right 5 :: Either String Int) == Just 5
--     eitherToMaybe (Left "hiba" :: Either String Int) == Nothing
eitherToMaybe :: Either e a -> Maybe a
eitherToMaybe = undefined

-- Definiáljuk az átalakítást Maybe-ből Either-be: a Nothing helyett a megadott hibaüzenet kerüljön a Left-be.
-- Pl. maybeToEither "nincs ilyen" (Just 5) == Right 5
--     maybeToEither "nincs ilyen" (safeLookup "Dora" phoneBook) == Left "nincs ilyen"
maybeToEither :: e -> Maybe a -> Either e a
maybeToEither = undefined

-- Feladat: Regisztráció
-- Egy felhasználónak neve és életkora van.
data User = User String Int deriving (Show, Eq)

-- Definiáljuk a név ellenőrzését:
--   - üres név esetén: Left "Empty name"
--   - ha a név nem nagybetűvel kezdődik: Left "Name must start with an uppercase letter"
--   - egyébként a név változatlanul, Right-ba csomagolva.
-- Pl. validateName "Anna" == Right "Anna"
--     validateName "" == Left "Empty name"
--     validateName "anna" == Left "Name must start with an uppercase letter"
validateName :: String -> Either String String
validateName = undefined

-- Definiáljuk az életkor ellenőrzését: 0 és 150 között (a határokat is beleértve) legyen.
-- Pl. validateAge 20 == Right 20
--     validateAge (-1) == Left "Invalid age"
--     validateAge 200 == Left "Invalid age"
validateAge :: Int -> Either String Int
validateAge = undefined

-- Definiáljuk a felhasználó létrehozását: ha a név és az életkor is helyes, az eredmény a felhasználó.
-- Különben az első hibát adjuk vissza (először a nevet ellenőrizzük).
-- Segítség: írjunk segédfüggvényt, amely a két ellenőrzés eredményét kapja, és mintaillesztéssel dolgozza fel őket.
-- Pl. mkUser "Anna" 20 == Right (User "Anna" 20)
--     mkUser "anna" 20 == Left "Name must start with an uppercase letter"
--     mkUser "Anna" 200 == Left "Invalid age"
--     mkUser "" 200 == Left "Empty name"
mkUser :: String -> Int -> Either String User
mkUser = undefined

-- Definiáljuk a felhasználó létrehozását úgy, hogy az életkor is szövegként érkezik (pl. egy űrlapról).
-- Használjuk a readNatE és mkUser függvényeket!
-- Pl. mkUserFromForm "Anna" "20" == Right (User "Anna" 20)
--     mkUserFromForm "Anna" "huszonegy" == Left "Invalid character: 'h'"
--     mkUserFromForm "Anna" "" == Left "Empty input"
--     mkUserFromForm "anna" "20" == Left "Name must start with an uppercase letter"
mkUserFromForm :: String -> String -> Either String User
mkUserFromForm = undefined

{-
Az Either nem csak hibakezelésre jó: általánosan azt fejezi ki, hogy egy érték "vagy ilyen, vagy olyan" típusú.
Így például egy listába tehetünk számokat és szövegeket is: [Left 1, Right "egy", Left 2] :: [Either Int String]
-}

-- Definiáljuk azt a függvényt, amely kigyűjti egy Either értékeket tartalmazó listából a Left értékeket (Data.Either: lefts),
-- illetve a Right értékeket (Data.Either: rights). Használjunk listagenerátort!
-- Pl. lefts' [Left 1, Right "egy", Left 2] == [1,2]
--     rights' [Left 1, Right "egy", Left 2] == ["egy"]
lefts' :: [Either a b] -> [a]
lefts' = undefined

rights' :: [Either a b] -> [b]
rights' = undefined

----------------------------------
-- Rekurzív típusok
----------------------------------
{-
A lista valójában egy rekurzív adatszerkezet: a (:) konstruktor egy elemből és egy másik listából épít listát.
A tanult eszközökkel magunk is leírhatjuk:

  data List a = Nil | Cons a (List a)

  Nil  : az üres listát reprezentálja ([])
  Cons : a (:) konstruktornak felel meg: egy elemből és egy listából épít egy újabb listát

A Cons konstruktor második mezője visszahivatkozik az éppen definiált típusra: ettől rekurzív a típus.
Az infixr deklarációval megadjuk, hogy a `Cons` infix alakja ugyanúgy viselkedjen, mint a (:).

Az [1,2,3] lista így: Cons 1 (Cons 2 (Cons 3 Nil)), vagy infix alakban: 1 `Cons` 2 `Cons` 3 `Cons` Nil
-}

data List a = Nil | Cons a (List a) deriving (Show, Eq)
infixr 5 `Cons`