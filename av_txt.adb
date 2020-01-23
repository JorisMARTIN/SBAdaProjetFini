with p_vuetxt; use p_vuetxt;
with p_esiut; use p_esiut;
with p_virus; use p_virus;
use p_virus.p_piece_io;


procedure av_txt is

    Grille : TV_Grille;
    Pieces : TV_Pieces;
    f : p_piece_io.file_type;
    nb : positive;
    reponse : String(1..3);

    b, b2 : boolean := true;

begin

    Open(f, in_file, "Parties");

    while b loop

        nb := 1;
        InitPartie(Grille, Pieces);
        
        ecrire_ligne("------------------------------------------------------------------------------------------------------------------------");
        ecrire_ligne("                                        Bienvenue sur ANTIVIRUS");
        ecrire_ligne("------------------------------------------------------------------------------------------------------------------------");
        
        A_la_ligne;
        
        ecrire("Choisissez votre niveau de difficulté (entre 1 et 20): "); lire(nb); A_la_ligne;
        
        Configurer(f, nb, Grille, Pieces);
        Jouer(Grille);


        while b2 loop
            Ecrire("Voulez-vous rejouez une autre partie ? (Oui / Non) "); lire(reponse);
                if reponse = "Non" or reponse = "non" then b := false; b2 := false;
                elsif reponse = "Oui" or reponse = "oui" then b2 := false;
                end if;
        end loop;
    end loop;

end av_txt;