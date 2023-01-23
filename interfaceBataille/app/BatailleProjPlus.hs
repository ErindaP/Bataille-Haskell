import Graphics.UI.Gtk
import System.Random.Shuffle (shuffleM)
import Data.Foldable
import GHC.Show (Show(show))
import Graphics.UI.Gtk (onClicked, labelLabel, buttonActivated)
import Data.Data (typeOf)
import Data.IORef 



data Card = Card { valeur :: String, couleur :: String } deriving Show -- Définition du type représentant les cartes

type Deck = [Card]

fullDeck :: Deck -- Fulldeck contient tout le jeu de cartes
fullDeck = 
        let listeValeur = ["2","3","4","5","6","7","8","9","10","jack","queen","king","1"] in 
            let listeCouleur = ["spades","clubs","hearts","diamonds"] in
                [Card x y| x <- listeValeur, y<- listeCouleur]


draw :: Deck -> (Deck, Deck) --pattern matching afin de diviser en deux un deck
draw [] = ([],[])
draw [x] = ([x],[])
draw (x:y:q) = let (d1,d2) = draw q in (x:d1,y:d2)



valeurBis :: Card -> Int -- fonction permettant ensuite de comparer les cartes plus aisément 
valeurBis card = case valeur card of
                "1"  -> 14
                "jack"  -> 11
                "queen"  -> 12
                "king"  -> 13
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
                                else battle deck1 deck2 [] -- cas de la bataille 
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






isDone :: (Deck, Deck) -> Bool
isDone (deck1, deck2) = (null deck1) || (null deck2) -- fonction permettant de savoir si la partie est terminée 

determineWinner :: (Deck, Deck) -> String -- fonction permettant de savoir qui est le gagnant
determineWinner (deck1, deck2)
    | null deck1 = "Le joueur 2 a gagné !"
    | null deck2 = "Le joueur 1 a gagné !"
    | otherwise = "Le jeu n'est pas terminé"





dispDeck :: Deck -> String -- fonction permettant d'afficher le deck d'un joueur 
dispDeck deck = unlines (map (\card -> valeur card ++ " of " ++ couleur card) deck)


cardToPath :: Card -> String -- fonction permettant de renvoyer le chemin de l'image correspondante à une carte 
cardToPath (Card x y) = "imagesResized/" ++ x ++ "_of_" ++ y ++ ".png" 





