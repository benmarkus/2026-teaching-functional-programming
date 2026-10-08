module GY05 where
import Data.Char (toUpper, isUpper)

----------------------------------
-- Listák
----------------------------------
{-
Eddig egyszerű típusokkal dolgoztunk (Bool, Char, Integer, Int, Double), amelyek mind egyetlen értéket tárolnak.
Ma megismerkedünk az első összetett adatszerkezetekkel: a listával és a rendezett n-essel.

A lista a nyelv leggyakrabban használt adatszerkezete. Tulajdonságai:
  - dinamikus: tetszőleges számú eleme lehet (üres, véges, sőt akár végtelen is),
  - homogén: az összes elemének ugyanolyan típusúnak kell lennie (nem keverhetők a típusok),
  - számít a sorrend és lehetnek ismétlődések: [1,2] /= [2,1] és [1,1] /= [1].

Listát az elemei felsorolásával adhatunk meg, szögletes zárójelben, vesszővel elválasztva.
A lista típusát is szögletes zárójellel jelöljük, benne az elemek típusával:

  [1, 2, 3]                  :: [Integer]
  [True, False]              :: [Bool]
  [(1, 'a'), (2, 'b')]       :: [(Integer, Char)]   -- (a rendezett párokról később lesz szó)
  [[1], [2, 3], []]          :: [[Integer]]          -- listák listája is lehet

Próbáljuk ki GHCi-ben, és nézzük meg a típusukat is a :t paranccsal!
-}

-- Mi a típusa az alábbi kifejezéseknek? Tippeljük meg, majd ellenőrizzük GHCi-ben (:t)
--   [1, 2, 3]
--   [1.5, 2]
--   ['a', 'b']
--   [[True], [], [False, False]]
--   []
--   [[], []]
--   [1, True]      <- mit kapunk és miért?

{-
Az üres lista típusa [a], hiszen nincs egyetlen eleme sem, ami megszorítaná, milyen típusú elemekből áll.
Az 'a' egy típusváltozó, helyére bármilyen típus kerülhet (ezt hívjuk parametrikus polimorfizmusnak).
Az [1,2,3] típusa Num a => [a], hiszen a számliterálok is polimorfak.
-}

----------------------------------
-- String = [Char]
----------------------------------
{-
Haskellben nincs külön szöveg típus: a String nem más, mint karakterek listája.
A String és a [Char] teljesen ugyanazt jelenti, a String csak egy kényelmesebb név.
  "alma" == ['a', 'l', 'm', 'a']
Ebből következik, hogy MINDEN, amit a listákról tanulunk, működik a szövegekre is!
-}

-- Próbáljuk ki GHCi-ben:
--   "alma" == ['a','l','m','a']
--   :t "alma"
--   "alma" ++ "fa"
--   length "alma"

----------------------------------
-- Szögletes zárójelek helyett: a lista felépítése
----------------------------------
{-
A [1,2,3] felsorolás valójában csak szintaktikai cukorka. Minden lista két "építőkockából" áll:
  []          :: [a]                -- az üres lista
  (:)         :: a -> [a] -> [a]    -- egy elemet a lista ELEJÉRE fűz

Az (:) operátor jobbra köt, ezért az alábbi kifejezések mind UGYANAZT a listát jelentik:
  [1, 2, 3]
  1 : [2, 3]
  1 : 2 : [3]
  1 : 2 : 3 : []
  1 : (2 : (3 : []))

A lista tehát egy láncolt szerkezet: van egy első eleme (fej), és van a maradéka (törzs), ami szintén lista.
Emiatt egy lista elejéhez hozzáfűzni olcsó, a végéhez viszont nem, az i-edik elem eléréséhez pedig
végig kell lépkedni az előtte lévő elemeken. A listát ezért mindig az elejétől haladva dolgozzuk fel.
-}

----------------------------------
-- Mintaillesztés listákra
----------------------------------
{-
Mivel minden lista vagy [] vagy (x:xs) alakú, a mintaillesztés is ezt a két alakot használja.
Leggyakoribb minták:

  []          -- csak az üres lista illeszkedik rá
  (x:xs)      -- minden NEM üres lista illeszkedik; x a fejelem, xs a törzs (ami lehet üres is)
  (x:[])      -- pontosan egyelemű lista (a [x] minta is ugyanezt jelenti)
  (x:y:xs)    -- legalább kételemű lista; x az első, y a második elem, xs a maradék
  (x:y:[])    -- pontosan kételemű lista

Az x, xs nevek csak megszokás ("x többes száma xs"), bármi lehet a nevük. Fontos, hogy a sorrend számít:
az (xs:x) minta NEM az utolsó elemet választaná le, hanem az xs lenne a fejelem, az x pedig a törzs.
Az utolsó elemre nem lehet közvetlenül mintát illeszteni, ahhoz végig kell járni a listát.

Mivel a lista elemei nem számítanak, ha csak a szerkezetére vagyunk kíváncsiak, használhatjuk a _ mintát.
-}

