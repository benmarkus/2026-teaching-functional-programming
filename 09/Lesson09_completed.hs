module GY09 where

----------------------------------
-- Saját típusok
----------------------------------
{-
Eddig alaptípusokkal (Int, Integer, Double, Char, Bool) és két összetett típussal (lista, rendezett n-es)
dolgoztunk. Ezekkel szinte bármit le tudunk írni, de a kód gyorsan átláthatatlanná válik: egy (Int, Int)
pár lehet koordináta, időpont, tört, dominó... a típusból nem derül ki, hogy mit jelent.

Ma két eszközt nézünk meg:
  - type : új NÉV egy már létező típusnak (típusszinonima),
  - data : valóban ÚJ típus (algebrai adattípus).
-}

----------------------------------
-- Típusszinonimák
----------------------------------
{-
A type kulcsszóval egy már létező típusnak adhatunk új nevet. Ilyennel már találkoztunk is:
  type String = [Char]

A szinonima csak egy rövidítés: a fordító számára a két név pontosan ugyanazt a típust jelenti.
A típus nevét nagy kezdőbetűvel kell írni.
-}

-- Definiáljuk a Point (egy pont a síkon: (x, y)) és a Vector (eltolásvektor: (dx, dy)) típusszinonimákat,
-- mindkettő két Int értékből álló rendezett pár legyen.
-- (Az alábbi, konstruktorok nélküli data deklarációk csak helyőrzők, hogy a fájl betölthető legyen. Írjuk át őket!)
type Point = (Int, Int)
type Vector = (Int, Int)

-- Definiáljuk az origót.
origin :: Point
origin = (0, 0)

-- Definiáljuk azt a függvényt, amely egy pontot eltol egy vektorral.
-- Pl. move (1,2) (3,-1) == (4,1)
move :: Point -> Vector -> Point
move (x, y) (v1, v2) = (x + v1, y + v2) 

-- Definiáljuk azt a függvényt, amely megadja az első pontból a másodikba mutató vektort.
-- Pl. vectorBetween (1,2) (4,0) == (3,-2)
vectorBetween :: Point -> Point -> Vector
vectorBetween (x1, y1) (x2, y2) = (x2 - x1, y2 - y1)

-- Definiáljuk azt a függvényt, amely két pont távolságát adja meg.
-- Segítség: sqrt :: Double -> Double, az Int értékeket a fromIntegral függvénnyel alakíthatjuk át.
-- Pl. distance (0,0) (3,4) == 5.0
distance :: Point -> Point -> Double
distance (x1, y1) (x2, y2) = sqrt (fromIntegral ((x2 - x1) ^ 2 + (y2 - y1) ^ 2))

{-
A szinonimák korlátai:
Próbáljuk ki GHCi-ben:
  move (1,2) (3,4)
  move origin origin        -- az origó itt eltolásvektor?!
  vectorBetween (1,2) (3,4) -- az eredmény Vector, mégis használhatjuk Point-ként

Mindegyik lefut: a fordító nem tesz különbséget a Point és a Vector között, mindkettő csak (Int, Int).
Ha véletlenül felcseréljük a paramétereket, a fordító nem tud szólni.

Próbáljunk meg így síkbeli alakzatokat leírni:
-}

type Radius = Double

type CircleTuple = (Point, Radius)   -- középpont, sugár
type SquareTuple = (Point, Double)   -- középpont, oldalhossz

-- Definiáljuk a kör és a négyzet területét megadó függvényeket.
-- Pl. circleArea ((0,0), 1) == pi
--     squareArea ((0,0), 3) == 9.0
circleArea :: CircleTuple -> Double
circleArea (_, radius) = radius ^ 2 * pi 

squareArea :: SquareTuple -> Double
squareArea (_, sideLength) = sideLength ^ 2

{-
  circleArea ((0,0), 2)   -- ez most kör volt vagy négyzet? A fordítónak mindegy, mindkettő ((Int, Int), Double).

További gondok:
  - Egy téglalap már ((Int, Int), Double, Double) lenne, így nem tehetnénk egy listába a körökkel és a négyzetekkel.
  - Tehetnénk mellé címkét: ("circle", (0,0), 5), de akkor minden alakzatnak ugyanannyi mezője kellene legyen,
    és egy elgépelt címkét ("cirlce") sem venne észre a fordító.

Megoldás: definiáljunk saját típust!
-}

