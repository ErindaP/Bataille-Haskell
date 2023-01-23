# Haskell 23 

# Question 2 : 
- 1: L'expression `data Vérité = Vrai | Faux` déclare un nouveau type de données appelé Vérité, qui peut prendre deux valeurs possibles : Vrai ou Faux. 

- 2 : L'expression `data Arbre = Noeud Float Arbre Arbre | Feuille` déclare un nouveau type de données appelé Arbre, qui représente un arbre binaire.

- 3 : L'expression `let monArbre = Noeud 5 (Noeud 2 Feuille Feuille) (Noeud 7 Feuille Feuille)` crée une valeur de type Arbre appelée monArbre, qui est un arbre binaire à trois niveaux contenant des valeurs flottantes. 
 Le noeud racine de l'arbre a une valeur de 5, et les sous-arbres gauche et droit sont des arbres binaires l'un avec un noeud de valeur 2 puis des feuilles et l'autre un noeud de valeur 7 et des feuilles

- 4 : 
arbre polymorphique : ` data Arbre t = Noeud t (Arbre t) (Arbre t) | Feuille ` 

- 5 : 


```
arbreSomme :: Num t => Arbre t -> t
arbreSomme Feuille = 0
arbreSomme (Noeud n gauche droite) = n + arbreSomme gauche + arbreSomme droite
```

- 6 : Le type de la fonction arbreSomme dépend de la version de Arbre utilisée. Si Arbre est défini comme étant Arbre Float, alors le type de arbreSomme sera Arbre Float -> Float. Si Arbre est défini comme étant Arbre t, alors le type de arbreSomme sera (Num t) => Arbre t -> t.

- 7 : Le type Maybe t est un type de données qui peut prendre deux valeurs possibles : Nothing, qui représente l'absence de valeur, et Just x, où x est une valeur de type t. Le type Maybe t est utile lorsque l'on souhaite représenter une valeur qui peut être absente dans certaines situations.

- 8 : la fonction head lève une exception.

- 9 : 
    ```
    headSafe :: [a] -> Maybe a
    headSafe [] = Nothing
    headSafe (x:_) = Just x
    ```
     Le type de la fonction headSafe est `[a] -> Maybe a ` .

- 10 : 
      `data Arbre t = Noeud t (Maybe (Arbre t)) (Maybe (Arbre t))`

- 11 : La fonction compare du prélude est une fonction générique qui permet de comparer deux valeurs de n'importe quel type qui est instance de l'ordre total. Elle renvoie EQ si les deux valeurs sont égales, LT si la première valeur est inférieure à la seconde, et GT si la première valeur est supérieure


