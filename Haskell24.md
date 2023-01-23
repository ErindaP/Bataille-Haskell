# Haskell 24

## Question 2 :

- 1: L'expression `data Vector t = Vector t t t` définit un type de données nommé Vector qui peut contenir trois éléments de n'importe quel type t. La ligne print (Vector "Hello" "You" "!") essaie d'imprimer à l'écran une valeur de type Vector, mais cette valeur n'est pas imprimable par défaut.


- 2: En ajoutant deriving (Show) à la définition de Vector, on indique que le type Vector est instance de la classe de types Show, ce qui permet d'afficher les valeurs de type Vector à l'écran.


## Question 3 : 

- 1 : Dans la première version de Card, le type Card ne possède pas d'instances de la classe de types Eq ni de la classe de types Ord, ce qui rend impossible la comparaison entre les valeurs de type Card. En ajoutant deriving (Eq, Ord) à la définition de Card, on indique que le type Card est instance de ces deux classes de types, ce qui permet de comparer des valeurs de type Card entre elles. Dans la seconde version de Card, les comparaisons `Valet == Dame ` et ` Valet < Dame` sont possibles et renvoient respectivement False et True.


- 2 : Cette expression défini un type avec 3 constructeurs, puis indique comment comparer ces constructeurs entre eux 

- 3 : Pour Eq, il faut définir la fonction == pour Ord il faut < > <= et >=  et pour Show, il faut définir la fonction show


