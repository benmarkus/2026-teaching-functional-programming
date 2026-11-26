module GY11 where
import Data.Char (toUpper, isUpper)
import Data.List (group)
----------------------------------
-- Gyakorló feladatok
----------------------------------

-- Definiáljuk azt a függvényt, amely listák listáját egyetlen listává fűzi össze (Prelude: concat).
-- Pl. concat' [[1,2],[3],[],[4,5]] == [1,2,3,4,5]
--     concat' ["al", "ma"] == "alma"
--     concat' [[],[]] == []
concat' :: [[a]] -> [a]
concat' = undefined

-- Definiáljuk azt a függvényt, amely egy lista minden elemét megduplázza.
-- Pl. doubleAll [1,2,3] == [2,4,6]
--     doubleAll [] == []
doubleAll :: [Int] -> [Int]
doubleAll = undefined

-- Definiáljuk azt a függvényt, amely egy szöveg minden betűjét nagybetűre cseréli.
-- Pl. shout "alma" == "ALMA"
--     shout "Hello, World!" == "HELLO, WORLD!"
shout :: String -> String
shout = undefined

-- Definiáljuk azt a függvényt, amely szavak listájából a szavak hosszainak listáját adja meg.
-- Pl. wordLengths ["alma", "korte", "szilva"] == [4,5,6]
--     wordLengths ["", "a"] == [0,1]
wordLengths :: [String] -> [Int]
wordLengths = undefined

-- Definiáljuk azt a függvényt, amely egy listából csak a páros számokat tartja meg.
-- Pl. evens [1,2,3,4,5,6] == [2,4,6]
--     evens [1,3,5] == []
evens :: [Int] -> [Int]
evens = undefined

-- Definiáljuk azt a függvényt, amely egy szövegből csak a nagybetűket tartja meg.
-- Pl. capitals "Haskell Brooks Curry" == "HBC"
--     capitals "alma" == ""
capitals :: String -> String
capitals = undefined

-- Definiáljuk azt a függvényt, amely szavak listájából kihagyja az üres szövegeket.
-- Pl. nonEmpty ["alma", "", "korte", ""] == ["alma", "korte"]
--     nonEmpty ["", ""] == []
nonEmpty :: [String] -> [String]
nonEmpty = undefined

----------------------------------
-- Curryzés
----------------------------------
{-
Egy új tulajdonságát nézzük meg a függvényeknek: minden függvény valójában egyparaméteres.
A többparaméteres függvények megadásának lehetősége csupán "szintaktikai cukorka", ami a kényelmünket szolgálja.
Minden függvény, ami több paramétert vár, átírható egyparaméteres függvények sorozatává.

Nézzük ezt egy példán keresztül! A könnyebb átláthatóság kedvéért specializáljuk az összeadást az Integer típusra:
-}

addInt :: Integer -> Integer -> Integer
addInt x y = x + y

{-
A típusleírásban használt -> is egy operátor (típuskonstruktor), ami típusokon értelmezett.
Két típus közötti leképezést ad meg: az értelmezési tartomány típusa -> az értékkészlet típusa.

Az operátor jobbra köt (jobbasszociatív), így az összeadás típusa az alábbi módon is megadható:
  addInt :: Integer -> (Integer -> Integer)

Így már jobban látszik, mit jelent a curryzés: az összeadás lényegében egy egyparaméteres függvény.
Ha ezt a paramétert átadjuk neki, az eredmény egy újabb egyparaméteres függvény lesz.
Ez a függvény várja majd a következő paramétert, ami után az összeadás már kiértékelhető.

Ebből adódik, hogy a függvények parciálisan alkalmazhatók. Nézzük meg ezt lépésenként, a kifejezések típusán keresztül!
Próbáljuk ki GHCi-ben:
  :t addInt 42          -- addInt 42 :: Integer -> Integer
Ez egy olyan függvény, ami egy tetszőleges számot megnövel 42-vel. Adjuk meg a következő paramétert is:
  :t (addInt 42) 10     -- (addInt 42) 10 :: Integer
  (addInt 42) 10        -- 52
Ezzel a "következő" függvény paraméterét is rögzítettük, a kifejezés már kiértékelhető.

Ezzel a módszerrel például egy 3 paraméteres függvényből egy 2 vagy 1 paraméteres függvényt tudunk "faragni".

További példák parciálisan alkalmazott függvényekre:
  :t take 10            -- take 10 :: [a] -> [a]
  :t (+) 1              -- (+) 1 :: Num a => a -> a
  :t (++) [1,2,3]       -- (++) [1,2,3] :: Num a => [a] -> [a]
-}