main :: IO ()
main = do
    initGUI
    randomizedGame <- shuffleM fullDeck
    let 
        (deck1,deck2) = draw randomizedGame


    -- Créer la fenêtre
    window <- windowNew
    set window [ windowTitle := "Bataille", windowDefaultWidth := 600, windowDefaultHeight := 400]

    windowDeck <- windowNew 
    set windowDeck [windowTitle := "Decks", windowDefaultWidth := 600, windowDefaultHeight := 400]

    -- Créer le main layout
    mainLayout <- vBoxNew False 0

    deckLayout <- vBoxNew False 0 

    -- Label pour le premier deck
    deck1Label <- labelNew (Just "Deck 1 :")
    boxPackStart mainLayout deck1Label PackRepel 0

    deck1LabelAff <- labelNew (Just "Deck 1 :")
    boxPackStart deckLayout deck1LabelAff PackRepel 0

    -- Label pour la première carte du deck
    deck1CardsLabel <- labelNew (Just (show (take 1 (deck1))))
    boxPackStart mainLayout deck1CardsLabel PackGrow 0


    deck1CardsLabelAff <- labelNew (Just (dispDeck (deck1)))
    boxPackStart deckLayout deck1CardsLabelAff PackGrow 0

    -- Label pour second deck
    deck2Label <- labelNew (Just "Deck 2 :")
    boxPackStart mainLayout deck2Label PackRepel 0

    deck2LabelAff <- labelNew (Just "Deck 2 :")
    boxPackStart deckLayout deck2LabelAff PackRepel 0

    -- Label première carte second deck
    deck2CardsLabel <- labelNew (Just (show(take 1 deck2)))
    boxPackStart mainLayout deck2CardsLabel PackRepel 0

    deck2CardsLabelAff <- labelNew (Just (dispDeck deck2))
    boxPackStart deckLayout deck2CardsLabelAff PackRepel 0



    -- Créer le bouton de simulation d'une partie
   
    simulateButton <- buttonNewWithLabel "Simuler un tour"
    
    batailleButton <- buttonNewWithLabel "Afficher la bataille"
    
    image1 <- imageNew
    imageSetFromFile image1 (cardToPath (head deck1))
    boxPackStart mainLayout image1 PackNatural 0
    testButton <- buttonNewWithLabel "test"
    
    image2 <- imageNew
    imageSetFromFile image2 (cardToPath (head deck2))
    boxPackStart mainLayout image2 PackNatural 0



    


    let
        

        doSimulationStep deckio = 
            do
                (deck1,deck2) <- deckio
                if isDone (singlestep (deck1,deck2)) then do
            
                    set deck1CardsLabel [labelLabel := determineWinner (singlestep (deck1,deck2))]
                    set deck2CardsLabel [labelLabel := determineWinner (singlestep (deck1,deck2))]        
                    return (deck1,deck2)
                else do 
                    if (valeurBis (head (deck1)) == valeurBis (head (deck2)) ) --cas de bataille
                        then do 
                            
                                

                                set deck1CardsLabel [labelLabel := "Bataille"]
                                set deck2CardsLabel [labelLabel := "Bataille"]
                                imageSetFromFile image1 ("imagesResized/back.jpeg") -- On affiche les images cachées en cas de bataille
                                imageSetFromFile image2 ("imagesResized/back.jpeg")
                                onClicked batailleButton $ do

                                    imageSetFromFile image1 (cardToPath ((deck1 !! 2))) -- on révèle la carte après la bataille
                                    imageSetFromFile image2 (cardToPath ((deck2 !! 2)))


                                    
                                let 
                                    newDecks = singlestep (deck1,deck2) -- nouveaux decks après la batailles
                                return (newDecks) -- de type IO (Deck,Deck)


                    else do 

                        if (valeurBis ((deck1)!! 1) > valeurBis ((deck2)!!1 ) ) then do

                            set deck1CardsLabel [labelLabel := "Le joueur 1 a gagné la manche"]
                            set deck2CardsLabel [labelLabel := "Le joueur 2 a perdu la manche"]
                        else do
                            if (valeurBis ((deck1)!! 1) ==  valeurBis ((deck2)!!1 ) ) then do 
                                set deck1CardsLabel [labelLabel := "Bataille"]
                                set deck2CardsLabel [labelLabel := "Bataille"]
                            else do
                                set deck1CardsLabel [labelLabel := "Le joueur 1 a perdu la manche"]
                                set deck2CardsLabel [labelLabel := "Le joueur 2 a gagné la manche"]


                        let (deck1n, deck2n) = singlestep (deck1, deck2)

                        imageSetFromFile image1 (cardToPath (head deck1n)) -- on affiche les cartes correspondantes
                        imageSetFromFile image2 (cardToPath (head deck2n))

                        set deck1CardsLabelAff [ labelLabel := (dispDeck deck1n)]
                        set deck2CardsLabelAff [ labelLabel := (dispDeck deck2n)]
                        return (deck1n,deck2n)


    decksIORef <- newIORef (return (deck1,deck2)) -- decksIORef est de type IORef IO (Deck,Deck)
    decksIO <- readIORef decksIORef -- de type IO (Deck,Deck)
    writeIORef  decksIORef (doSimulationStep (decksIO)) -- On modifie la référence en exécutant doSimulatioStep qui est de type IO (Deck,Deck) -> IO (Deck,Deck)

    
    
        
    onClicked simulateButton $ do
                decksIO <- readIORef decksIORef
                decks <- decksIO -- decks de type (Deck,Deck)
                -- putStrLn $ dispDeck (fst decks) -- ligne pour affichage dans la console


                writeIORef  decksIORef (doSimulationStep (decksIO))
                
                putStrLn $ ""
                
            



    
    
    
    boxPackStart mainLayout simulateButton PackGrow 0
    boxPackStart mainLayout batailleButton PackNatural 0

    -- Ajouter main layout à la fenêtre
    containerAdd window mainLayout
    containerAdd windowDeck deckLayout

    -- Afficher fenêtre et boucle
    onDestroy window mainQuit

    widgetShowAll window
    widgetShowAll windowDeck
    mainGUI
