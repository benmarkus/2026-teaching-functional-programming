module Gyak1 where

{-
Funkcionális programozás:

Függvényeket írunk benne.
MINDIG van eredmény; olyan nincs, hogy "csak csinálunk valamit", egy függvénynek mindig van eredménye.
Általában deklaratív stílusúak.
Azt mondjuk meg, hogy MIT szeretnénk eredményül; nem azt, hogy hogyan kapjuk meg az eredményt.
-}

{-
Haskell nyelv:

Definíció:
1.) Statikusan típusos: Minden kifejezésnek van fordítási időben típusa.
2.) Erősen típusos: A megadott típusokat be kell tartani!
3.) Tiszta nyelv: Nincsenek benne mellékhatások.

2.)
Nincs implicit konverzió szám és szám között (se semmilyen más típus között)!
Az Int az nem Integer és az Integer az nem Int. -> Sok butaságtól ment meg minket.

Szubjektív, hogy kinek mi számít erősnek.
Valaki azt mondja, hogy a C#, meg a Java erősen típusos nyelvek.
Valakinek meg a Haskell is gyengén típusos.

3.)
Definíció:
   -- pl. 1 + 3 esetén az eredmény mindig 4 lesz és semmi más nem fog történni a háttérben sem.

Összetettebb példa mellékhatásra:

--------- C# nyelvbeli kód ---------

public static void main(String[] args) {

   int a = 0;

   public int f(int x) {
   if (a == 0) {
      a = 1;
      return x + 1;
   } else {
      a = 0;
      return x * 2;
   }

   Console.WriteLine(f(1));
   Console.WriteLine(f(1));
   Console.WriteLine(f(3));
   Console.WriteLine(f(3));
}

Mit várnánk el természetes módon az azonos függvényhívásoktól?
Milyeneknek kéne az eredményeknek lenniük?
Válasz:

Matematikai szempontból:

a függvény egy egyértelmű hozzárendelés: egy adott inputra egy adott output létezik csak. Amint ez nem teljesül, nem függvényről beszélünk.

Mit fog a C# kód kiírni?
Válasz:

ugyanarra a bemenetre mindig váltakozik a kimenet. A matematikai függvényfogalom ezt nem engedi meg.
-}

{-
Haskell kinézete, felépítése:

   Modulokból épül fel
      -> Egy modul egy darab fordítási egység
   Modulnév nagybetűvel kezdődik

   Függvények nevei kisbetűvel kezdődnek.

   Ahogy a legtöbb nyelvben, itt is van main, de ezzel ezen a tárgyon nem foglalkozunk.
   A Funkcionális nyelvek nevű tárgyon lehet erről többet tanulni.

   Természetesen az egyes egységek fordíthatók, viszont ezt sem fogjuk ezen a tárgyon csinálni.

   Mi a GHC nevű compiler interaktív környezetét, a GHCi-t fogjuk használni
-}

{-
Hasznos GHCi parancsok:

   ghci            ghci elindítása

   GHCi-n belül
   :l <fájlnév>            fájl betöltése
   :r                      legutoljára betöltött fájl újratöltése
   :! cls                  terminál clearelése
   :! <terminálparancs>    a :! igazából egy "kiszólás" a ghciből az eredeti terminálra
                           így az adott terminál parancsait tudjuk használni belülről, pl <dir>/<ls>
   :q                      kilépés
-}

{-
Kommentelés:

Haskellben kétfajta módon lehet kommentet írni a kódba:
- "--" karakterrel kezdve, ekkor a sor végéig tart a komment
- {- -} karakterek között, ekkor a köztes tartalom a komment
  Ez a fajta komment egymásba ágyazódik, mindig a legközelebbi záró mínusz kapcsos zárja a kommentet.
-}

-----------------------------------------------------------------------------------------
--                                    Alaptípusok
-----------------------------------------------------------------------------------------

-- Konkrét típusok neveit NAGYBETŰVEL kezdjük.
-- pl.: Int, Integer, Float, Double, Char, Bool

-- Az első órán egyszerűbb típusokkal és függvényekkel ismerkedünk