----------------------------------
-- Algebrai adattípusok
----------------------------------
{-
  data Shape = Circle Point Double | Square Point Double | Rectangle Point Double Double

  data      : új típust vezetünk be
  Shape     : az új típus neve (nagy kezdőbetűvel)
  =         : utána következnek a típus értékeit előállító adatkonstruktorok
  Circle    : adatkonstruktor (nagy kezdőbetűvel), utána a mezőinek típusai: középpont és sugár
  |         : "vagy": elválasztja a konstruktorokat
  Square    : középpont és oldalhossz
  Rectangle : középpont és a két oldal hossza

FONTOS: a típus nevét és az adatkonstruktorokat is nagy kezdőbetűvel kell írni.

Két egyszerűbb esetből épül fel:
  - Összeg típus (felsorolás): több konstruktor, mezők nélkül.                 data Bool = False | True
  - Szorzat típus: egy konstruktor, több mezővel (mint egy rendezett n-es).   data Pair = P Int Int
Az "algebrai" elnevezés is innen jön: összegek és szorzatok kombinálásával építjük fel a típusokat.
-}

----------------------------------
-- Összeg típus (felsorolási típus)
----------------------------------
{-
Az összeg típusnál felsoroljuk az új típus összes lehetséges értékét. A Bool is így van definiálva:
  data Bool = False | True

Az ilyen típusú értékeket ugyanúgy mintaillesztéssel vizsgáljuk, ahogy a True és False esetén is tettük.
-}

-- Definiáljuk az Answer típust, amelynek három lehetséges értéke van: No, Maybe és Yes.
data Answer = No | Maybe | Yes
  deriving (Show, Eq)

-- Definiáljuk azt a függvényt, amely szöveggé alakítja a válaszokat.
-- Pl. toString No == "No"
toString :: Answer -> String
toString No = "No"
toString Maybe = "Maybe"
toString Yes = "Yes"

-- Definiáljuk azt a függvényt, amely megfordítja a választ: az igenből nem lesz, a nemből igen, a talán marad.
-- Pl. toString (opposite Yes) == "No"
--     toString (opposite Maybe) == "Maybe"
opposite :: Answer -> Answer
opposite Yes = No
opposite No  = Yes
opposite x   = x

----------------------------------
-- Összetett típusok: alakzatok
----------------------------------
{-
Az összeg és a szorzat kombinálható: több konstruktor, mindegyiknek saját mezőkkel.
A mezők típusa bármi lehet, akár egy korábban megadott típusszinonima is (Point).
-}

-- Definiáljuk a Shape típust a fent látott három konstruktorral: Circle, Square és Rectangle.
data Shape = Circle Point Radius | Square Point Double | Rectangle Point Double Double
  deriving (Show, Eq)

-- Definiáljuk azt a függvényt, amely megadja egy alakzat területét.
-- Pl. shapeArea (Circle (0,0) 1) == pi
--     shapeArea (Square (2,2) 3) == 9.0
--     shapeArea (Rectangle (1,1) 2 3) == 6.0
shapeArea :: Shape -> Double
shapeArea (Circle _ radius)     = radius ^ 2 * pi
shapeArea (Square _ sideLength) = sideLength ^ 2 
shapeArea (Rectangle _ a b)     = a * b

-- Definiáljuk azt a függvényt, amely megadja egy alakzat kerületét.
-- Pl. perimeter (Circle (0,0) 1) == 2 * pi
--     perimeter (Square (2,2) 3) == 12.0
--     perimeter (Rectangle (1,1) 2 3) == 10.0
perimeter :: Shape -> Double
perimeter (Circle _ radius)     = 2 * radius * pi 
perimeter (Square _ sideLength) = 4 * sideLength
perimeter (Rectangle _ a b)     = 2 * (a + b)

-- Definiáljuk azt a függvényt, amely megadja egy alakzatok listájának összterületét.
-- Most már egy listába tehetjük a különböző alakzatokat, hiszen mindegyik Shape típusú!
-- Pl. totalArea [Square (0,0) 2, Rectangle (5,5) 1 3] == 7.0
--     totalArea [Circle (0,0) 1, Square (0,0) 2]      -- kb. 7.14
totalArea :: [Shape] -> Double
totalArea [] = 0.0
totalArea (shape:shapes) = shapeArea shape + totalArea shapes

