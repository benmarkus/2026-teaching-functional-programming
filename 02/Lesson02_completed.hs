module GY02 where
import Prelude hiding (not, (&&), (||))

------------------------------------
-- Gyakorlás
------------------------------------

-- Definiáld azt a paraméter nélküli függvényt, aminek a visszatérési
-- értéke Integer, és mindig 4-et ad vissza.
four :: Integer 
four = 4

-- Definiáld azt a paraméter nélküli függvényt, ami egy Bool-t ad vissza
-- és mindig igaz, add meg a típusszignatúráját is.
true' :: Bool
true' = True

-- Definiáld azt a függvényt, ami összead két Integert
sumOfIntegers :: Integer -> Integer -> Integer
sumOfIntegers x y = x + y  

-- Definiáld azt a függvényt, ami megszoroz két Integert
-- és add meg a típusszignatúráját is.
productOfIntegers :: Integer -> Integer -> Integer
productOfIntegers x y = x * y

-- Definiáld azt a függvényt, ami kiszámolja két Float átlagát
averageOfTwoFloats :: Float -> Float -> Float
averageOfTwoFloats x y = (x + y) / 2

------------------------------------
-- Explicit típuskonverzió
------------------------------------

one :: Int
one = 1

three :: Integer
three = 3

{-
Ez már ismerős lehet, múltkor megbeszéltük, hogy ez nem lehetséges Haskellben, mivel nem engedi meg a típusok közötti IMPLICIT konverziót. Teljesen más a helyzet, ha EXPLICIT módon tesszük ezt.

Számoknál pontos átalakítására két függvény alkalmas, a szignatúra még csúnyának fog tűnni, de később megértjük ezt is majd):


fromIntegral :: (Integral a, Num b) => a -> b
Megkap valamilyen számot, és egész számmá alakítja (Int, Integer).

realToFrac :: (Real a, Fractional b) => a -> b
Megkap valamilyen "valós" számot, és Float-ot vagy Double-t csinál belőle

Int -> Integer    : fromIntegral
Integer -> Double : realToFrac, fromIntegral
Float -> Double   : realToFrac

Viszont:
Double -> Integer : egyik se, viszont tudunk kerekíteni

floor :: (RealFrac a, Integral b) => a -> b
ceiling :: (RealFrac a, Integral b) => a -> b
truncate :: (RealFrac a, Integral b) => a -> b
round :: (RealFrac a, Integral b) => a -> b

truncate: a törtrész elhagyása (pl.: truncate 2.5 == 2)
round: ezzel vigyázni, nem mindig úgy kerekít, ahogy várnánk tőle (pl.: round 2.5)
-}

-- Konvertáljuk a one és three függvények összegét minden
-- ismert számtípusra.
fourInt :: Int
fourInt = one + fromIntegral three

fourInteger :: Integer
fourInteger = fromIntegral one + three

fourFloat :: Float
fourFloat = realToFrac one + realToFrac three

fourDouble :: Double
fourDouble = realToFrac one + realToFrac three

----------------------------------------
-- Mintaillesztés
----------------------------------------

-- Definiáljuk újra a Boolean NOT műveletet (logikai tagadás)
not :: Bool -> Bool
not True = False
not False = True

-- Definiáljuk újra a Boolean OR műveletet (logikai VAGY)
(||) :: Bool -> Bool -> Bool
(||) True _ = True
(||) False x = x

-- Definiáljuk újra a Boolean AND műveletet (logikai ÉS)
(&&) :: Bool -> Bool -> Bool
(&&) True True = True
(&&) _ _ = False
{-
A mintaillesztés a funkcionális programozás egyik leghasznosabb, leghasználtabb és leggyakoribb eszköze.

A mintaillesztés lényegében úgy néz ki, hogy amikor a függvényt definiáljuk, akkor a paraméter helyére konkrét értéket írunk és utána definiáljuk, hogy mi legyen a függvény eredménye.

FONTOS! A minta illeszkedésének ellenőrzése FENTRŐL LEFELÉ sorrendben történik, ha egy feljebb és lentebb is elhelyezett minta is illeszkedik, akkor mindig a fenti kerül kiértékelésre.
-}

-- Definiáljuk a fent definiált || és && TriBool-os változatát (3 bemeneti értékről dönti el az igazságértéket)
(|||) :: Bool -> Bool -> Bool -> Bool
(|||) False False False = False
(|||) _ _ _    = True

(&&&) :: Bool -> Bool -> Bool -> Bool
(&&&) True True True = True
(&&&) _ _ _    = False

