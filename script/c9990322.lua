LuaR  

             @ e   
@     	   c9990322    initial_effect       O    	   L @ ]@ F@@ Gΐ    Δ   A@ Α@D   A ]@F@A GΑ    ] ΐΑ B @@Β B @ΐΒ  A @ @Γ C @ΐΓ D @@Δ D @ΐΔ  AA @ Ε %  @ΐΕ %A  @ Ζ %  @@F   @@A Aΐ    ΜFFA@ GΑΖ Α ]έ@  ΜΐAFG έ@Μ@BFAG G Mέ@Μ@DFΑG H Mέ@Μ@CFAH έ@ΜΐBA H έ@ ΜEeΑ  έ@ΜΐHe έ@ΜΐEeA έ@Μ Fe έ@Μ@F @ έ@Μ Iέ ΖA@ ΑFΑ B	 A  AΒI ΖG ΑAAΓΑI ΖJ ΑAΑΓAJ AΑΒ ΖH A Ε₯Α AAF A  *      EnableReviveLimit    aux    AddSynchroProcedure 	   NonTuner       π?   Effect    CreateEffect    SetCategory    CATEGORY_SPECIAL_SUMMON    SetType    EFFECT_TYPE_QUICK_O    SetCountLimit    @cA   SetCode    EVENT_FREE_CHAIN 	   SetRange    LOCATION_EXTRA    SetProperty    EFFECT_FLAG_CHAIN_UNIQUE    SetHintTiming              .°@   SetCondition 
   SetTarget    SetOperation    RegisterEffect    SetDescription 	   Stringid    CATEGORY_REMOVE    EFFECT_TYPE_SINGLE    EFFECT_TYPE_TRIGGER_O    EFFECT_FLAG_DAMAGE_STEP    EFFECT_FLAG_DELAY    EVENT_SPSUMMON_SUCCESS    EFFECT_COUNT_CODE_SINGLE    SetCost    Clone        @   EFFECT_TYPE_FIELD    EVENT_PHASE    PHASE_STANDBY    LOCATION_MZONE           	    @ @@ @   @              Duel    GetTurnPlayer             @$ 	                                    e     	      tp     	         _ENV       	    L@ ] @@ΐ ΐ    Β@ AΑB  CA D   ΐ ΔA B        GetHandler            IsSynchroSummonable    Duel    SetOperationInfo    CATEGORY_SPECIAL_SUMMON       π?   LOCATION_EXTRA             @$                                                          
      e           tp           eg           ep           ev           re           r           rp           chk           c             _ENV           @  LB@ΐ  ][B      F@ GΒΐ ΐ   ]B         GetHandler    IsRelateToEffect    Duel    SynchroSummon             @$                                                 	      e           tp           eg           ep           ev           re           r           rp           c             _ENV %   '    
   @  B@ F@ X@  B            GetHandler    GetSummonType    SUMMON_TYPE_SYNCHRO             @$    &   &   &   &   &   &   &   &   &   &   '         e           tp           eg           ep           ev           re           r           rp              _ENV (   /   	 /   e   @ B@ @ΐ  FΓ@ A M  ΑC A      B@ ΒAΖB   FCB B B@ Bΐ  @ Γ@ ΖA ΓΑ  D AD A    ΖB@ ΗΒΒ  έB ΖB@ ΗΓ  FCC C έB                 Duel    IsExistingMatchingCard    LOCATION_ONFIELD    LOCATION_HAND       π?   GetHandler    Hint    HINT_SELECTMSG    HINTMSG_REMOVE    SelectMatchingCard    HintSelection    Remove    POS_FACEUP    REASON_COST    )   )    	   L @ Ζ@@ ][   @ L@ ] _          IsType    TYPE_MONSTER    IsAbleToRemoveAsCost             @$ 	   )   )   )   )   )   )   )   )   )         c     	         _ENV         @$ /   )   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   +   +   +   +   +   +   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   .   .   .   .   .   .   /         e     /      tp     /      eg     /      ep     /      ev     /      re     /      r     /      rp     /      chk     /      fil    /      g $   /         _ENV 0   4   
 $    @ B@ @ΖΒ@ ΗΑ  A  CA ΖA ΓΑΓ     B@ BΖΒ@ ΗΑ  A  CA ΖA ΓΔ   ΖB@ ΗBΒ  FB  ΑΓ   A  έB                Duel    IsExistingMatchingCard    Card    IsAbleToRemove    LOCATION_ONFIELD    LOCATION_HAND       π?   GetMatchingGroup    SetOperationInfo    CATEGORY_REMOVE             @$ $   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   2   2   2   2   2   2   2   2   2   2   2   3   3   3   3   3   3   3   3   3   4         e     $      tp     $      eg     $      ep     $      ev     $      re     $      r     $      rp     $      chk     $      chkc     $      sg    $         _ENV 5   B    L   @ B@F@ GΒΐ Α CA FA CD   LΒA]  Α    LBΖ@ ΗBΒ  FA ]B BΒA X AΒΑ @ ΒBΐ C CCA      ΐΒΓ  A  Δ      @ BDΖD   FΓD B E  A  Δ     @ BEΐ B @ Eΐ ΓE FF B         Duel    GetMatchingGroup    Card    IsAbleToRemove            LOCATION_ONFIELD    LOCATION_HAND 	   GetCount    Filter    IsLocation    Sub    SelectYesNo    aux 	   Stringid    @cA   RandomSelect       π?   Hint    HINT_SELECTMSG    HINTMSG_REMOVE    Select    HintSelection    Remove    POS_FACEUP    REASON_EFFECT             @$ L   6   6   6   6   6   6   6   6   6   6   6   7   7   7   7   7   8   8   8   8   8   8   9   9   9   :   :   :   :   :   :   :   :   :   :   :   :   :   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   =   =   =   =   =   =   >   >   >   >   >   >   >   ?   ?   ?   ?   A   A   A   A   A   A   B   
      e     L      tp     L      eg     L      ep     L      ev     L      re     L      r     L      rp     L      sg    L      sg2    L         _ENV K   M    		   @ B@ X@   B            Duel    GetTurnPlayer             @$ 	   L   L   L   L   L   L   L   L   M         e     	      tp     	      eg     	      ep     	      ev     	      re     	      r     	      rp     	         _ENV         @$                                                             	   	   	   
   
   
   
                                                                                                                           !   !   !   !   !   "   "   "   "   "   #   #   #   $   $   $   $   %   '   %   (   /   (   0   4   0   5   B   5   C   C   C   E   E   F   F   F   F   F   F   F   G   G   G   G   G   H   H   H   H   H   I   I   I   J   J   J   J   K   M   K   N   N   N   O         c           e1          e2 7         e3 c            _ENV        @$       O      O             _ENV 