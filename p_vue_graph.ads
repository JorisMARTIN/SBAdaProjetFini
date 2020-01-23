with p_fenbase ; use p_fenbase ;
with Forms ; use Forms;
with p_virus; use p_virus;

package p_vue_graph is

    function CoulToFL_Coul(Coul : in T_Coul) return T_Couleur;
    --{} => {Résultat = Couleur de la grille en format T_Couleuur);
    
    procedure Menu(Grille : out TV_Grille; niv : out integer);
    --{InitialiserFenetres a été exécuté} => {Ouvre le menu et préconfigure la partie}  

    procedure Jeu(Grille : in out TV_Grille; ab : out boolean);
    --{InitialiserFenetres a été exécuté} => {Debut la partie en fonction de Grille, 
            -- initialise ab pour savoir si je joueur abandone}

    procedure Fin (b : out boolean);
    --{La partie est fini} => {Affiche la fenetre de fin de partie,
        -- * initialise b pour savoir si le joueur veut rejouer}
    
end p_vue_graph;