{-
Elég fárasztó egyesével gépelni, nem?
Szerencsére létezik egy megoldás erre. Használkuk a "wildcard" operátort: _

Ez lényegében azt szimbolizálja, hogy ott bármi lehet, arra illeni fog a mintaillesztés.
Amikor wildcardot használunk nagyon észnél kell lenni! Nézzük meg mi történik, ha a fenti (|||) definícióban megcseréljük a két sort.

Ha később fel akarjuk használni az adott értéket, akkor nem tehetünk wildcardot!

Általános szabály: a legszűkebb mintával próbáljuk kezdeni.
-}

{-
######ÉRDEKESSÉG######
Nézzük meg, hogy mi történik, ha kiértékeljük az alábbiakat ebben a sorrendben:
-- 1 `div` 0
-- 1 `div` 0 == 0
-- 1 `div` 0 == 0 && 1 == 0

Tippelés: Mi fog történni az alábbi esetben?
-- 1 == 0 && 1 `div` 0 == 0

Nézzük meg, hogy a fent definiált függvényekkel mi fog történni!
Definiáljuk az egyik logikai műveletet az "összes értelmes" lehetséges módon és azokkal is nézzük meg, hogy mi történik!

A fentiekből megállapítható, hogy valamikor kivételt kapunk, valamikor nem. Ha jobban odafigyelünk, akkor kideríthető egyértelműen, hogy mely esetekben kapunk kivételt és mikor nem.
Észrevehetjük, hogy ha nem muszáj, akkor Haskell nem értékel ki feleslegesen kifejezéseket. Ezt a kiértékelési stratégiát hívjuk LUSTA kiértékelésnek.

Mohó kiértékelés: Olyan kiértékelési módszer, amely során egy kifejezés minden része kiértékelésre kerül az eredmény kiszámítása előtt.
-- Pl.
-- Legyen f a b = 2 * a + b; g y = y + 2
-- f (g 3) (g 2) levezetése a következő lesz mohó módszerrel:
   f (g 3) (g 2)
 → f (3 + 2) (g 2)
 → f 5 (g 2)
 → f 5 (2 + 2)
 → f 5 4
 → 2 * 5 + 4 → 10 + 4 → 14

Lusta kiértékelés: Olyan kiértékelési módszer, amely során egy kifejezés csak akkor értékelődik ki, ha muszáj.
-- Pl.
-- Legyen f a b = 2 * a + b; g y = y + 2
-- f (g 3) (g 2) levezetése a következő lesz lusta módszerrel:
   f (g 3) (g 2)
 → 2 * g 3 + g 2
 → 2 * (3 + 2) + g 2
 → 2 * 5 + g 2
 → 10 + g 2
 → 10 + (2 + 2)
 → 10 + 4
 → 14

-- Az alábbi példában előjön a lustaság szerepe; ha az alábbi kifejezést mohón értékeljük ki:
   1 == 0 && (3 == 3 && 1 `div` 0 == 1)
 → False && (3 == 3 && 1 `div` 0 == 1)
 → False && (True && 1 `div` 0 == 1)
 → ...               ^^^^^^^^^^^^^^ 0-val való osztás kivétel.

-- Ha azonban lustán értékeljük ki:
   1 == 0 && (3 == 3 && 1 `div` 0 == 1)
 → False && (3 == 3 && 1 `div` 0 == 1)
 → False
A lustaság miatt a kifejezés maradék részére rá se kell nézni, az (&&) definíciója miatt ha tudjuk, hogy az első paraméter False, akkor az eredmény is az mindenképpen.

######################
-}

------------------------------------
-- Char
------------------------------------

{-
Pontosan úgy működik, ahogy számitanánk rá. Haskellben ' ' közé kerül (nem lehet " "-et használni Char-ra).
Vannak speciális karakterek, amik "több" karakterből állnak, ezek a következők:

'\n'
'\''
'\\'
'\NUL'
'\ESC'
'\t'
-}


-- Definiáljuk azt a függvényt, ami eldönti egy karakterről, hogy kis vagy nagy 'A' betű
isA :: Char -> Bool
isA 'a' = True
isA 'A' = True
isA _ = False

-- Definiáljuk azt a függvényt, ami eldönti egy karakterről, hogy sortörés-e
isNewLine :: Char -> Bool
isNewLine '\n' = True
isNewLine _ = False

-- Definiáljuk azt a függvényt, ami kicseréli a szóközt egy sortörésre (vice versa), minden mást megtart

swapSpaceWithNewline :: Char -> Char
swapSpaceWithNewline ' ' = '\n'
swapSpaceWithNewline '\n' = ' '
swapSpaceWithNewline x = x
