LuaR  

             @ A@  @ @ e   
@@ e@  
@ @ e  
@        require    expansions/script/c9990000 	   c9991182    initial_effect    chainlimit 
   schfilter       B    	q   F @ G@ΐ    ] ΐ Α@ @ Α AA @A   @ @ @@ΐ    ΜΐAFB GAΒ ΑΑ ]έ@  Μ CFAC C Mέ@Μ@FΑC D Mέ@Μ AFAD D Mέ@ΜΐDFE έ@Μ@EA έ@ΜΐEe  έ@Μ FFAF GΖέ@ΜΐFeA  έ@Μ Ge  έ@ΜA @ έ@Ζ @ Η@ΐ   έ ΑΑB ABΑ  A  ΓAG ΖG ΑΖΑG ΑAΐH AΑAA AΑΔE AAΕ Α A AΘΑ Α A ΑΕ₯Α  AΖAF FAΑΖ₯ AΗ₯A AA A  #      Effect    CreateEffect    SetType    EFFECT_TYPE_ACTIVATE    SetCode    EVENT_FREE_CHAIN    RegisterEffect    SetDescription    aux 	   Stringid    ΐcA           SetCategory    CATEGORY_SPECIAL_SUMMON    CATEGORY_TOKEN    EFFECT_TYPE_FIELD    EFFECT_TYPE_TRIGGER_F    EVENT_PHASE    PHASE_STANDBY 	   SetRange    LOCATION_SZONE    SetCountLimit       π?   SetCondition    SetCost 	   c9991182    chainlimit 
   SetTarget    SetOperation    CATEGORY_TOGRAVE    CATEGORY_SEARCH    CATEGORY_TOHAND    EFFECT_TYPE_QUICK_O    SetHintTiming      @@          		   @ B@ X@   B            Duel    GetTurnPlayer             @$ 	                                    e     	      tp     	      eg     	      ep     	      ev     	      re     	      r     	      rp     	         _ENV       	     @@ C _ FB@ Gΐ  ΖΒ@   A   Α  ]BFB@ Gΐ  ΖBA   A   Α  ]B                Duel    SetOperationInfo    CATEGORY_TOKEN       π?   CATEGORY_SPECIAL_SUMMON             @$                                                                         	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV         '   @  B@  B      @ Β@@ A @A    A ΒA@  B      A B@   F@ GBΒ Α   @   Γ  ΔB ]B         GetHandler    IsRelateToEffect    Duel    GetLocationCount    LOCATION_MZONE       π?   Dazz    IsCanCreateEldraziScion    CreateEldraziScion    SpecialSummon            POS_FACEUP             @$ '                                                                                                                         	      e     '      tp     '      eg     '      ep     '      ev     '      re     '      r     '      rp     '      token    '         _ENV +   -       @ B@@   ΖΒ@  Y   B            Duel    GetFieldGroupCount            LOCATION_REMOVED             @$    ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   -         e           tp           eg           ep           ev           re           r           rp              _ENV /   5   	 &   L@ ] @@ΐ   @Β@ AΖBA ΗΑ  FΓA C  Α    Β@ BBΑB  B @ ΑC  D  BΒ@ BBΑB  ΓB D   ΐ ΔA B        GetHandler            IsAbleToGrave    Duel    IsExistingMatchingCard 	   c9991182 
   schfilter    LOCATION_DECK       π?   SetOperationInfo    CATEGORY_TOGRAVE    CATEGORY_TOHAND             @$ &   0   0   1   1   1   1   2   2   2   2   2   2   2   2   2   2   2   2   2   3   3   3   3   3   3   3   3   3   4   4   4   4   4   4   4   4   4   5   
      e     &      tp     &      eg     &      ep     &      ev     &      re     &      r     &      rp     &      chk     &      c    &         _ENV 6   @    /   @  LB@ΐ  ][B      F@ GΒΐ ΖA ]BF@ GBΑA ΐ ΓA ]B F@ GΒ ΖBB ΗΒ  FΓB  ΑC D D  ]Γ @ ΒCΐ  FA B @ DΞB B        GetHandler    IsRelateToEffect    Duel    SendtoGrave    REASON_EFFECT    Hint    HINT_SELECTMSG    HINTMSG_ATOHAND    SelectMatchingCard 	   c9991182 
   schfilter    LOCATION_DECK               π?	   GetCount    SendtoHand    ConfirmCards             @$ /   7   7   8   8   8   8   8   8   9   9   9   9   9   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   <   <   <   <   =   =   =   =   =   =   >   >   >   >   >   @   
      e     /      tp     /      eg     /      ep     /      ev     /      re     /      r     /      rp     /      c    /      g    /         _ENV         @$ q                                          
   
   
   
                                                                                                                               !   !   !   #   #   #   #   $   $   $   $   $   $   $   %   %   %   %   %   %   %   &   &   &   '   '   '   (   (   (   )   )   )   )   *   *   *   *   +   -   +   .   .   .   .   /   5   /   6   @   6   A   A   A   B         c     q      e1    q      e2    q      e3 A   q         _ENV C   M   	 A    @@LB@ ] LΐΑΒ  ]X ΐ  CB  C _ FA GBΑ] @ΐFA GΑ] ΒA @FA GΒ Α  CB ] @@LB ] A ΒBΖC C@B B@  BCΓ  FC MΓΓD MCD ΑΓ    @B LB@ ] LBΓΑΒ  C ΓCFD CA  Γ  ]B                 GetHandler    GetFlagEffect       π?   Duel    GetTurnPlayer    GetCurrentPhase    PHASE_STANDBY    GetFieldGroupCount    LOCATION_REMOVED    GetDescription    Hint    HINT_OPSELECTED    RegisterFlagEffect    RESET_EVENT      ΰA   RESET_CHAIN    EFFECT_FLAG_CLIENT_HINT             @$ A   D   D   D   D   D   D   D   D   D   D   D   D   E   E   E   E   E   E   E   E   E   E   E   F   F   F   F   F   F   F   F   G   G   H   H   H   H   H   H   I   I   I   I   I   I   I   I   I   I   I   I   I   I   K   K   K   K   K   K   K   K   K   K   K   M   
      e     A      tp     A      eg     A      ep     A      ev     A      re     A      r     A      rp     A      chk     A      desc !   4         _ENV N   P    	   L @ Ζ@@ ][   @ L@ ] _          IsRace    RACE_REPTILE    IsAbleToHand             @$ 	   O   O   O   O   O   O   O   O   P         c     	         _ENV        @$                B      C   M   C   N   P   N   P             _ENV 