----------------------------
-- Int
----------------------------
-- (x32 -> 32 bit) ; (x64 -> 64 bit)

one :: Int
one = undefined

----------------------------
-- Integer
----------------------------
-- Szintén egész számokat ábrázol, de ez a végtelenségig; gyakorlatilag a RAM a határ.

three :: Integer
three = undefined

-- Van két függvényünk, nézzük meg, hogyan használatjuk őket ghci-ben
-- Nézzük meg, hogy mi történik 'one + three' esetén!

-- Nézzük meg mi történik, ha a következő függvényt definiáljuk úgy, hogy a korábbiakat meghagyjuk

{-
three :: Int
three = 3
-}





-- A Haskell nem engedi meg a függvények túltöltését és felülírását sem
--                                            ^             ^
--                                        overload       override


-- Negatív számok

-- negatív literál [számjegy] nincs Haskellben
-- néha úgy működik ahogy számítunk rá

negativeOne :: Integer
negativeOne = undefined

-- néha pedig nem
{-
oops :: Integer
oops = 3 + -4
-}
-- de van rá megoldás, tegyük zárójelbe

correctWayOfUsingNegSign :: Integer
correctWayOfUsingNegSign = undefined

----------------------------
-- Char
----------------------------

-- Karakterliterálokat aposztróffal írunk, azok között egy karakter jelöl egy karaktert.

a :: Char
a = undefined

-- Egyelőre nem tanulunk igazán érdekes függvényt Char-hoz, később azonban sokszor előkerül majd.

----------------------------
-- Bool
----------------------------

-- Két értéke van: True és False (igaz és hamis értéket reprezentál)
   --              ^^^^    ^^^^^
   --              NAGYBETŰVEL kell írni az első betűt!

true :: Bool
true = True

false :: Bool
false = False

-- Műveletek:
   -- not: Bool típusú értéket negál, True → False, False → True
   -- (&&): Két Bool-t összeésel, logikai konjunkció, csak akkor igaz, ha mindkét bemenete True, máskor False.
   -- (||): Két Bool-t összevagyol, logikai diszjunkció, akkor igaz, ha bármelyik paraméter True, egyébként False.

----------------------------
-- Float és Double
----------------------------

-- A számokban tizedesPONT van, nem vessző!

half :: Float
half = undefined

quarter :: Double
quarter = undefined

-- Trükkösebb műveletek:
-- (/), div, mod

-- (/) csak törtszámokon működik.
-- div, mod csak egész számokon működik.
-- div: Egész osztás
-- mod: Maradékos osztás

-- Megjegyzés: A div-nek és a mod-nak a paramétereit SZÓKÖZZEL ELVÁLASZTVA adjuk át.
--             Ez általánosan igaz bármely függvényre Haskell-ben.

-- Mi lesz az eredmény 1 / 0 esetén?
-- Mi lesz az eredmény div 1 0 esetén?

{-
Fordítás idejű hiba (compilation/compile-time error): A forráskód kritikus hibát tartalmaz, amely nem engedi a program létrehozását, generálását.
   -- típushibák ilyenek (leggyakoribb hiba ez lesz, amivel fogtok találkozni)
   -- szintaktikus hiba (parse error)
   -- Felismerése: GHCi-ben piros "error" szöveggel kezdődő üzenetek.

Futás idejű hiba (runtime error): A program létrejött és futtatható, azonban futás közben történik valamilyen kritikus hiba, ami miatt leállásra kényszerül a program.
   -- 0-val való osztás, pl 1 `div` 0.
   -- Hiányzó programág, hiányzó mintaillesztés (2. órán lesz róla szó).
   -- Felismerése: *** Exception-nel kezdődő szöveg kerül kiírásra.
-}

----------------------------
-- Függvények: (->) típus
----------------------------

-- A paramétereket a típusban nyilakkal (->) választjuk el egymástól és az eredménytől.
-- Az utolsó nyíl utáni típus az eredménynek a típusa.

-- SZÉP KÓD: Ugyan Haskell képes kitalálni a függvények típusait,
-- de a kódban legyen ott minden függvénynek a típusa,
-- hiszen az adja az olvashatóság legnagyobb részét, továbbá megóv minket, programozókat a butaságok írásától.