----------------------------------
-- Operátor szeletek
----------------------------------
{-
Operátorok (vagy operátorként használt függvények) esetén a fenti sorrendet egy kicsit fel tudjuk rúgni.
Az operátorokból szeleteket képezhetünk, azaz nem feltétlenül csak az első paramétert adhatjuk meg.
Próbáljuk ki GHCi-ben:
  :t (1 +)              -- Num a => a -> a
                        -- a bal oldali operandus rögzített, megfelel a szokásos sorrendnek: (+) 1
  :t (+ 1)              -- Num a => a -> a
                        -- a jobb oldali operandus rögzített
  :t (0 >)              -- (Ord a, Num a) => a -> Bool
                        -- a bal oldali operandus rögzített, a paraméter a jobb oldalra kerül: (>) 0
  :t (> 0)              -- (Ord a, Num a) => a -> Bool
                        -- a jobb oldali operandus rögzített
  :t (`mod` 3)          -- Integral a => a -> a
                        -- hárommal vett osztási maradékot előállító művelet

A különbség ott látszik, ahol az operátor nem felcserélhető:
  (0 >) 5               -- False, mert 0 > 5
  (> 0) 5               -- True,  mert 5 > 0
-}

----------------------------------
-- Magasabbrendű függvények: map és filter
----------------------------------
{-
Definíció: magasabbrendű függvénynek nevezzük azt a függvényt, amely
  - függvényt vár paraméterül, vagy
  - függvényt ad vissza eredményül.

Haskellben minden függvény, a konstansok is: 5 vagy "alma" paraméter nélküli, konstans függvények.
Emiatt az első feltétel ebben a formában értelmetlen: minden paraméter függvény, így minden paraméteres függvény
magasabbrendű lenne, és a fogalom elveszítené a jelentését.
Ezért megszorítjuk: akkor magasabbrendű egy függvény, ha van olyan paramétere, amely maga is paraméteres
(nem konstans) függvény. Ez a típusán is látszik.

A második feltételnek viszont van értelme: egy függvény eredménye lehet paraméteres függvény.
Pl.
  add :: Int -> Int -> Int
  add x y = x + y
Itt add 1 egy függvény, amely 1-et ad a paraméteréhez: (add 1) 5 == 6.
Ez éppen a curryzés, amit az előző részben láttunk.

Haskellben a függvények is értékek, ezért paraméterként átadhatók egy másik függvénynek.
Így a közös részt egyszer írjuk meg, a különböző részt (az elemre alkalmazott függvényt) pedig paraméterként adjuk át.

A típusban a függvény paramétert zárójelezni kell:
  (a -> b) -> [a] -> [b]   -- egy függvény és egy lista a paraméter
   a -> b  -> [a] -> [b]   -- ez valami egészen más: három paraméter
-}

-- Definiáljuk azt a függvényt, amely egy függvényt alkalmaz egy lista minden elemére (Prelude: map).
-- Pl. map' (*2) [1,2,3] == [2,4,6]
--     map' toUpper "alma" == "ALMA"
--     map' length ["alma", "korte"] == [4,5]
map' = undefined

-- Definiáljuk azt a függvényt, amely egy listából csak azokat az elemeket tartja meg, amelyekre a feltétel teljesül (Prelude: filter).
-- Pl. filter' even [1,2,3,4,5,6] == [2,4,6]
--     filter' isUpper "Haskell Brooks Curry" == "HBC"
--     filter' (/= "") ["alma", "", "korte"] == ["alma", "korte"]
filter' = undefined

----------------------------------
-- Gyakorló feladatok újra, map és filter segítségével
----------------------------------
-- Definiáljuk újra a gyakorló feladatok függvényeit, most rekurzió nélkül, a map és filter függvényekkel.
-- Az eredmények egyezzenek meg a fenti változatokéval.

-- Pl. doubleAll' [1,2,3] == [2,4,6]
doubleAll' :: [Int] -> [Int]
doubleAll' = undefined

-- Pl. shout' "alma" == "ALMA"
shout' :: String -> String
shout' = undefined

-- Pl. wordLengths' ["alma", "korte", "szilva"] == [4,5,6]
wordLengths' :: [String] -> [Int]
wordLengths' = undefined

-- Pl. evens' [1,2,3,4,5,6] == [2,4,6]
evens' :: [Int] -> [Int]
evens' = undefined

