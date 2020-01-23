with p_fenbase ; use p_fenbase ;
with Forms ; use Forms;
with p_esiut; use p_esiut;
with p_virus; use p_virus;
use p_virus.p_piece_io;

package body p_vue_graph is


    function CoulToFL_Coul(Coul : in T_Coul) return T_Couleur is
    --{} => {Résultat = Couleur de la grille en format T_Couleuur);
    begin

        case Coul is

            when rouge => return FL_RED;
            when turquoise => return FL_CYAN;
            when orange => return FL_DARKORANGE;
            when rose => return FL_DEEPPINK;
            when marron => return FL_DARKTOMATO;
            when bleu => return FL_BLUE;
            when violet => return FL_DARKVIOLET;
            when vert => return FL_GREEN;
            when jaune => return FL_YELLOW;
            when blanc => return FL_WHITE;
            when vide => return FL_BOTTOM_BCOL;

        end case;
    end CoulToFL_Coul;


    procedure Menu(Grille : out TV_Grille; niv : out integer) is
    --{InitFenetre a été exécuté} => {Ouvre le menu et préconfigure la partie, donne le niveau choisis.} 

        MenuPrincipal, Nom, Regles, Niveau : TR_Fenetre;
        u : Integer := 0;

        f : p_piece_io.file_type;
        Pieces: TV_Pieces;

        b : boolean := false;
        s : String(1..4);
        nbConfig : integer;

    begin
    
    niv := 1;

    Nom:= DebutFenetre("Nom du Joueur",400,100);
        AjouterChamp(Nom,"ChampNom","Votre nom","jojo",100,10,280,30);
        AjouterBouton(Nom,"BoutonValider","Valider",100,50,70,30);
        AjouterBouton(Nom,"BoutonAnnuler","Quitter",180,50,70,30);
    FinFenetre(Nom);

        MenuPrincipal := DebutFenetre("Menu Principal", 1000, 500);
            AjouterImage(MenuPrincipal, "Antivirus", "titre.xpm", "", 0, 0, 1000, 500);
            --AjouterTexte(MenuPrincipal,"Niveau","Choisissez votre niveau :",420,210,165,30);
            AjouterBoutonImage(MenuPrincipal,"BoutonNiveau1", "", "debutant.xpm",345,260,70,30);
            AjouterBoutonImage(MenuPrincipal,"BoutonNiveau2", "", "amateur.xpm",425,260,70,30);
            AjouterBoutonImage(MenuPrincipal,"BoutonNiveau3", "", "pro.xpm",505,260,70,30);
            AjouterBoutonImage(MenuPrincipal,"BoutonNiveau4", "", "expert.xpm",585,260,70,30);
            AjouterBoutonImage(MenuPrincipal,"BoutonQuitter", "", "quitter.xpm",465,300,70,30);
            AjouterBoutonImage(MenuPrincipal, "BoutonRegle", "", "regles.xpm", 10,460,70,30);
            AjouterImage(MenuPrincipal, "Créateurs", "credits.xpm", "", 675,425,300,50);
        FinFenetre(MenuPrincipal);


        Regles := DebutFenetre("Regles du jeu", 500, 500);
            AjouterImage(Regles, "Regles", "rg.xpm", "", 0, 0, 500, 500);
            AjouterBoiteCocher(Regles, "BtnR", "Compris !", 400, 460, 50, 25); 
        FinFenetre(Regles);    


        Niveau := DebutFenetre("Niveau", 500, 250);
            AjouterImage(Niveau, "FondNiveau", "fondNiv.xpm", "", 0, 0, 500,250);
            AjouterBouton(Niveau, "1", "1", 105, 100, 50, 50);
            AjouterBouton(Niveau, "2", "2", 165, 100, 50, 50);
            AjouterBouton(Niveau, "3", "3", 225, 100, 50, 50);
            AjouterBouton(Niveau, "4", "4", 285, 100, 50, 50);
            AjouterBouton(Niveau, "5", "5", 345, 100, 50, 50);
            AjouterBoutonImage(Niveau, "Retour", "","retour.xpm", 400, 190, 70, 30);
        FinFenetre(Niveau);


    MontrerFenetre(Nom);

    if AttendreBouton(Nom) /= "BoutonAnnuler" then

        CacherFenetre(Nom);

        <<retour>>

        MontrerFenetre(MenuPrincipal);

            declare 
                  Bouton : String := (AttendreBouton(MenuPrincipal));
            begin

                if Bouton = "BoutonRegle" then 

                    b := false;
                    MontrerFenetre(Regles);
                    ChangerEtatBoiteCocher(Regles, "BtnR", false);

                    while b = false loop
                        s := AttendreBouton(Regles);
                        b := ConsulterEtatBCRB(Regles, "BtnR");
                    end loop;

                    CacherFenetre(Regles);
                    
                    goto retour;

                elsif Bouton = "BoutonNiveau1" then 

                    niv := 1;
                    ChangerCouleurFond(Niveau,"1", FL_GREEN);
                    ChangerCouleurFond(Niveau,"2", FL_GREEN);
                    ChangerCouleurFond(Niveau,"3", FL_GREEN);
                    ChangerCouleurFond(Niveau,"4", FL_GREEN);
                    ChangerCouleurFond(Niveau,"5", FL_GREEN);

                elsif Bouton = "BoutonNiveau2" then 
                    niv := 6;
                    ChangerTexte(Niveau, "1","6");
                    ChangerTexte(Niveau, "2","7");
                    ChangerTexte(Niveau, "3","8");
                    ChangerTexte(Niveau, "4","9");
                    ChangerTexte(Niveau, "5","10");

                    ChangerCouleurFond(Niveau,"1", FL_YELLOW);
                    ChangerCouleurFond(Niveau,"2", FL_YELLOW);
                    ChangerCouleurFond(Niveau,"3", FL_YELLOW);
                    ChangerCouleurFond(Niveau,"4", FL_YELLOW);
                    ChangerCouleurFond(Niveau,"5", FL_YELLOW);

                elsif Bouton= "BoutonNiveau3" then 
                    niv := 11;
                        
                    ChangerTexte(Niveau, "1","11");
                    ChangerTexte(Niveau, "2","12");
                    ChangerTexte(Niveau, "3","13");
                    ChangerTexte(Niveau, "4","14");
                    ChangerTexte(Niveau, "5","15");

                    ChangerCouleurFond(Niveau,"1", FL_DARKORANGE);
                    ChangerCouleurFond(Niveau,"2", FL_DARKORANGE);
                    ChangerCouleurFond(Niveau,"3", FL_DARKORANGE);
                    ChangerCouleurFond(Niveau,"4", FL_DARKORANGE);
                    ChangerCouleurFond(Niveau,"5", FL_DARKORANGE);


                elsif Bouton = "BoutonNiveau4" then 
                    niv := 16;

                    ChangerTexte(Niveau, "1","16");
                    ChangerTexte(Niveau, "2","17");
                    ChangerTexte(Niveau, "3","18");
                    ChangerTexte(Niveau, "4","19");
                    ChangerTexte(Niveau, "5","20");

                    ChangerCouleurFond(Niveau,"1", FL_RED);
                    ChangerCouleurFond(Niveau,"2", FL_RED);
                    ChangerCouleurFond(Niveau,"3", FL_RED);
                    ChangerCouleurFond(Niveau,"4", FL_RED);
                    ChangerCouleurFond(Niveau,"5", FL_RED);

                else niv := 0;
                  end if;

                  CacherFenetre(MenuPrincipal);
                  MontrerFenetre(Niveau);

                  if niv /= 0 then 
                        declare
                              BoutonNiv : String := (AttendreBouton(Niveau));
                        begin
                              if BoutonNiv = "1" then
                                    CacherFenetre(Niveau);
                                    nbConfig := niv + 0;

                              elsif BoutonNiv = "2" then
                                    CacherFenetre(Niveau);
                                    nbConfig := niv + 1;

                              elsif BoutonNiv = "3" then
                                    CacherFenetre(Niveau);
                                     nbConfig := niv + 2;   

                              elsif BoutonNiv = "4" then
                                    CacherFenetre(Niveau);
                                    nbConfig := niv + 3;

                              elsif BoutonNiv = "5" then
                                    CacherFenetre(Niveau);
                                    nbConfig := niv + 4;
                                else 
                                    CacherFenetre(Niveau);
                                    goto retour;
                              end if;
                        end;

                        Open(f, in_file, "Parties");
                        reset(f, in_file);
                        InitPartie(Grille, Pieces);
                        Configurer(f, nbConfig, Grille, Pieces);
                        Close(f);

                  end if;
            end;

    else niv := 0;

    end if;
    
    end Menu;

    procedure Jeu(Grille : in out TV_Grille; ab : out boolean) is
    --{InitialiserFenetres a été exécuté} => {Debut la partie en fonction de Grille, 
            -- initialise ab pour savoir si je joueur abandone}

        Jeu, Erreur : TR_Fenetre;
        u : integer := 0;
        v : integer;
        nm : String(1..2);
        coul : T_coul;

    begin

         Jeu := DebutFenetre("Antivirus", 1250, 800);
                AjouterImage(Jeu, "FondJeu", "fondJeu.xpm", "", 0, 0, 1250, 800);
                AjouterBoutonImage(Jeu, "HG", "", "HG.xpm", 915,270,100,100);
                AjouterBoutonImage(Jeu, "HD", "", "HD.xpm", 1025,270,100,100);
                AjouterBoutonImage(Jeu, "BG", "", "BG.xpm", 915,380,100,100);
                AjouterBoutonImage(Jeu, "BD", "", "BD.xpm", 1025,380,100,100);
                AjouterBouton(Jeu, "Select", "", 915,160,210,100);
                AjouterBoutonImage(Jeu, "Abandon", "", "abandonner.xpm", 1000, 700, 200, 50);
                ChangerEtatBouton(Jeu, "Select", Arret);

                for i in Grille'range(1) loop  
                    for j in Grille'range(2) loop

                          nm := Integer'Image(i)(2..2) & j;
                          coul := Grille(i,j);

                        v := T_Col'Pos(j) mod 65;

                        if coul /= blanc and coul /= vide then

                            AjouterBouton(Jeu, nm, " ", (v*100)+50, ((i-1)*100)+50, 100,  100);
                            ChangerCouleurFond(Jeu,nm,CoulToFL_Coul(coul));


                        elsif coul = blanc then
                            AjouterBouton(Jeu, nm, " ", (v*100)+50, ((i-1)*100)+50, 100, 100);
                            ChangerCouleurFond(Jeu, nm,FL_WHITE);
                            ChangerEtatBouton(Jeu, nm, Arret);
                        else

                            if u mod 2 = 0 then
                                AjouterBouton(Jeu, nm, " ", (v*100)+50, ((i-1)*100)+50, 100, 100);
                                ChangerCouleurFond(Jeu,nm,CoulToFL_Coul(coul));
                                ChangerEtatBouton(Jeu, nm, Arret);
                            else AjouterBouton(Jeu, nm, " ", (v*100)+50, ((i-1)*100)+50, 100, 100);
                                ChangerCouleurFond(Jeu,nm,FL_BLACK);
                                ChangerEtatBouton(Jeu, nm, Arret);
                            end if;

                        end if;
                            u := u +1;
                    end loop;
                end loop;
        FinFenetre(Jeu);


        Erreur := DebutFenetre("Erreur", 300, 150);
            AjouterTexte(Erreur, "Msg", "Veuillez selectionner une couleur !", 25, 55, 250, 20);
            AjouterBoiteCocher(Erreur, "BtnE", "Compris !", 100, 100, 50, 25);
        FinFenetre(Erreur);

        MontrerFenetre(Jeu);

        ab := false;
        
        while Guerison(Grille) = false and ab = false loop

            declare
                BTN : String := (AttendreBouton(Jeu));
                Sauv : String(1..2);
                i : integer;
                j : Character;

                b : boolean := false;
                s : String(1..4);
            begin


                if BTN /= "HG" and BTN /= "HD" and BTN /= "BG" and BTN /= "BD" and BTN /= "Abandon" then

                    i := Character'Pos(BTN(BTN'First)) mod 48;
                    j := BTN(BTN'Last);
                    Sauv := BTN;

                    ChangerCouleurFond(Jeu, "Select", CoulToFL_Coul(Grille(i,j)));
                    
                elsif i/= 0 and j /= 'Z' and BTN /= "Abandon" then

                    if BTN = "HG" then


                        if Possible(Grille, Grille(i,j), hg) then
                            MajGrille(Grille, Grille(i,j), hg);
                            i := i-1;
                            j := Character'Pred(j);
                        end if;

                    elsif BTN = "HD" then


                        if Possible(Grille, Grille(i,j), hd) then
                            MajGrille(Grille, Grille(i,j), hd);
                            i := i-1;
                            j := Character'Succ(j);
                        end if;

                    elsif BTN = "BG" then


                        if Possible(Grille, Grille(i,j), bg) then
                            MajGrille(Grille, Grille(i,j), bg);
                            i := i+1;
                            j := Character'Pred(j);
                        end if;

                    elsif BTN = "BD" then
                        
                        if Possible(Grille, Grille(i,j), bd) then
                            MajGrille(Grille, Grille(i,j), bd);
                            i := i+1;
                            j := Character'Succ(j);
                        end if;

                    end if;


                    u := 0;
                    for a in Grille'Range(1) loop 
                        for b in Grille'Range(2) loop

                            nm := Integer'Image(a)(2..2) & b;
                            coul := Grille(a,b);


                            if coul /= blanc and coul /= vide then

                                ChangerCouleurFond(Jeu,nm,CoulToFL_Coul(coul));
                                ChangerEtatBouton(Jeu, nm, Marche);

                            elsif coul = blanc then

                                ChangerCouleurFond(Jeu, nm,FL_WHITE);
                                ChangerEtatBouton(Jeu, nm, Arret);

                            else

                                if u mod 2 = 0 then
                                    ChangerCouleurFond(Jeu,nm,CoulToFL_Coul(coul));
                                    ChangerEtatBouton(Jeu, nm, Arret);
                                else 
                                    ChangerCouleurFond(Jeu,nm,FL_BLACK);
                                    ChangerEtatBouton(Jeu, nm, Arret);
                                end if;

                            end if;
                            u := u+1;
                        end loop;
                    end loop;

                elsif BTN = "Abandon" then
                    ab := true;
                    
                end if;

                exception 
                    when CONSTRAINT_ERROR => 

                                b := false;
                                MontrerFenetre(Erreur);
                                ChangerEtatBoiteCocher(Erreur, "BtnE", false);

                                while b = false loop
                                    s := AttendreBouton(Erreur);
                                    b := ConsulterEtatBCRB(Erreur, "BtnE");
                                end loop;

                                CacherFenetre(Erreur);


            end;
        end loop;

        CacherFenetre(Jeu);

    end Jeu;

    procedure Fin (b : out boolean) is
    --{La partie est fini} => {Affiche la fenetre de fin de partie, 
        -- * initialise b pour savoir si le joueur veut rejouer}
        Fin : TR_Fenetre;
    begin

        Fin := DebutFenetre("Victoire", 500, 250);
            AjouterImage(Fin, "Fin", "fin.xpm", "", 0, 0, 500, 250);
            AjouterBoutonImage(Fin, "NP", "", "nvPartie.xpm", 160, 190, 70, 30);
            AjouterBoutonImage(Fin, "Quitter", "", "quitter.xpm", 270, 190, 70, 30);
        FinFenetre(Fin);

        MontrerFenetre(Fin);

        declare
            Boutton : String := (AttendreBouton(Fin));
        begin
            if Boutton = "NP" then
                b := true;
            else b := false;
            end if;
        end;
        
        CacherFenetre(Fin);

    end Fin;    

end p_vue_graph;