-- Üres-e a lista? (Prelude: null)
isEmpty = undefined

-- Pontosan egyelemű-e a lista?
isSingleton = undefined

-- Definiáljuk azt a függvényt, amely eldönti egy listáról, hogy pontosan kételemű-e.
isDoubleton = undefined

{-
Két gyakori függvény: a lista feje (head) és törzse (tail).
Mindkettő csak nem üres listára működik. Mit lehetne az üres listával kezdeni?
head esetén nincs mit visszaadni (a típus bármi lehet), tail esetén pedig megtévesztő lenne
az üres listát visszaadni. Az ilyen függvényeket PARCIÁLISAN definiáltnak nevezzük:
az értelmezési tartomány egy részén nincs definiálva, ott futásidejű hibát kapunk.
-}

-- Definiáljuk a head függvényt (hd néven)
hd :: [a] -> a
hd = undefined

-- Definiáljuk a tail függvényt (tl néven)
tl :: [a] -> [a]
tl = undefined

-- Definiáljuk azt a függvényt, amely egy szó kezdőbetűjét nagybetűsíti (az üres szót változatlanul hagyja).
-- Segítség: a toUpper függvényt használhatjuk (Data.Char)
capitalize :: String -> String
capitalize = undefined

-- Definiáljuk azt a függvényt, amely egy lista első két elemét cseréli fel.
-- Ha a listában nincs legalább két elem, akkor változatlanul adjuk vissza.
swapFirstTwo :: [a] -> [a]
swapFirstTwo = undefined

----------------------------------
-- Rekurzió listákon
----------------------------------
{-
Egy lista feldolgozásához a már ismert rekurzív gondolkodást használjuk:
  1. Alapeset: az üres lista ([]), aminek könnyen megmondható az eredménye.
  2. Rekurzív eset: (x:xs). Feltesszük, hogy az xs-re már tudjuk a választ, és ebből, valamint
     az x-ből kiszámoljuk az egész listára vonatkozó eredményt.

Példa: a lista hossza (Prelude: length). Az üres lista hossza 0, egyébként a törzs hosszánál eggyel több.
Az x értéke nem számít, ezért _ mintát írtunk.
-}
length' :: [a] -> Integer
length' []     = 0
length' (_:xs) = 1 + length' xs

