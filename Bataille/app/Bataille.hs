import System.Random.Shuffle (shuffleM)
import Data.Foldable

data Card = Card { valeur :: String, couleur :: String } deriving Show -- Définition du type représentant les cartes

type Deck = [Card]

fullDeck :: Deck -- Fulldeck contient tout le jeu de cartes
fullDeck = 
        let listeValeur = ["2","3","4","5","6","7","8","9","10","Valet","Dame","Roi","1"] in 
            let listeCouleur = ["Pique","Trefle","Coeur","Carreau"] in
                [Card x y| x <- listeValeur, y<- listeCouleur]


draw :: Deck -> (Deck, Deck) --pattern matching afin de diviser en deux un deck
draw [] = ([],[])
draw [x] = ([x],[])
draw (x:y:q) = let (d1,d2) = draw q in (x:d1,y:d2)



valeurBis :: Card -> Int -- fonction permettant ensuite de comparer les cartes plus aisément 
valeurBis card = case valeur card of
                "1"  -> 14
                "Valet"  -> 11
                "Dame"  -> 12
                "Roi"  -> 13
                _    -> read (valeur card)



singlestep :: (Deck, Deck) -> (Deck, Deck) -- fonction permettant de jouer un tour de jeu
singlestep (deck1, deck2) = (deck1n, deck2n) -- on renvoie de nouveaux decks correspondants à l'état après le tour
    where 
        card1 = head deck1
        card2 = head deck2
        (deck1n, deck2n) = if valeurBis card1 > valeurBis card2 
                            then (tail deck1 ++ [card1, card2], tail deck2)
                            else if valeurBis card1 < valeurBis card2
                                then (tail deck1, tail deck2 ++ [card2, card1]) -- On regarde ici si une carte est strictement plus forte que l'autre afin de déterminer qui remporte la manche et on modifie les decks
                                else battle deck1 deck2 []
battle :: Deck -> Deck -> [Card] -> (Deck, Deck)
battle deck1 deck2 accumulator = -- fonction récursive (on peut potentiellement enchaîner les batailles)
    if length deck1 < 2 || length deck2 < 2 -- cas terminaux mettant éventuellement fin à la partie
        then if length deck1 < 2
            then ([], (deck1 ++ deck2) ++ accumulator)
            else ((deck1 ++ accumulator) ++ deck2,[])
    else let (card1_1:card1_2:deck1_remaining) = deck1
             (card2_1:card2_2:deck2_remaining) = deck2
             newAccumulator = accumulator ++ [card1_1, card1_2, card2_1, card2_2] -- l'accumulateur stocke toutes les cartes en jeux lors de la bataille
         in if valeurBis card1_1 > valeurBis card2_1
            then (card1_2:deck1_remaining ++ accumulator ++ [card1_1,card2_1], (card2_2:deck2_remaining) )
            else if valeurBis card1_1 < valeurBis card2_1
                then (card1_2:deck1_remaining, (card2_2:deck2_remaining) ++ accumulator ++ [card1_1,card2_1]) -- on construit les decks en fonction d'une victoire lors d'une bataille en ajoutant également les cartes mises en jeux lors de la bataille
                else battle (deck1_remaining) (deck2_remaining) newAccumulator -- si il n'y a pas de victoires, on refait une bataille avec un accumulateur plus important






isDone :: (Deck, Deck) -> Bool -- fonction qui vérifie que la partie est finie
isDone (deck1, deck2) = (null deck1) || (null deck2)

determineWinner :: (Deck, Deck) -> String --fonction qui détermine le gagnant
determineWinner (deck1, deck2)
    | null deck1 = "Le joueur 2 a gagné !"
    | null deck2 = "Le joueur 1 a gagné !"
    | otherwise = "Le jeu n'est pas terminé"





dispDeck :: Deck -> String -- fonction qui affiche un deck
dispDeck deck = unlines (map (\card -> valeur card ++ " de " ++ couleur card) deck)


main = do 
    randomizedGame <- shuffleM fullDeck
    let 
        decks = draw randomizedGame
        infiniteSteps = iterate singlestep decks
        steps = takeWhile (not . isDone) infiniteSteps
    for_ steps $ \(x,y) -> do
        print (length x, length y)
        putStrLn $ dispDeck x 
        putStrLn $ dispDeck y 
        putStrLn  ""