--  a függvényünk neve
--  |             a függvény típusszignatúrája {mi(k)ből mi lesz}
--  |             v
--  |            __________________
--  v
--  camelCase :: Int -> Int -> Int <- az utolsó elem, ő lesz a visszatérési érték
--               ^--------^
--                   ^- paraméter típusok
--  camelCase x y = (x * 2) + (y * 4)
--  ^ a függvény teste, itt definiáljuk a viselkedését

inc :: Int -> Int
inc x = x + 1

{-
A paraméter neve kisbetűvel kell kezdődjön, utána állhat nagybetű, szám, és aposztróf.
Megjegyzés: Haskell-ben a paraméter nevekre ezen kívül nincs előírás, használhatunk x,y,z,a,b,c-t

Egyszerűbb függvényeknél az olvashatóságot legnagyobb részt a típusok adják,
így a paraméterek nevei általában nem baj, ha 1-2 betűsek,
esetleg egy hosszú nevű típus rövidítése szokott lenni.

Bonyolultabb feladatoknál ugyanakkor nem baj, ha beszédesebb neveket használunk.

-- SZÉP KÓD: Függvények használatakor a paramétereket szóközzel választjuk el egymástól; felesleges zárójeleket ne használjunk!
-- Pl. szép: inc 1
--   csúnya: inc(1) <- ilyet légyszi ne írjatok
-}

-- Próbáljuk ki, hogy mi történik, ha definiáljuk még egyszer ugyanezt a függvényt egy másik típussal:
--inc :: Integer -> Integer
--inc x = x + 1

double :: Int -> Int
double x = x * 2

-- SZÉP KÓD: Operátorok és függvények definiálásakor és használatakor használjuk a szóközt bőven és nyugodtan
-- Pl. x+1 helyett írjuk azt, hogy x + 1, sokkal olvashatóbb, átláthatóbb.
-- Két különböző függvény definiálása között hagyjunk üres sort, hogy elkülönüljenek vizuálisan egymástól.

{-
Példa a típusszignatúra definiálásának elmulasztására

Ha csak ennyit írok, hogy f x = x + 1, akkor Haskell boldogan kitalálja, hogy x egy szám és elfogadja a definíciót.
Ha tudom, hogy a paraméter Integer, az eredmény pedig Double kell legyen, akkor ha leírom, hogy:

f :: Integer -> Double
f x = x + 1

akkor máris fordítási időben megfogja Haskell. Ezzel el tudunk kerülni futásidejű hibákat
-}

{-
Prefix-Infix írásmód:

Prefix -> Pre, mint elő: a függvény/operátor az operandusok (paraméterek) előtt helyezkedik
A latin karakterekkel írott nevű függvények általában prefix helyen használatosak.

double 2
not True
elem 1 [1,2,3]
div 5 2
mod 487 34

Infix -> In: a függvény/operátor az operandusok között helyezkedik el
főleg operátorokat írunk így

1 + 2
3 * 3
3 - 4


A függvények használati helye módosítható:


Prefix -> Infix

A backtick (`, AltGr+7) karakterek közé rakva prefix függvény nevét lehet használni azt infixen.

7 `div` 2
345 `mod` 12
1 `elem` [1,2,3]

Infix -> Prefix

Ha a függvény egy operátor, akkor az operátort kerek zárójelek közé rakva lehet használni azt prefixen.

(+) 4 5
(*) 2 3

-- FONTOS! A prefixen írt függvény kötési erőssége MINDIG A LEGERŐSEBB!

Ellenőrző kérdések:
Az alábbiak közül melyik kifejezés helyes? Amelyik helyes, mennyi lesz az értéke?
-}
test1 = 3 + (*) 4 5
test2 = 3 * (+) 4 5
test3 = (*) 3 4 + 5
test4 = (+) 3 4 * 5
test5 = (*) 3 (+) 4 5
test6 = (*) 3 ((+) 4 5)
test7 = (+) 3 ((*) 4 5)