-- Pl. capitals' "Haskell Brooks Curry" == "HBC"
capitals' :: String -> String
capitals' = undefined

-- Pl. nonEmpty' ["alma", "", "korte", ""] == ["alma", "korte"]
nonEmpty' :: [String] -> [String]
nonEmpty' = undefined

----------------------------------
-- Eta-redukció
----------------------------------
{-
Ha egy függvénydefinícióban a paraméter a bal és a jobb oldal legvégén is szerepel, és máshol nem,
akkor mindkét oldalról elhagyható:
  f x = g x    helyett írhatjuk:    f = g

Ezt eta-redukciónak (η-redukció) nevezzük. A curryzés miatt működik: g egyparaméteres függvény,
f x = g x pedig csak annyit mond, hogy f minden paraméterre ugyanazt adja, mint g, vagyis f és g ugyanaz a függvény.

Itt map (*2) egy parciálisan alkalmazott függvény: [Int] -> [Int], pont olyan, amilyen doubleAll'-nak kell.

Több paraméter esetén is működik, jobbról balra haladva:
  plus x y = addInt x y
  plus x   = addInt x
  plus     = addInt

Operátor szeletekkel együtt is használható:
  inc x = x + 1
  inc x = (+ 1) x                   -- ugyanaz, szelettel felírva
  inc   = (+ 1)

Mikor NEM lehet elhagyni a paramétert?
  f x = g x x                       -- x máshol is szerepel
  f x = g x + 1                     -- a jobb oldal nem g x alakú, hanem (+) (g x) 1
  f x y = g x                       -- x nem az utolsó paraméter

A fordított irányt (f = g helyett f x = g x) eta-expanziónak nevezzük.
-}

----------------------------------
-- Lambda függvények
----------------------------------
{-
Gyakran csak egyszer van szükségünk egy függvényre, pl. map vagy filter paramétereként.
Ilyenkor nem kell külön nevet adnunk neki, helyben is megadhatjuk névtelen függvényként (lambda függvényként):
  \x -> x * x + 1
A \ jel a görög λ betűt idézi. Utána jönnek a paraméterek, a -> után pedig a függvény törzse.

Próbáljuk ki GHCi-ben:
  (\x -> x * x + 1) 3                              -- 10
  map (\x -> x * x + 1) [1,2,3]                    -- [2,5,10]
  filter (\w -> length w > 3) ["a", "alma", "ko"]  -- ["alma"]
  :t \x -> x * x + 1                               -- Num a => a -> a

Ez a két definíció ugyanazt jelenti, a függvénydefiníció a lambda kifejezés "szintaktikai cukorkája":
  square x = x * x
  square   = \x -> x * x

Lambdának több paramétere is lehet. A curryzés miatt ez is egyparaméteres függvények sorozata:
  \x y -> x + y
  \x -> \y -> x + y                                -- ugyanaz
  (\x y -> x + y) 2 3                              -- 5

Lambdában is használhatunk mintaillesztést:
  map (\(name, phone) -> name) [("Anna", "06-30-123-4567"), ("Bela", "06-20-987-6543")]  -- ["Anna","Bela"]

Az eta-redukció lambdákra is igaz: \x -> f x ugyanaz, mint f.
  map (\x -> toUpper x) "alma"   ==   map toUpper "alma"
  map (\x -> x * 2) [1,2,3]      ==   map (* 2) [1,2,3]
Ha van megfelelő nevesített függvény vagy operátor szelet, általában azt érdemes használni lambda helyett.
-}

----------------------------------
-- További magasabbrendű függvények
----------------------------------

-- Definiáljuk azt a függvényt, amely eldönti, hogy a lista valamelyik elemére teljesül-e az adott tulajdonság (Prelude: any).
-- Pl. any' even [1,3,4,5] == True
--     any' isUpper "haSkell" == True
--     any' even [1,3,5] == False
--     any' even [] == False
any' :: (a -> Bool) -> [a] -> Bool
any' = undefined

-- Definiáljuk azt a függvényt, amely megvizsgálja, hogy egy lista minden elemére teljesül-e egy tulajdonság (Prelude: all).
-- Pl. all' even [2,4,6] == True
--     all' isUpper "HBC" == True
--     all' even [] == True
--     all' even [2,3,4] == False
all' :: (a -> Bool) -> [a] -> Bool
all' = undefined

