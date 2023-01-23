# Readme 

- Utilisation du jeu :  Le jeu va afficher les cartes des deux joueurs (le joueur 1 correspondant au paquet du haut et le joueur 2 à celui du bas) .  
- Le bouton  **Simuler un tour** permet de réaliser l'opération de jouer un tour du jeu c'est à dire retourner la carte du dessus du paquet de chacun des deux joueurs et ensuite ajouter les cartes au paquet du vainqueur.   
- Le bouton **Afficher bataille** n'est utile que lorsque qu'il y a une bataille et que les cartes sont retournées, c'est un bouton destiné uniquement à l'affichage et n'ayant aucun impact sur les paquets, il permet de regarder la carte que l'on devrait retourner après la bataille. Le bouton Simuler le tour va alors passer au tour d'après en actualisant les decks  
- La seconde fenêtre affichée contient l'état des decks au moment du jeu, elle s'actualise pour chaque clic sur le bouton Simuler un tour 

----

## Disclaimers 

- Je débute avec gtk que j'ai utilisé pour l'interface graphique , et également avec IO et les monads pour Haskell en général, mon code doit probablement contenir des parties peu optimales. 
- Ce projet a été crée en utilisant cabal. 

- Les modules  utilisés sont gtk2hs random-shuffle et Data.IORef, les dépendances sont spécifiées dans le fichier interfaceBataille.cabal 

- Le projet tel qu'il est demandé dans la fiche HSK26 se trouve dans l'autre répertoire créer avec cabal les fonctions concernant le jeu en lui-même sont les mêmes dans les deux projets. 