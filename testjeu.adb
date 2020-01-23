with p_virus; use p_virus;
with p_esiut; use p_esiut;
use p_virus.p_piece_io;

procedure testjeu is

Grille : TV_Grille;
Pieces : TV_Pieces;
f : p_piece_io.file_type;
nb : positive;
coul : T_Coulp;
check : boolean;

begin

    coul := rouge;
    Open(f, in_file, "Parties");

    InitPartie(Grille, Pieces);
    ecrire("Choisissez un numéro de configuration entre 1 et 20 : "); lire(nb);

    Configurer(f, nb, Grille, Pieces);

    PosPiece(Grille, coul);

    check := Possible(Grille, coul, hd);
    ecrire(check);

    A_la_ligne;

    PosPiece(Grille, coul); a_la_ligne;
    MajGrille(Grille, coul, hd);
    PosPiece(Grille, coul);


exception

    when STATUS_ERROR => ecrire("Le fichier n'est pas ouvert. Réessayez.");

end testjeu;
