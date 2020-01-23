with p_esiut; use p_esiut;

package body p_virus is


	procedure InitPartie(Grille: in out TV_Grille; Pieces: in out TV_Pieces) is
	--{} => {Tous les éléments de Grille ont été initialisés avec la couleur vide--
	--	y compris les cases inutilisables
	-- 	Tous les éléments de Pieces ont été initialisés à false}

	begin

		for i in Grille'range(1) loop
			for k in Grille'range(2) loop
				Grille(i,k) := vide;
			end loop;
		end loop;

		for j in Pieces'range loop
			Pieces(j) := false;
		end loop;

	end InitPartie;

------------------------------------------------------------------------------------------------------------------------

	procedure Configurer (f : in out p_piece_io.file_type; nb : in positive; Grille : in out TV_Grille; Pieces: in out TV_Pieces) is
	--{f ouvert, nb est un numéro de configuration (appelé numéro de partie),
	--une configuration décrit le placement des pièces du jeu, pour chaque configuration:
	--	* les éléments d’une même pièce (même couleur) sont stockés consécutivement
	--	* il n’y a pas deux pièces mobiles ayant la même couleur
	--	* les deux éléments constituant le virus (couleur rouge) terminent la configuration}
	--		=> {Grille a été mis à jour par lecture dans f de la configuration de numéro nb
	--			Pieces a été initialisé en fonction des pièces de cette configuration}

		elem, sauv : TR_ElemP;
		b : boolean;
		i : integer := 0;

	begin
		reset(f, in_file);
		
		

    	while i /= nb-1 loop
     		 b := true;
     		 	while b loop
       				sauv := elem;
        			read(f, elem);

       					 if sauv.couleur = elem.couleur and elem.couleur = rouge then b := false;
       					 end if;

     			 end loop;
      		 i := i+1;
  		  end loop;

   		 b := true;

    	while b loop
       		 sauv := elem;
       		 read(f, elem);

       			 if sauv.couleur = elem.couleur and elem.couleur = rouge then b := false;
          			Grille(elem.ligne, elem.colonne) := elem.couleur;
         			 Pieces(rouge) := true;
     			 else
       				 Grille(elem.ligne, elem.colonne) := elem.couleur;
       				 Pieces(elem.couleur) := true;
     			 end if;

     	 end loop;

	end Configurer;

------------------------------------------------------------------------------------------------------------------------

	procedure PosPiece(Grille: in TV_Grille; coul: in T_coulP) is
	--{} => {la position de la pièce de couleur coul a été affichée si cette pièce est dans Grille
	--	exemple: ROUGE: F4 G5}

	begin

	
		for i in Grille'range(1) loop
			for j in Grille'range(2) loop
				if coul = Grille(i,j)
        then
						 ecrire(j & integer'Image(i));
						 ecrire(' ');
				end if;
			end loop;
		end loop;

	end PosPiece;

------------------------------------------------------------------------------------------------------------------------

 	function Possible (Grille: in TV_Grille; coul: T_CoulP; Dir : in T_Direction) return boolean is
 	--{coul /= blanc} --=> {résultat= vrai si la pièce de couleur coul peut être déplacée dans la direction Dir}
	b : boolean;
	begin

		begin
			for i in Grille'Range(1) loop
				for j in Grille'Range(2) loop
					if Grille(i,j) = coul then
						case Dir is

							when hg => if Grille(i-1, T_Col'pred(j)) = coul or Grille(i-1, T_col'pred(j)) = vide then b:= true;
										else return false;
										end if;
										
							when hd => if Grille(i-1, T_col'succ(j)) = coul or Grille(i-1, T_col'succ(j)) = vide then b:= true;
										else return false;	
										end if;
	
							when bg => if Grille(i+1, T_col'pred(j)) = coul or Grille(i+1, T_col'pred(j)) = vide then b:= true;
										else return false;
										end if;
										
							when bd => if Grille(i+1, T_col'succ(j)) = coul or Grille(i+1, T_col'succ(j)) = vide then b:= true;
										else return false;
										end if;
							end case;
						end if;
				end loop;
			end loop;


			exception
				when CONSTRAINT_ERROR => b := false;
			end;
		return b;

	end Possible;

------------------------------------------------------------------------------------------------------------------------

	procedure MajGrille (Grille: in out TV_Grille; coul: in T_coulP; Dir :in T_Direction) is
	--{la pièce de couleur coul peutêtre déplacée dans la direction Dir}
	--=> {Grille a été mis à jour suite au déplacement}

		Grille2 : TV_Grille;

	begin

		for i in Grille2'Range(1) loop
			for j in Grille2'Range(2) loop
				Grille2(i,j) := vide;
			end loop;
		end loop;

		for i in Grille'Range(1) loop
			 for j in Grille'Range(2) loop
			 	if Grille(i,j) = coul then
					case Dir is
						when hg => Grille2(i-1, T_Col'Pred(j)) := coul;
						when hd => Grille2(i-1, T_Col'Succ(j)) := coul;
						when bg => Grille2(i+1, T_Col'Pred(j)) := coul;
						when bd => Grille2(i+1, T_col'Succ(j)) := coul;
					end case;
					Grille(i,j) := vide;
				end if;
			 end loop;
		end loop;

		for i in Grille2'Range(1) loop
			 for j in Grille2'Range(2) loop
			 	if Grille2(i,j) = coul then
					Grille(i,j) := coul;
				end if;
			 end loop;
		end loop;

	end MajGrille;

------------------------------------------------------------------------------------------------------------------------

	function Guerison(Grille: in TV_Grille) return boolean is
	--{} => {résultat = le virus (pièce rouge) est prêt à sortir (position coin haut gauche)}

	begin
				if Grille(1,'A') = rouge and Grille(2,'B') = rouge then return true;
				else return false;
				end if;

	end Guerison;




end p_virus;
