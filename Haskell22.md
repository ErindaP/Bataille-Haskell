# Haskell 22 

## Question 2 

- 1 : L'expression `data Vector = Vector3 Float Float Float` déclare un nouveau type de données appelé Vector, qui est un vecteur à 3 dimensions. Le constructeur Vector3 permet de créer des valeurs de ce type en fournissant trois flottants, qui seront les coordonnées du vecteur dans l'espace.

- 2: 
    ```
    magnitude :: Vector -> Float
    magnitude (Vector3 x y z) = sqrt (x^2 + y^2 + z^2)
    ```



## Question 3 




- 1 : L'expression data Vector t = Vector t t t déclare un nouveau type de données appelé Vector, qui est un vecteur à 3 dimensions contenant des éléments de type t. Le constructeur Vector permet de créer des valeurs de ce type en fournissant trois éléments de type t, qui seront les coordonnées du vecteur dans l'espace.

- 2 : Le type de l'expression Vector "Hello" "World" "!" est Vector String, car les trois éléments qui sont passés au constructeur sont des chaînes de caractères.

- 3 : Le type de l'expression Vector 1 2 3 est Vector Integer, car les trois éléments qui sont passés au constructeur sont des entiers.

- 4 : Le type de l'expression Vector (5 :: Float) 3 4 est Vector Float, car l'un des éléments qui est passé au constructeur est un flottant. Le type de l'expression est déterminé en fonction du type de l'élément qui possède le type le plus spécifique. Dans ce cas, 5 :: Float est un flottant, donc le type de l'expression est Vector Float.

- 5 : data Liste t = Liste Integer [t]

- 6 
    ```
    initListe :: Liste t
    initListe = Liste 0 []
    ```
- 7 :  
    ```
    ajouteListe :: Liste t -> t -> Liste t
    ajouteListe (Liste taille elements) element = Liste (taille + 1) (element:elements)
    ```

- 8 : 
L'intérêt de la définition du type Liste comparée à une liste traditionnelle est que la définition de Liste permet de stocker la taille de la liste en même temps que la liste elle-même.
Sans avoir à reparcourir la liste en entier pour avoir sa taille



RAS