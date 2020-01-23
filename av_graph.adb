with p_vue_graph; use p_vue_graph;
with p_fenbase ; use p_fenbase ;
with p_esiut; use p_esiut;
with p_virus; use p_virus;
with ada.calendar; use ada.calendar;

procedure av_graph is

      Grille : TV_Grille;    
      i : integer := 0;
      niv : integer;
      b : boolean := true;
      abandon : boolean;

begin

      while b loop

            InitialiserFenetres;
            Menu(Grille, niv);

            if niv /= 0 then
                        
                  Jeu(Grille, abandon);
                  if abandon = false then
                        Fin (b);
                  end if;
            else
                  b := false;   
            end if;
      end loop;


end av_graph;