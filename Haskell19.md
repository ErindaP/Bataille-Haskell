# Haskell 19 

## Question 2 : 
- 1: Une fonction d'ordre supérieur en langage fonctionnel est une fonction qui prend une ou plusieurs fonctions en argument, ou qui retourne une fonction en tant que résultat.
- 2: Le type d'une fonction d'ordre supérieur prenant en entrée une fonction de type Int -> Int et un Float, et retournant une liste de réels [Float] serait : `(Int -> Int) -> Float -> [Float]` 
 - 3: 
    ```
        apply3 :: (a -> a) -> a -> a
        apply3 f x = f (f (f x))
    ```
    On peut la tester avec addTwo 

    ```
    > apply3 addTwo 5
    11
    ```

- 4: La contrainte sur le type de la fonction d'entrée de apply3 est qu'elle doit être une fonction prenant un argument de type a et retournant un résultat de type a, où a est un type générique qui peut être remplacé par n'importe quel autre type lors de l'utilisation de la fonction.

- 5:
    ```
    applyN :: (a -> a) -> Int -> a -> a
    applyN f 0 x = x
    applyN f n x = f (applyN f (n-1) x)

    ```


## Question 3 


- 1: Cette expression : `let square x = x * x in map square [1..5] ` définit une fonction "square" qui prend un entier en entrée et qui renvoie son carré, puis utilise la fonction "map" pour appliquer cette fonction "square" à chaque élément de la liste [1..5]
- 2: La fonction "map" prend une fonction et une liste en entrée et applique la fonction à chaque élément de la liste. Elle retourne une nouvelle liste contenant les résultats de ces applications.
- 3: Le type de la fonction "map" est : (a -> b) -> [a] -> [b]. Elle prend en entrée une fonction de type "a -> b"  et une liste de type [a], et retourne une liste de type [b] correspondant à la liste des éléments après application de la fonction donnée en argument .
- 4: 
    ```
    myMap :: (a -> b) -> [a] -> [b]
    myMap f xs = [f x | x <- xs]
    ```

- 5: 
    ```
    myMap2 :: (a -> b) -> [a] -> [b]
    myMap2 _ [] = []
    myMap2 f (x:xs) = f x : myMap2 f xs
    ```
- 6 : L'expression `filter odd [1..10]` retourne une liste contenant tous les éléments impairs de la liste [1..10] : [1, 3, 5, 7, 9].

- 7: La fonction `filter` prend une fonction de prédicat et une liste en entrée, et retourne une nouvelle liste contenant seulement les éléments de la liste d'entrée pour lesquels le prédicat est vrai.

- 8: Le type de la fonction filter est : `(a -> bool) -> [a] -> [a]` elle prend une fonction qui teste si un élément de type a vérifie un prédicat puis l'applique à une liste d'éléments de type a pour générer la liste d'éléments de type a des éléments vérifiants ce prédicat

- 9: 
    ```
    myFilter :: (a -> Bool) -> [a] -> [a]
    myFilter _ [] = []
    myFilter f (x:xs)
    | f x       = x : myFilter f xs
    | otherwise = myFilter f xs
    ```

- 10: 
L'expression `zip [1..3] ['a'..] ` retourne la liste `[(1,'a'),(2,'b'),(3,'c')] ` 

- 11: 
zip est une fonction qui prend en entrée deux listes et qui retourne une liste de paires, en combinant les éléments des deux listes de façon à ce que le premier élément de chaque paire provienne de la première liste, le deuxième élément de chaque paire provienne de la deuxième liste

- 12: 
Le type de la fonction zip est `[a] -> [b] -> [(a,b)]`

- 13: 
`zipWith (+) [1,2,3] [4,5]`  retourne [5,7]. 

- 14:
La fonction zipWith prend une fonction en paramètre, ainsi que deux listes en entrée. Elle
applique la fonction en paramètre sur chaque paire d'éléments de même indice des listes d'entrée,
et retourne une liste contenant les résultats de ces applications.

- 15:
Le type de la fonction zipWith est `(a -> b -> c) -> [a] -> [b] -> [c]` .

- 16: 
    ```
    myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
    myZipWith _ [] _ = []
    myZipWith _ _ [] = []
    myZipWith f (x:xs) (y:ys) = (f x y) : (myZipWith f xs ys)
    ```