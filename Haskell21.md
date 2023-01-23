# Haskell 21 

## Question 2 : 

- 1: Une fonction à récursivité terminale est une fonction où l'appel récursif est la dernière instruction à être évaluée. Cette instruction est alors nécessairement « pure », c'est-à-dire qu'elle consiste en un simple appel à la fonction, et jamais à un calcul ou une composition.


- 2: FactorielleA n'est pas récurzsive terminale car le résultat de la récursion est ensuite multipliée à des entiers : dans FacotirelleA, on évalue d'abord les appels des fonctions factorielleA avant de procéder aux multiplications 
FactorielleB est récursive terminale (ou plutôt la fonction go l'est). Cette dernière ne fait que des appels à elle même en faisant décroêitre son premier argument et en gardant les calculs dans l'accumulateur


## Question 3 : 

La première version de la fonction minimum utilise une récursion non terminale :
```
minimumA :: [Float] -> Float
minimumA [] = error "La liste est vide"
minimumA [x] = x
minimumA (x:xs) = min x (minimumA xs)
```

La seconde version de la fonction minimum utilise une récursion terminale :
``` 
minimumB :: [Float] -> Float
minimumB xs = go xs (head xs)
  where
    go [] acc = acc
    go (x:xs) acc = go xs (min x acc)
```


La première version de la fonction and utilise une récursion non terminale :
```
andA :: [Bool] -> Bool
andA [] = True
andA (x:xs) = x && andA xs
```


La seconde version de la fonction and utilise une récursion terminale :
```
andB :: [Bool] -> Bool
andB xs = go xs True
  where
    go [] acc = acc
    go (x:xs) acc = go xs (acc && x)
``` 

Non term: 
```
reduceA :: (t -> t -> t) -> [t] -> t
reduceA _ [] = error "La liste est vide"
reduceA _ [x] = x
reduceA f (x:xs) = f x (reduceA f xs)
```

Term :

```
reduceB :: (t -> t -> t) -> [t] -> t
reduceB f xs = go xs (head xs)
  where
    go [] acc = acc
    go (x:xs) acc = go xs (f x acc)
```


## Question 4 :

- Si la liste passée en paramètre à la fonction reduce est vide, cela déclenchera une erreur car il n'y a pas d'élément sur lequel effectuer la réduction. En effet, la fonction reduce n'a pas de valeur par défaut en cas de liste vide, elle s'attend à ce qu'une liste non vide lui soit passée en paramètre.

- Une fonction totale est une fonction qui est définie pour tous les éléments de son domaine, c'est-à-dire qu'elle ne provoque pas d'erreur quel que soit l'élément sur lequel elle est appliquée. Une fonction non totale, en revanche, peut provoquer une erreur ou ne pas être définie pour certains éléments de son domaine.


- La fonction head est une fonction non totale, car elle provoque une erreur si la liste passée en paramètre est vide.
La fonction div est une fonction totale, car elle est définie pour tous les entiers. Elle provoque une erreur si le diviseur est 0, mais elle est définie pour tous les autres cas.
```
reduceTotalA :: (t -> t -> t) -> t -> [t] -> t
reduceTotalA _ def [] = def
reduceTotalA f def [x] = x
reduceTotalA f def (x:xs) = f x (reduceTotalA f def xs)
``` 

```
reduceTotalB :: (t -> t -> t) -> t -> [t] -> t
reduceTotalB f def xs = go xs def
  where
    go [] acc = acc
    go (x:xs) acc = go xs (f x acc)
```

## Question 5 : 


Les fonctions du prélude qui sont similaires aux deux versions de reduce et reduceTotal sont foldl et foldr.


- Dans l'appel foldr (+) 0 [1..10], la fonction foldr parcourt la liste de droite à gauche et utilise la récursion non terminale. Le résultat est donc égal à 55.

- Dans l'appel foldl (+) 0 [1..10], la fonction foldl parcourt la liste de gauche à droite et utilise la récursion terminale. Le résultat est donc égal à 55.

- Dans l'appel foldr (:) [] [1..10], la fonction foldr parcourt la liste de droite à gauche et utilise la récursion non terminale. Le résultat est donc la liste [1,2,3,4,5,6,7,8,9,10].
 
- Dans l'appel foldl (flip (:)) [] [1..10], la fonction foldl parcourt la liste de gauche à droite et utilise la récursion terminale. Le résultat est donc la liste [10,9,8,7,6,5,4,3,2,1].

- Dans l'appel foldr (||) False (repeat True), la fonction foldr parcourt la liste de droite à gauche et utilise la récursion non terminale. Le résultat est donc True.

- Dans l'appel foldl (||) False (repeat True), la fonction foldl parcourt la liste de gauche à droite et utilise la récursion terminale. Le programme boucle donc indéfiniement (on n'a pas d'évaluation paresseuse)

- L'évaluation paresseuse, qui consiste à évaluer les expressions uniquement lorsque cela est nécessaire, peut avoir un impact sur le résultat final lorsque l'on utilise foldl ou foldr avec des opérateurs non stricts, c'est-à-dire des opérateurs qui ne sont pas évalués de manière stricte.

- La fonction foldl' du module Data.Foldable est similaire à foldl, mais elle utilise une récursion terminale et une évaluation paresseuse. Elle est utile lorsque l'on souhaite éviter l'accumulation de très grandes chaînes de caractères en mémoire, qui peuvent provoquer des fuites de mémoire. En effet, lorsqu'on utilise foldl avec une grande liste, la fonction doit garder en mémoire tous les éléments de la liste jusqu'à ce que le calcul soit terminé. Avec foldl', les éléments de la liste sont évalués au fur et à mesure et l'accumulateur est mis à jour à chaque étape, ce qui permet de réduire la quantité de mémoire nécessaire pour effectuer le calcul.
