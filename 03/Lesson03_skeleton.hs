module GY03 where
import Prelude hiding ((^))
------------------------------------
-- Gyakorlás
------------------------------------

-- Definiáljuk azt a fv-t, ami megcseréli a @ és # jeleket, minden mást nem változtat
-- A megoldás mellé add meg a függvény típusszignatúráját is!
switchAtSignWithHashtag = undefined

-- Definiáljuk mintaillesztéssel azt a függvényt, amely a 3. Bool paraméter megfordítottját adja vissza, ha az első 2 Bool paraméter megegyezik, más esetben változatlanul adjuk vissza a 3. paramétert
flipThirdIfFirstTwoAreSame :: Bool -> Bool -> Bool -> Bool
flipThirdIfFirstTwoAreSame = undefined

-- A klasszikus matematikai logikai műveletek segítségével (not, ||, &&) állítsuk elő az implikáció (⟹)-t leíró fv-t
-- A megoldás mellé add meg a függvény típusszignatúráját is!
implies = undefined

-- Tegyük meg ugyanezt most a klasszikus mat. logikai műveletek NÉLKÜL, mintaillesztést használva
-- A megoldás mellé add meg a függvény típusszignatúráját is!
implies' = undefined

-- Definiáljuk azt a fv-t, ami eldönti egy Int-ről, hogy páros-e (hint: használjuk az osztási maradék (mod) prefix függvényt infix módon)
isEven :: Integer -> Bool
isEven = undefined

-- Definiáljuk a művelet párját is, tetszőleges módon
isOdd :: Integer -> Bool
isOdd = undefined

-- Definiáljuk azt a fv-t, ami eldönti, hogy az első paraméter (pozitív) osztója-e a másodiknak
-- A megoldás mellé add meg a függvény típusszignatúráját is!
divides = undefined

----------------------------------
-- Guardok (őrjelek)
----------------------------------
{-
Megtanultunk mintailleszteni Char-okra és Bool-okra. Picit gondolkodjunk ezeknek a típusoknak a számosságán (multiplicitásán):
A Bool-ra nagyon könnyen tudtunk mintát illeszteni, hiszen kétféle értéket vehet fel.
A Char-nál már egy picit összetettebb a helyzet, de még mindig véges számú lehetséges érték van.

Mi a helyzet a számoknál? Nézzük meg:
-}

-- Definiáljuk azt a fv-t, ami a 10-nél kisebb és -10-nél nagyobb egész számokra True-t ad vissza, minden másra False-t
isOneDigit :: Integer -> Bool
isOneDigit = undefined

-- Definiáljuk azt a fv-t, ami a 100-nál kisebb és -100-nál nagyobb egész számokra ad True-t, minden másra False-t
isLessThanHundred :: Integer -> Bool
isLessThanHundred = undefined

-- Ügyesen kihasználtuk a Bool műveletek tulajdonságait, de mitévők leszünk, ha nem Bool visszatérésű a fv?

-- Definiáljuk azt a fv-t, amit pozitív számokra értelmezünk (minden más esetben 'E'-t írjunk ki, mint "error"),
-- 1 - 9:       I
-- 10 - 99:     X
-- 100 - 999:   C
-- 1000 - 3999: M

romanOrderOfMagnitude :: Int -> Char
romanOrderOfMagnitude = undefined

-- A gyakorlórészben megírt divides függvényt fejlesztjük tovább,
-- most már csak a pozitív valódi osztókat fogadjuk el (tehát 1 és önmaga már False-t dobjon)
isRealPositiveDivisorOf :: Integer -> Integer -> Bool
isRealPositiveDivisorOf = undefined

{-
Használjuk egy új nyelvi elemet, a guard-ot (őrjel) az AltGr + W kombinációval elérhető | ("pipe") szimbólummal.
Ilyenkor nem tesszük ki az egyenlőségjelet azonnal, hanem új sorban egy tab-bal behúzva kezdjük a guardot.

A guardok nagyon hasznos eszközök, az ilyen típusú feladatoknál, kibővítik az értékre való mintaillesztés lehetőségeit.
Az alsó sorban szokás kitenni egy otherwise-t (ez igazából egy szinonímája a True-nak)
-}

-- Definiáljuk a klasszikus FizzBuzz fv-t guardok segítségével:
-- ha a szám osztható 15-tel: "FizzBuzz"
-- ha osztható 3-mal (de nem 15-tel): "Fizz"
-- ha osztható 5-tel (de nem 15-tel): "Buzz"
-- ha egyik eset sem teljesül, akkor üres string
fizzBuzz :: Integer -> String
fizzBuzz = undefined

-- Definiáljuk azt a fv-t, ami egy életkorhoz (Int) magyar nyelvű kategóriát rendel:
-- 0-2: "csecsemő", 3-12: "gyerek", 13-17: "tinédzser", 18-64: "felnőtt", 65+: "idős"
-- negatív számra "érvénytelen"
ageCategory :: Int -> String
ageCategory = undefined

----------------------------------
-- Rekurzió
----------------------------------
{-
A guardok megismerésével (majdnem*) teljesen elsajátítottuk az imperatív nyelven if-else-then vezérlőszerkezetként használt elágazás viselkedését. 

(*: a "case of" vezérlőszerkezet kimaradt, erről később, opcionálisan; 
viszont akit érdekel, megnézheti, viszont, ha használja számonkéréskor, akkor tudja is mit jelent!)

Viszont van rengeteg feladat, amit nem tudunk ciklusok nélkül megoldani. 
Ha végiggondoljuk elemi szinten hogy használjuk a ciklusokat imperatív nyelveken, akkor felfedezhetünk bennük mellékhatásokat:

for (int i = 0; i < sum; i++)

létrejön egy i változó, ez már önmagában egy mellékhatás, márpedig ahogy tanultuk, 
a Haskell egy tisztán funkcionális nyelv, ami azt jelenti, hogy a mellékhatások nem megengedett jelenségek 
(kivéve, ha kifejezetten kezelni akarjuk őket, lásd: funkcionális nyelvek, kötvál tárgy)

Ha a ciklushoz nem használhatunk efféle eszközöket, akkor hogy valósítjuk meg őket?

Megintcsak gondoljunk a matematikára, speciálisan a faktoriálisra. Mi a faktoriális definíciója?
-}
factorial :: Integer -> Integer
factorial = undefined

-- Definíció:
-- Rekurzív függvény: Olyan függvény, amely önmaga definiálásához saját magát használja fel.

-- Amikor rekurziót definiálunk, nagyon fontos hogy jól válasszuk meg az alapesetünket. 
-- Ha rosszul választunk, vagy elfelejtünk definiálni, akkor végtelen rekurzióba ütközhetünk. 
-- FONTOS: alapeset nélkül is lehet rekurzív fv-ünk, csak az a rekurzív fv végtelen ideig fog futni
-- Nézzük meg mi történik, ha a factorialból töröljük az alapesetet

-- Definiáljuk azt a rekurzív függvényt, ami visszaadja az n-edik Fibonacci-számot
fibonacci :: Integer -> Integer
fibonacci = undefined

-- Definiáljuk azt a rekurzív függvényt, ami összeadja n-ig a számokat
sumTo :: Integer -> Integer
sumTo = undefined

-- Az előzőhöz hasonlóan, de most az adott számok négyzetét számoljuk meg
sumSquaresTo :: Integer -> Integer
sumSquaresTo = undefined

-- Definiáljuk újra a hatványozást, a viselkedés pontosan megegyezik az általunk ismert szabályokkal
infixr 8 ^
(^) :: Integer -> Integer -> Integer
(^) = undefined 