{-
Kiértékelés lépésről lépésre:
  length' [7,8,9]
  = 1 + length' [8,9]
  = 1 + (1 + length' [9])
  = 1 + (1 + (1 + length' []))
  = 1 + (1 + (1 + 0))
  = 3
-}

-- Számok összege (Prelude: sum). Az üres összeg definíció szerint 0.
sum' = undefined 

-- Definiáljuk a számok listájának szorzatát (Prelude: product). Az üres szorzat definíció szerint 1.
product' = undefined

-- Definiáljuk azt a függvényt, amely egy lista utolsó elemét adja meg (Prelude: last).
-- Segítség: mi a legrövidebb lista, aminek még van utolsó eleme?
last' = undefined

-- Definiáljuk azt a függvényt, amely egy nem üres számlista legkisebb elemét adja meg.
-- Segítség: a min :: Ord a => a -> a -> a függvény két elem közül a kisebbet adja.
minimum' = undefined

-- Definiáljuk azt a függvényt, amely egy szövegből csak a nagybetűket tartja meg ("Hello World" -> "HW").
-- Segítség: az isUpper :: Char -> Bool függvényt használhatjuk (Data.Char)
onlyUppers :: String -> String
onlyUppers = undefined

-- Definiáljuk azt a függvényt, amely egy lista első n elemét adja vissza (Prelude: take).
-- Legyen totális: az üres listából, illetve 0 vagy negatív számú elem kivétele se okozzon hibát.
take' :: Int -> [a] -> [a]
take' = undefined

-- Definiáljuk azt a függvényt, amely egy lista első n elemét eldobja (Prelude: drop).
-- Ne ellenőrizzük a lista hosszát, a minták majd kiderítik, ha elfogytak az elemek!
drop' :: Int -> [a] -> [a]
drop' = undefined

-- Definiáljuk a lista összefűzését (Prelude: (++)).
-- Segítség: az első listát bontjuk fel elemenként, a második listát nem kell vizsgálnunk.
infixr 5 +++
(+++) :: [a] -> [a] -> [a]
(+++) = undefined

-- Definiáljuk azt a függvényt, amely egy elemet n-szer ismétel meg (Prelude: replicate).
replicate' :: Int -> a -> [a]
replicate' = undefined

---------------------------------
-- Rendezett n-esek (tuple)
----------------------------------
{-
A rendezett n-esekkel több értéket tudunk egy egységbe "csomagolni". Például ha egy függvény
több értéket szeretne visszaadni, vagy összetartozó adatokat tárolunk (egy pont x és y koordinátája).
Az elemeket vesszővel elválasztva, kerek zárójelben adjuk meg:

  (1, 'a')            :: (Integer, Char)
  (True, 6, "alma")   :: (Bool, Integer, String)

A listával szemben a rendezett n-es:
  - HETEROGÉN: az elemei különböző típusúak lehetnek,
  - FIX méretű: a komponensek száma a típusból kiderül és nem változhat,
  - a típus a komponensek típusától és sorrendjétől is függ: (Integer, Bool) /= (Bool, Integer)

Összefoglalva:
              | lista                 | rendezett n-es
  ------------+-----------------------+---------------------------
  elemek      | azonos típusúak       | különböző típusúak lehetnek
  elemszám    | tetszőleges           | fix (a típus része)
  típus       | [Integer]             | (Integer, Bool)

A rendezett párok komponenseit az fst és snd függvényekkel kaphatjuk meg:
  fst (1, 'a') == 1
  snd (1, 'a') == 'a'
Ezek csak PÁROKRA működnek, hármasokra nem! A gyakorlatban viszont ritkán használjuk őket, mert
mintaillesztéssel sokkal kényelmesebb kinyerni az elemeket.
-}

-- Mintaillesztés rendezett n-esekre: ugyanolyan alakú mintát írunk, mint amilyen alakú az érték.
first :: (a, b) -> a
first = undefined 

first3 :: (a, b, c) -> a
first3 = undefined

-- A mintaillesztés kombinálható is: a minta tetszőlegesen mélyen megadható.
-- Pl. egy listában lévő párok első elemének kinyerése:
firstOfFirst = undefined

-- Definiáljuk a rendezett pár második komponensét visszaadó függvényt (Prelude: snd)
second = undefined

-- Definiáljuk azt a függvényt, amely felcseréli a rendezett pár két komponensét.
swap = undefined

-- Definiáljuk azt a függvényt, amely egy pontot tükröz az x tengelyre.
mirrorX :: (Integer, Integer) -> (Integer, Integer)
mirrorX = undefined

-- Definiáljuk az origó középpontú nagyítást: az első paraméter a nagyítás mértéke, a második a pont.
scale' :: Integer -> (Integer, Integer) -> (Integer, Integer)
scale' = undefined

-- Definiáljuk azt a függvényt, amely az első pontra tükrözi a második pontot.
mirrorP :: (Integer, Integer) -> (Integer, Integer) -> (Integer, Integer)
mirrorP = undefined

----------------------------------
-- Listák és rendezett n-esek együtt
----------------------------------
{-
A két adatszerkezet jól kombinálható: például [(String, Integer)] egy név-pontszám táblázat.
A listára és a rendezett párra való mintaillesztést egymásba ágyazhatjuk: ((a, b):rest).
-}

-- Definiáljuk azt a függvényt, amely két listából párok listáját készít (Prelude: zip).
-- Ha az egyik lista rövidebb, akkor a hosszabb felesleges elemeit eldobjuk.
-- zip' [1,2,3] "ab" == [(1,'a'),(2,'b')]
zip' = undefined

-- Definiáljuk a zip' fordítottját, amely egy párokból álló listát két listává bont szét (Prelude: unzip).
-- unzip' [(1,'a'),(2,'b')] == ([1,2],"ab")
-- Segítség: a rekurzív hívás eredményét is mintaillesztéssel bonthatjuk fel, pl. let (as, bs) = unzip' xs in ...
unzip' = undefined