totalAreaLC :: [Shape] -> Double
totalAreaLC shapes = sum [shapeArea shape | shape <- shapes]

-- Definiáljuk azt a függvényt, amely megadja egy alakzat középpontját.
-- Pl. center (Rectangle (1,2) 3 4) == (1,2)
center :: Shape -> Point
center (Circle point _ ) = point
center (Rectangle point _ _) = point
center (Square point _) = point

-- Definiáljuk azt a függvényt, amely egy alakzatot eltol a megadott vektorral. Használjuk a move függvényt!
-- Pl. moveShape (1,1) (Circle (0,0) 2)  -- az eredmény: Circle (1,1) 2.0
moveShape :: Vector -> Shape -> Shape
moveShape vector (Circle point radius) = (Circle (move vector point) radius)
moveShape vector (Rectangle point a b) = (Rectangle (move vector point) a b)
moveShape vector (Square point a)      = (Square (move vector point) a)

----------------------------------
-- Típusosztályok
----------------------------------
{-
Próbáljuk ki GHCi-ben a moveShape függvényt:

  ghci> moveShape (1,1) (Circle (0,0) 2)
  <interactive>: error:
      • No instance for (Show Shape) arising from a use of ‘print’

Mi a gond? Az interpreternek szöveggé kell alakítania az eredményt, hogy kiírja. A Shape egy vadonatúj típus,
a mintaillesztésen kívül semmilyen művelet nem ismert rá: sem kiírni, sem összehasonlítani nem tudjuk.

Már találkoztunk ilyen megszorításokkal a függvények típusában:
  elem' :: Eq a => a -> [a] -> Bool
  sum'  :: Num a => [a] -> a

A típusosztály műveletek egy csoportja, amelyet több típusra is megadhatunk, mindegyikre a saját módján.
Például az Eq osztály (GHCi-ben: :i Eq):

  class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
    {-# MINIMAL (==) | (/=) #-}

  class     : kulcsszó, típusosztályt definiálunk
  Eq        : az osztály neve, ezzel hivatkozunk rá a megszorításokban
  a         : típusváltozó, a konkrét típus helyére kerül
  MINIMAL   : mit kell legalább megadni egy példányhoz. Itt elég az egyiket, a másik a tagadásával kifejezhető.

Egy típus akkor tagja az osztálynak, ha van rá példánya (instance): instance Eq Int, instance Eq Bool, ...
A (==) így túlterhelt: ugyanaz a név több típusra, típusonként más megvalósítással.
Az Eq a => megszorítás azt jelenti: "bármilyen a típus, amelyre van Eq példány".

A számokhoz tartozó osztályokat most nem részletezzük, csak érdemes tudni, hogy egymásra épülnek:
  Num        : +, -, *, abs, ...                   példányai: Int, Integer, Double, Float
  Integral   : div, mod, ...         (Num-ra épül)        példányai: Int, Integer
  Fractional : /, ...                (Num-ra épül)        példányai: Double, Float
  Floating   : sqrt, pi, sin, ...    (Fractional-re épül) példányai: Double, Float
Ezért kellett a fromIntegral a distance függvényben: az Int nem tagja a Floating osztálynak, nincs rá sqrt.

Mi most négy osztállyal foglalkozunk:
  Show : szöveggé alakítás (show), ez kell az interpreterben a kiíráshoz
  Eq   : (==), (/=)
  Ord  : <, <=, >, >=, min, max, ...   Az Eq-ra épül: class Eq a => Ord a where ...
  Enum : succ, pred, pont-pont kifejezések: [x .. y]

Két lehetőségünk van arra, hogy a saját típusunkra példányt adjunk:
  1. megkérjük a fordítót, hogy készítsen egyet (deriving),
  2. magunk írjuk meg (instance).
-}

----------------------------------
-- Automatikus példányosítás: deriving
----------------------------------
{-
  data Answer = No | Maybe | Yes
    deriving (Show, Eq)

A deriving kulcsszó után zárójelben felsoroljuk, mely osztályokra kérünk példányt a fordítótól.
A fordító által készített példányok:
  Show : a konstruktor neve és a mezők, ahogy a kódban leírnánk:  show (P 3 4) == "P 3 4"
  Eq   : két érték egyenlő, ha ugyanaz a konstruktor, és a mezők páronként egyenlők
  Ord  : a konstruktorok a megadás sorrendjében növekednek; azonos konstruktornál a mezőket balról jobbra hasonlítja
  Enum : a konstruktorok sorszámozása (csak mezők nélküli konstruktorokra): succ, pred, [Mon ..]

Feladat:
  1. Egészítsük ki a Shape típust úgy, hogy a moveShape eredménye kiírható legyen!
  2. Próbáljuk ki: moveShape (1,1) (Circle (0,0) 2) == Circle (1,1) 2
     Milyen hibát kapunk? Mit kell még a deriving listába tenni?
  3. Most már válaszolhatunk az opposite-nál feltett kérdésre is: egészítsük ki az Answer típust,
     hogy az opposite Yes == No kifejezés kiértékelhető legyen.
-}

-- Feladat: Hét napjai
-- Definiáljuk a Day típust, amely a hét napjait reprezentálja. Konstruktorai: Mon, Tue, Wed, Thu, Fri, Sat, Sun
-- Kérjük a Show példányt a fordítótól. A többi osztályt akkor vegyük fel, amikor szükség lesz rá!
-- (A konstruktorok nélküli data Day csak helyőrző, hogy a fájl betölthető legyen. Írjuk át!)
data Day = Mon | Tue | Wed | Thu | Fri | Sat | Sun
  deriving (Eq, Show, Ord, Enum)

-- Definiáljuk azt a függvényt, amely eldönti egy napról, hogy hétvége-e. Használjunk mintaillesztést!
-- Pl. isWeekend Sat
--     not (isWeekend Mon)
isWeekend :: Day -> Bool
isWeekend = undefined

-- Definiáljuk azt a függvényt, amely megadja a következő napot. Használjunk mintaillesztést!
-- A teszteléshez össze kell hasonlítanunk a napokat: mit kell ehhez a deriving listába tenni?
-- Pl. tomorrow Mon == Tue
--     tomorrow Sun == Mon
tomorrow :: Day -> Day
tomorrow = undefined

-- Kérjünk Enum példányt is a Day típusra, és próbáljuk ki GHCi-ben:
--   succ Mon
--   pred Fri
--   [Mon ..]
--   [Mon, Wed ..]
--   succ Sun        <- mit kapunk és miért?

-- Definiáljuk újra a következő napot megadó függvényt, de most használjuk a succ függvényt!
-- A vasárnapot mintaillesztéssel emeljük ki, mint speciális esetet.
-- Pl. betterTomorrow Mon == Tue
--     betterTomorrow Sun == Mon
betterTomorrow :: Day -> Day
betterTomorrow = undefined

-- Definiáljuk az előző napot megadó függvényt hasonlóan, a pred segítségével.
-- Pl. yesterday Tue == Mon
--     yesterday Mon == Sun
yesterday :: Day -> Day
yesterday = undefined

-- Definiáljuk a munkanapok listáját pont-pont kifejezéssel.
-- Pl. weekdays == [Mon,Tue,Wed,Thu,Fri]
weekdays :: [Day]
weekdays = undefined

-- Kérjünk Ord példányt is a Day típusra. Ekkor a napok a megadás sorrendjében rendezettek: Mon < Tue < ... < Sun
-- Definiáljuk újra a hétvége vizsgálatot, de most mintaillesztés helyett egy összehasonlítással!
-- Pl. isWeekend' Sat
--     not (isWeekend' Fri)
isWeekend' :: Day -> Bool
isWeekend' = undefined

-- Definiáljuk azt a függvényt, amely egy napok listájából csak a munkanapokat tartja meg.
-- Pl. workdays [Wed,Mon,Sat,Sun,Tue] == [Wed,Mon,Tue]
workdays :: [Day] -> [Day]
workdays = undefined

-- Feladat: Égtájak
-- Definiáljuk a CardinalPoint típust a fő égtájakkal: North, East, South, West (ebben a sorrendben).
-- Kérjünk rá Show és Eq példányt, a többit vegyük fel, ha szükség lesz rá.
data CardinalPoint

-- Definiáljuk a 90 fokos balra fordulást mintaillesztéssel.
-- Pl. turnLeft North == West
--     turnLeft East  == North
turnLeft :: CardinalPoint -> CardinalPoint
turnLeft = undefined

-- Definiáljuk a 90 fokos jobbra fordulást. Most használjuk ki az Enum példányt (succ)!
-- Pl. turnRight North == East
--     turnRight West  == North
turnRight :: CardinalPoint -> CardinalPoint
turnRight = undefined

-- Definiáljuk a 180 fokos fordulást a korábbi függvények felhasználásával.
-- Pl. turnBack North == South
--     turnBack East  == West
turnBack :: CardinalPoint -> CardinalPoint
turnBack = undefined

-- Definiáljuk azt a függvényt, amely megszámolja, hányszor szerepel egy adott irány egy listában.
-- Pl. numOfDirection North [North,South,East,North] == 2
--     numOfDirection West [] == 0
numOfDirection :: CardinalPoint -> [CardinalPoint] -> Integer
numOfDirection = undefined

-- Figyeljük meg: a numOfDirection definíciója a CardinalPoint típusból semmit sem használt ki, csak az (==) műveletet.
-- Általánosítsuk tetszőleges típusra, amelyre van Eq példány!
-- Pl. count North [North,South,East,North] == 2
--     count 'a' "almafa" == 3
--     count Sat [Mon,Sat,Sun,Sat] == 2
count :: Eq a => a -> [a] -> Integer
count = undefined

----------------------------------
-- Saját példány: Eq
----------------------------------
{-
A fordító által készített Eq példány szerint:
  Square (0,0) 2 == Rectangle (0,0) 2 2   -- False
Pedig ez ugyanaz az alakzat! A generált példány csak a konstruktorokat és a mezőket hasonlítja,
azt nem tudhatja, hogy mit jelentenek. Ilyenkor magunknak kell megadnunk a példányt:

  instance Eq Shape where
    Circle p r == Circle q s = ...
    ...

  instance  : kulcsszó, példányt adunk meg
  Eq        : melyik osztálynak
  Shape     : melyik típusra
  where     : utána következnek (beljebb húzva!) az osztály műveleteinek definíciói

Az operátort prefix alakban is definiálhatjuk: (==) (Circle p r) (Circle q s) = ...
Elég az (==)-t megadni, a (/=) ebből már adódik (lásd MINIMAL).

FONTOS: egy típusnak egy osztályra csak egy példánya lehet! Ha a deriving listában szerepel az Eq,
akkor onnan előbb ki kell venni, különben a fordító "Duplicate instance declarations" hibát ad.
-}

-- Feladat: Vegyük ki az Eq-t a Shape deriving listájából, és adjunk meg saját példányt!
-- Egy négyzet egyezzen meg a vele azonos középpontú és oldalhosszú téglalappal.
-- Segítség: ha valamelyik oldalon négyzet áll, cseréljük le a megfelelő téglalapra és hasonlítsunk újra.
-- Pl. Square (0,0) 2 == Rectangle (0,0) 2 2
--     Rectangle (0,0) 2 2 == Square (0,0) 2
--     Circle (0,0) 1 == Circle (0,0) 1
--     Circle (0,0) 1 /= Square (0,0) 1
--     Square (0,0) 2 /= Rectangle (0,0) 2 3
{-
instance Eq Shape where
  (==) = undefined
-}

-- Gondoljuk meg: legyen-e egyenlő a Rectangle (0,0) 2 3 és a Rectangle (0,0) 3 2? Ha igen, hogyan módosítanánk a példányt?

----------------------------------
-- Saját példány: Show
----------------------------------

-- Feladat: Amerikai idő
-- Definiáljuk a USTime típust két konstruktorral: AM és PM (délelőtt és délután).
-- Mindkettőnek két Int mezője van: az óra (1-12) és a perc (0-59). Kérjünk rá Show és Eq példányt.
-- Pl. show (AM 3 45) == "AM 3 45"
--     AM 10 42 == AM 10 42
--     AM 10 32 /= AM 10 42
--     PM 12 20 /= AM 12 20
data USTime

{-
Kérdezzük le a konstruktorok típusát:
  :t AM
  :t AM 10
Próbáljuk ki: [AM 10 m | m <- [0, 15 .. 45]]

A generált "AM 3 45" nem túl olvasható. Szeretnénk, ha az interpreter "03.45 am" formában írná ki.
A Show osztálynál elég a show függvényt megadni (MINIMAL showsPrec | show).
-}

-- Először definiáljunk egy segédfüggvényt, amely egy nemnegatív számot két számjegyre egészít ki balról 0-val.
-- Segítség: a szám szöveggé alakításához használjuk a show függvényt.
-- Pl. twoDigits 5 == "05"
--     twoDigits 42 == "42"
twoDigits :: Int -> String
twoDigits = undefined

-- Feladat: Vegyük ki a Show-t a USTime deriving listájából, és adjunk meg saját példányt az alábbi formátummal.
-- Pl. show (AM 9 15) == "09.15 am"
--     show (PM 12 6) == "12.06 pm"
--     show (PM 2 9)  == "02.09 pm"
-- Próbáljuk ki GHCi-ben azt is: [AM 9 15, PM 2 9]  -- a listák kiírása is a mi példányunkat használja
{-
instance Show USTime where
  show = undefined
-}

----------------------------------
-- Saját példány: Ord
----------------------------------
{-
Mi lenne, ha az Ord példányt is a fordítótól kérnénk?
  - AM < PM, mert az AM konstruktort adtuk meg előbb. Ez rendben van.
  - Azonos konstruktornál az órákat hasonlítaná: AM 12 30 > AM 1 0, pedig éjjel fél egy korábban van, mint egy óra!
A 12 óra mindkét napszakban a legkorábbi, ezt a generált példány nem tudhatja. Saját példány kell.

Az Ord osztálynál elég a (<=) vagy a compare műveletet megadni (MINIMAL compare | (<=)),
a többit (<, >, >=, min, max) a fordító ebből származtatja.
Az Ord az Eq-ra épül (class Eq a => Ord a), ezért az Ord példányhoz Eq példány is kell. Az Eq maradhat deriving.
-}

-- Definiáljuk azt a függvényt, amely megadja, hány perc telt el éjfél óta.
-- Pl. minutesSinceMidnight (AM 12 0)  == 0
--     minutesSinceMidnight (AM 1 30)  == 90
--     minutesSinceMidnight (PM 12 15) == 735
--     minutesSinceMidnight (PM 11 59) == 1439
minutesSinceMidnight :: USTime -> Int
minutesSinceMidnight = undefined

-- Feladat: Adjunk meg saját Ord példányt a USTime típusra a minutesSinceMidnight segítségével!
-- Figyelem: a definíció jobb oldalán szereplő (<=) már Int értékeket hasonlít. Ez nem rekurzió,
-- hanem az Int típus példányának hívása (hiszen az összehasonlítás túlterhelt).
-- Pl. AM 12 0 <= AM 1 0
--     PM 12 59 < PM 1 0
--     AM 11 59 < PM 12 0
--     max (AM 3 0) (PM 12 30) == PM 12 30
--     maximum [AM 3 0, PM 12 30, AM 12 0, PM 1 15] == PM 1 15
{-
instance Ord USTime where
  (<=) = undefined
-}

----------------------------------
-- További gyakorló feladatok
----------------------------------

-- Feladat: 24 órás idő
-- Definiáljuk a Time típust egyetlen konstruktorral: T :: Int -> Int -> Time (óra 0-23, perc 0-59).
-- Kérjünk rá Show és Eq példányt.
-- Pl. show (T 19 28) == "T 19 28"
data Time

-- Definiáljuk azt a függvényt, amely egy 24 órás időpontot amerikai időpontra alakít.
-- A 12 óra 0 perc már délutánnak számít.
-- Pl. time2USTime (T 8 10)  == AM 8 10
--     time2USTime (T 12 0)  == PM 12 0
--     time2USTime (T 18 21) == PM 6 21
--     time2USTime (T 0 0)   == AM 12 0
--     time2USTime (T 11 59) == AM 11 59
time2USTime :: Time -> USTime
time2USTime = undefined

-- Definiáljuk azt a függvényt, amely egy amerikai időpontot 24 órás időpontra alakít.
-- Pl. uSTime2Time (AM 1 0)   == T 1 0
--     uSTime2Time (AM 12 30) == T 0 30
--     uSTime2Time (PM 12 0)  == T 12 0
--     uSTime2Time (PM 1 43)  == T 13 43
--     uSTime2Time (PM 11 43) == T 23 43
uSTime2Time :: USTime -> Time
uSTime2Time = undefined

-- Feladat: Racionális számok
-- Definiáljuk a MyRational típust egyetlen R konstruktorral, amelynek két Integer mezője van: a számláló és a nevező.
-- Kérjünk rá Show és Eq példányt.
-- R :: Integer -> Integer -> MyRational
data MyRational

-- Definiáljuk két racionális szám összegét. Egyelőre ne foglalkozzunk az egyszerűsítéssel.
-- Pl. simpleAdd (R 1 2) (R 1 2) == R 4 4
--     simpleAdd (R 1 3) (R 1 2) == R 5 6
--     simpleAdd (R 1 30) (R 10 2) == R 302 60
simpleAdd :: MyRational -> MyRational -> MyRational
simpleAdd = undefined

-- Definiáljuk két racionális szám szorzatát. Egyelőre ne foglalkozzunk az egyszerűsítéssel.
-- Pl. simpleMult (R 1 2) (R 3 4) == R 3 8
--     simpleMult (R 4 21) (R 5 30) == R 20 630
simpleMult :: MyRational -> MyRational -> MyRational
simpleMult = undefined

-- Definiáljuk két egész szám legnagyobb közös osztóját (Prelude: gcd). Negatív számokra is működjön!
-- Segítség:
--   - Adjunk meg egy segédfüggvényt, amely két nemnegatív számra határozza meg a legnagyobb közös osztót.
--     Ha az egyik szám 0, a másik az eredmény. Különben a nagyobbat cseréljük le a nagyobb és a kisebb
--     osztási maradékára, és ismételjük.
--   - A myGCD az abs függvénnyel alakítsa nemnegatívvá a paramétereket, és hívja a segédfüggvényt.
-- Pl. myGCD 0 0 == 0
--     myGCD 0 3 == 3
--     myGCD 10 4 == 2
--     myGCD 13 17 == 1
--     myGCD (-10) 2 == 2
--     myGCD (-16) (-48) == 16
myGCD :: Integer -> Integer -> Integer
myGCD = undefined

-- Definiáljuk azt a függvényt, amely egyszerűsíti a törtet (osszunk a számláló és a nevező legnagyobb közös osztójával).
-- Pl. normalize (R 4 4) == R 1 1
--     normalize (R 24 8) == R 3 1
--     normalize (R 0 12) == R 0 1
normalize :: MyRational -> MyRational
normalize = undefined

-- Definiáljuk az összeadást és a szorzást úgy, hogy az eredmény egyszerűsített legyen.
-- Pl. add (R 1 2) (R 1 2) == R 1 1
--     add (R 1 2) (R 1 6) == R 2 3
--     add (R 4 2) (R 4 4) == R 3 1
--     mult (R 1 2) (R 4 6) == R 1 3
--     mult (R 10 23) (R 4 6) == R 20 69
add :: MyRational -> MyRational -> MyRational
add = undefined

mult :: MyRational -> MyRational -> MyRational
mult = undefined

-- Feladat: Próbáljuk ki: R 2 4 == R 1 2
-- A generált Eq példány szerint ez hamis, pedig ugyanazt a számot jelöli.
-- Vegyük ki az Eq-t a deriving listából, és adjunk meg saját példányt!
-- Pl. R 4 4 == R 1 1
--     R 2 4 == R 1 2
--     R 0 12 == R 0 1
--     R 1 2 /= R 1 3
{-
instance Eq MyRational where
  (==) = undefined
-}

-- Feladat: Adjunk meg saját Show példányt is, amely törtként írja ki a számot.
-- Pl. show (R 1 2) == "1/2"
--     show (R 4 8) == "4/8"
{-
instance Show MyRational where
  show = undefined
-}

-- Feladat: Adjunk meg Ord példányt a MyRational típusra! Feltehetjük, hogy a nevezők pozitívak.
-- Segítség: a/b <= c/d pontosan akkor, ha a*d <= c*b (pozitív nevezők esetén).
-- Pl. R 1 3 < R 1 2
--     R 2 4 <= R 1 2
--     maximum [R 1 2, R 2 3, R 3 5] == R 2 3
{-
instance Ord MyRational where
  (<=) = undefined
-}

-- +1 Gondoljuk meg: hogyan módosítanánk a normalize függvényt, hogy az előjel mindig a számlálóba kerüljön?
-- Ekkor az alábbiak is igazak lesznek:
--     R 4 (-4) == R (-1) 1
--     R (-2) (-4) == R 1 2
--     R (-4) 8 == R 2 (-4)
--     R 0 (-12) == R 0 1
