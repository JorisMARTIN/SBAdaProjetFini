with text_io; use text_io;
with p_esiut; use p_esiut;

package body p_vuetxt is

    procedure AfficheGrille(Grille: in TV_Grille) is
    --{} => {la grille a été affichée selon les spécifications suivantes :
    -- *la sortie est indiquée par la lettre S
    -- *une case inactive ne contient aucun caractère--
    -- *une case de couleur vide contient un point
    -- *une case de couleur blanche contient le caractère F (Fixe)--
    -- *une case de la couleur d’une pièce mobile contient le chiffre correspondant à la 
    -- position de cette couleur dans le type T_Coul}
        o : natural := 0;
        car : Character;
        int : integer;
    begin

        ecrire("     ");
        for j in Grille'range(2) loop
            ecrire(j); ecrire(' ');
        end loop;

        a_la_ligne; 
        ecrire("   ");  ecrire('S');

        loop
            ecrire(" -");
            o := o+1;
        exit when o = 7;
        end loop;

        a_la_ligne; 

        for i in Grille'range(1) loop
            Ecrire(i); Ecrire(" |");
            for j in Grille'range(2) loop
                int := -1;

                for u in T_Coul'Range loop
                    if Grille(i,j) = u and Grille(i,j) /= vide and Grille(i,j) /= blanc then 
                        int :=  T_Coul'Pos(u);
                    end if;
                end loop;

                if Grille(i,j) = blanc then car := 'F';
                elsif Grille(i,j) = vide then car := '.';
                end if;
                -- Ligne impaire 
                if i mod 2 = 1 then
                        -- Ligne impaire selon code ACII
                        if Character'Pos(j) mod 2 = 1 then
                            if int = -1 then
                                Ecrire(" " & car);
                            else
                                Ecrire(""); Ecrire(int);
                            end if;
                            
                        --Ligne paire selon code ACII
                        else
                             if int = -1 then
                                Ecrire("  ");
                            else
                                Ecrire("");
                            end if; 
                        end if;
                -- Ligne paire
                else
                    -- Colonne impaire selon code ACII
                    if Character'Pos(j) mod 2 = 1 then
                        if int = -1 then
                                Ecrire("  ");
                            else
                                Ecrire("");
                            end if; 
                        else
                            if int = -1 then
                                Ecrire(" " & car);
                            else
                                Ecrire(""); Ecrire(int);
                            end if;
                    end if;
                end if;

            end loop;
            a_la_ligne;
        end loop;

    end AfficheGrille;

    function EstDansPartie(Grille : in TV_Grille; coul : in T_Coul) return boolean is
    --{Grille est chargé} => {Résultat = coul est contenue dans Grille}
        b : boolean := false;
    begin

       for i in Grille'Range(1) loop
        for j in Grille'Range(2) loop
            if Grille(i,j) = coul then b := true;
            end if;
        end loop;
       end loop;

        return b;

    end EstDansPartie;

    procedure Demande(Grille : in TV_Grille; coul : out T_Coul; dir : out T_Direction) is
    --{Grille est initialisée} => {Demande a l'utlisateur quel piece il veut déplacer et dans quel direction.
            -- * Vérifie si la pieces est présente sur la grille.
            -- * Vérifie si le déplacement est possible sinon previen l'utilisateur et lui demande de changer}
            continue : boolean := true;
            nb : integer;
    begin

        while continue loop

            Ecrire("Choisissez la pièce que vous voulez déplacer : "); lire(nb);
            coul := T_Coul'Val(nb);

            if EstDansPartie(Grille, coul) and nb < 10 then

                Ecrire("Choisissez dans quel direction déplacer la pièce (hg / hd / bg / bd) : "); p_dir_io.lire(dir);

                if Possible(Grille, coul, dir) then continue := false;
                else Ecrire_Ligne("Il est impossible de déplacer la pièce dans cette direction.");
                end if;

            else  
                Ecrire_Ligne("Votre piece n'est pas présente sur la grille de jeu veuillez en choisir une autre.");
            end if;

        end loop;


    end Demande;

    function Annulation return boolean is
    --{] => {Demande a l'utilisateur si il veut annuler son action.
            -- Résultat = true si oui | false si non
            -- Si réponse /= de oui ou non redemander à l'utlisateur}
            continue, b : boolean := true;
            reponse : String(1..3);
    begin
        
        while continue loop
            Ecrire("Voulez-vous annuler l'action précédente ? (Oui / Non) "); Lire(reponse);
            if reponse = "Oui" or reponse = "oui" then b:= true; continue := false; 
            elsif reponse = "Non" or reponse = "non" then b := false; continue := false;
            else Ecrire_Ligne("Réponse invalide !");
            end if;
        end loop;

        return b;

    end Annulation;

    function Abandon return boolean is
    --{] => {Demande a l'utilisateur si il veut abandoner.
            -- Résultat = true si oui | false si non
            -- Si réponse /= de oui ou non redemander à l'utlisateur}
            continue, b : boolean := true;
            reponse : String(1..3);
    begin
        
        while continue loop
            Ecrire("Voulez-vous abandonnez la partie ? (Oui / Non) "); Lire(reponse);
            if reponse = "Oui" or reponse = "oui" then b:= true; continue := false; 
            elsif reponse = "Non" or reponse = "non" then b := false; continue := false;
            else Ecrire_Ligne("Réponse invalide !");
            end if;
        end loop;

        return b;

    end Abandon;

    procedure Jouer(Grille : in out TV_Grille) is
    --{Grille est initialisé} => {Procede a l'exécution du jeu:
    --  * Exécute la procedure demande.
    --  * Met a jour et affcihe la grille a chaque action.
    --  * Propose au joueur d'annuler son action précédente.
    --  * Propose au joueur d'abandonner.
    --  * Détecte si je jouer gange grâce a la fontion Guérison.

            continuer : boolean := true;
            Grille2 : TV_Grille;
            coul: T_Coul;
            dir : T_Direction;

        begin

            AfficheGrille(Grille);

            while continuer loop
            

                demande(Grille, coul, dir);

                for i in Grille2'range(1) loop
                    for j in Grille2'range(2) loop
                        Grille2(i,j) := Grille(i,j);
                    end loop;
                end loop;

                MajGrille(Grille, coul, dir);

                AfficheGrille(Grille);

                if Annulation then 
                    for i in Grille'range(1) loop
                        for j in Grille'range(2) loop
                            Grille(i,j) := Grille2(i,j);
                        end loop;
                    end loop;
                end if;

                AfficheGrille(Grille);

                if Abandon then continuer := false;    
                else continuer := true;
                end if;

                if Guerison(Grille) then ecrire_ligne("Partie gagnée !"); continuer := false;               
                end if;
                
                

        end loop;

    end Jouer;




end p_vuetxt;


