# Haskell 20

## Question 2 : 

- 1: 
Une fonction currifiée est une fonction qui prend un ou plusieurs arguments et renvoie une fonction qui attend les arguments restants
- 2: 
Dans l'exemple `max 67 5`, la fonction max est appliquée à deux arguments, 67 et 5, et renvoie le plus grand des deux, soit 67. Dans l'exemple `(max 67) 5 ` , la fonction max est d'abord appliquée à l'argument 67, ce qui renvoie une fonction qui attend un argument. Cette fonction est alors appliquée à l'argument 5, ce qui donne le résultat 67.

- 3: Son type pourrait être défini comme `max :: Ord a => a -> (a -> a)` , ce qui signifie qu'elle prend un argument de type a et renvoie une fonction qui attend un argument de type a et renvoie un résultat de type a.


- 4:
La currification peut être considérée comme l'utilisation de fonctions anonymes car elle permet de créer de nouvelles fonctions à partir de fonctions existantes en fixant certains de leurs arguments. Par exemple, en currifiant la fonction max, nous pouvons créer une nouvelle fonction qui attend un argument et renvoie une fonction qui attend un autre argument et renvoie le plus grand des deux. Cette nouvelle fonction est une fonction anonyme car elle n'a pas de nom.


## Question 3 : 
- 1:
L'expression `filter (>10) [1..100]` filtre la liste [1..100] en ne gardant que les éléments supérieurs à 10. Elle renvoie donc une liste contenant tous les entiers de 11 à 100.

- 2: Une fonction infixe est une fonction qui est appelée en utilisant une notation infixe, c'est-à-dire en plaçant le nom de la fonction entre ses arguments. Par exemple, dans l'expression 2 + 3, l'opérateur + est une fonction infixe qui prend deux arguments, 2 et 3, et renvoie leur somme.

- 3: Pour transformer une fonction préfixe prenant deux arguments en fonction infixe en Haskell, nous pouvons utiliser la notation de backquotes (`) autour du nom de la fonction

- 4: Une section en Haskell est une notation qui permet de créer une fonction à partir d'une fonction infixe en fixant l'un de ses arguments


- 5: 
    ```
    div20 :: Float -> Float
    div20 = (/20)
    ```
- 6:  
    `   any (>5) [1..10]`