with text_io; use text_io;
with p_virus; use p_virus;

package p_vuetxt is


    procedure AfficheGrille(Grille: in TV_Grille);
    --{} => {la grille a été affichée selon les spécifications suivantes :
    -- *la sortie estindiquée par la lettre S--*une case inactive ne contient aucun caractère--
    -- *une case de couleur vide contientun point--*une case de couleur blanchecontientle caractère F (Fixe)--
    -- *une case de la couleur d’une pièce mobilecontientle chiffre correspondant à la 
    -- position de cettecouleur dans le type T_Coul}

    --function EstDansPartie(Grille : in TV_Grille; coul : in T_Coul) return boolean;
    --{Grille est chargé} => {Résultat = coul est contenue dans Grille}

    --procedure Demande(Grille : in TV_Grille; coul : out T_Coul; dir : out T_Direction);
    --{Grille est initialisée} => {Demande a l'utlisateur quel piece il veut déplacer et dans quel direction.
    -- * Vérifie si la pieces est présente sur la grille.
    -- * Vérifie si le déplacement est possible sinon previen l'utilisateur et lui demande de changer}

    --function Annulation return boolean;
    --{] => {Demande a l'utilisateur si il veut abandoner.
    -- * Résultat = true si oui | false si non
    -- * Si réponse /= de oui ou non redemander à l'utlisateur}

    --function Abandon return boolean;
    --{] => {Demande a l'utilisateur si il veut abandoner.
    -- Résultat = true si oui | false si non
    -- Si réponse /= de oui ou non redemander à l'utlisateur}

    procedure Jouer(Grille : in out TV_Grille);
    --{Grille est initialisé} => {Procede a l'exécution du jeu:
    --  * Exécute la procedure demande.
    --  * Met a jour et affcihe la grille a chaque action.
    --  * Propose au joueur d'annuler son action précédente.
    --  * Propose au joueur d'abandonner.
    --  * Détecte si je joueur gagne grâce a la fontion Guérison.}

end p_vuetxt;