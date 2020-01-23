with p_fenbase ; use p_fenbase ;
with Forms ; use Forms;
with p_esiut; use p_esiut;
with p_virus; use p_virus;
with ada.calendar; use ada.calendar;

procedure antivirus is

SaisieNom, Jouer : TR_Fenetre;

begin

InitialiserFenetres;

Saisienom := DebutFenetre("Menu Principal", 1000, 500);
AjouterTexte(SaisieNom,"Antivirus","ANTIVIRUS",450,100,280,30);
      AjouterBouton(SaisieNom,"BoutonJouer","Jouer",400,120,70,30);
      AjouterBouton(SaisieNom,"BoutonQuitter","Quitter",180,50,70,30);
FinFenetre(SaisieNom);



   MontrerFenetre(SaisieNom);

 if AttendreBouton(SaisieNom) /= "BoutonQuitter" then
   	-- le jeu commence
    CacherFenetre(SaisieNom); -- nombre de touches pressées
      end if;


end antivirus;