-- Definiáljuk az elem függvényt az any felhasználásával (Prelude: elem).
-- Pl. elem' 3 [1,2,3] == True
--     elem' 'l' "alma" == True
--     elem' 5 [1,2,3] == False
elem' :: Eq a => a -> [a] -> Bool
elem' = undefined

-- Definiáljuk azt a függvényt, amely a listának azt a kezdőszeletét veszi, amelynek minden elemére teljesül a megadott feltétel.
-- Azaz addig veszi a lista elejéről az elemeket, amíg a feltétel "el nem romlik" (Prelude: takeWhile).
-- Pl. takeWhile' even [1,2,3] == []
--     takeWhile' (< 5) [1,2,3,4,5,6,5,4,3,2] == [1,2,3,4]
--     takeWhile' even [2,2,4,2,6,7,8] == [2,2,4,2,6]
--     takeWhile' (< 500) (map (^2) [1..]) == [1,4,9,16,25,36,49,64,81,100,121,144,169,196,225,256,289,324,361,400,441,484]
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' = undefined

-- Definiáljuk azt a függvényt, amely eldobja a listának azt a kezdőszeletét, amelynek minden elemére teljesül a megadott feltétel.
-- Azaz addig dobja el a lista elejéről az elemeket, amíg a feltétel "el nem romlik" (Prelude: dropWhile).
-- Pl. dropWhile' even [] == []
--     dropWhile' (< 5) [1,2,3,4,5,6,5,4,3,2] == [5,6,5,4,3,2]
--     dropWhile' (> 5) [1,2,3,4,5,6,5,4,3,2] == [1,2,3,4,5,6,5,4,3,2]
--     dropWhile' (< 3) [1,2,3,4,5,6,5,4,3,2] == [3,4,5,6,5,4,3,2]
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' = undefined

-- Definiáljuk azt a függvényt, amely egy lista egymás melletti egyenlő elemeit csoportokba gyűjti (Data.List: group).
-- Segítség: használjuk a takeWhile' és dropWhile' függvényeket.
-- Pl. group' [1,1,2,3,3,3,1] == [[1,1],[2],[3,3,3],[1]]
--     group' "Mississippi" == ["M","i","ss","i","ss","i","pp","i"]
--     group' "alma" == ["a","l","m","a"]
--     group' "" == []
group' :: Eq a => [a] -> [[a]]
group' = undefined
----------------------------------
-- A $ operátor
----------------------------------
{-
A $ operátor a függvényalkalmazás:
  ($) :: (a -> b) -> a -> b
  f $ x = f x

Első ránézésre haszontalannak tűnik, de a precedenciája a lehető legalacsonyabb (0), és jobbra köt.
Ezért a jobb oldalán álló teljes kifejezés előbb kiértékelődik, így megspórolhatjuk vele a zárójeleket:
  length (filter even (map (+1) [1,2,3,4]))
  length $ filter even $ map (+1) [1,2,3,4]        -- ugyanaz: 2

  takeWhile' (< 500) (map (^2) [1..])
  takeWhile' (< 500) $ map (^2) [1..]               -- ugyanaz

Mivel operátor, szeletet is képezhetünk belőle. Pl. több függvényt alkalmazhatunk ugyanarra az értékre:
  map ($ 3) [(+ 1), (* 2), \x -> x * x]            -- [4,6,9]
-}

----------------------------------
-- Cipzározás adott művelettel
----------------------------------

-- Definiáljuk azt a függvényt, amely a zip függvényhez hasonlóan két listát cipzároz össze,
-- de az elemeket nem párokba szervezi, hanem a megadott műveletet alkalmazza rájuk (Prelude: zipWith).
-- Ha az egyik lista rövidebb, a hosszabb lista maradék elemeit eldobjuk.
-- Pl. zipWith' (*) [1,2,3,4] [5,6,7,8] == [5,12,21,32]
--     zipWith' (+) [1,2,3,4] [5,6,7,8] == [6,8,10,12]
--     zipWith' (,) [1,2,3] "hello" == [(1,'h'),(2,'e'),(3,'l')]
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' = undefined

{-
A zipWith általánosabb a zip-nél, így nem meglepő, hogy az utóbbi kifejezhető az előbbivel.
A párok konstruktora, a (,) is egy kétparaméteres függvény:
  :t (,)                -- (,) :: a -> b -> (a, b)
  (,) 1 'h'             -- (1,'h')
Így teljesen megfelel a zipWith paraméterének, a zip egy lehetséges definíciója tehát:
  zip = zipWith (,)
-} 
