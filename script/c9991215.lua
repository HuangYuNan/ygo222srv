LuaR  

             @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@@ eΐ  
@ @ e  
@  
      require    expansions/script/c9990000 	   c9991215    initial_effect    Dazz_name_godra    WyrmGraveCostFilter    ccost    ctg    cop           ;   F @ G@ΐ    Α  ]@Fΐ@ G Α    ε   Α@ AAFA GΑΑB C ]@L@B ]@ FB GΐΒ    ]  Γ Α@ ACA Α @   Δ AD @Δ ΑD @ Ε Α AA @ Ε ΑE @ Ζ AF F@ΐΖ AF G@@Η AF G@ΐG   @         Dazz    GodraExtraCommonEffect    πͺsA   aux    AddFusionProcFun2    FilterBoolFunction    Card    IsAttribute    ATTRIBUTE_WIND    EnableReviveLimit    Effect    CreateEffect    SetDescription 	   Stringid    ΰcA      π?   SetCategory    CATEGORY_TODECK    SetType    EFFECT_TYPE_IGNITION    SetCountLimit    π|A	   SetRange    LOCATION_MZONE    SetCost 	   c9991215    ccost 
   SetTarget    ctg    SetOperation    cop    RegisterEffect              F @ G@ΐ    Ζ@ Ηΐΐ^ _           Dazz    IsGodra    Card    GetFusionCode             @$                                  c              _ENV         @$ ;                                                            	   	   	   	   
   
   
   
   
   
   
                                                                                                c     ;      e1    ;         _ENV        	   L @ Ζ@@ ][   @ L@ ] _          IsRace 
   RACE_WYRM    IsAbleToGraveAsCost             @$ 	                                    c     	         _ENV       	 )    @ FB@ GΐΒ@ Aΐ CA FA CA  Γ Δ  ^_  FB@ GΒBB ΐ B ]B FB@ GΒΒ ΖΒ@ ΗΑ  FCA A M  ΑΓ Δ D  ]B@ CΐCC B                Duel    IsExistingMatchingCard 	   c9991215    WyrmGraveCostFilter    LOCATION_HAND    LOCATION_MZONE       π?   Hint    HINT_SELECTMSG    HINTMSG_TOGRAVE    SelectMatchingCard    SendtoGrave    REASON_COST             @$ )                                                                                                                              
      e     )      tp     )      eg     )      ep     )      ev     )      re     )      r     )      rp     )      chk     )      g #   )         _ENV    "   	      @FB@ GΐΒ@ Aΐ CA FCA  Δ  ^_  FB@ GΒΑΒ@ Aΐ CA FCA   ] B@ BΑ  CB @ Α    B  
              Duel    IsExistingMatchingCard    Card    IsAbleToDeck    LOCATION_ONFIELD       π?   GetMatchingGroup    SetOperationInfo    CATEGORY_TODECK             @$                                                                                !   !   !   !   !   !   !   !   !   "   
      e            tp            eg            ep            ev            re            r            rp            chk            sg              _ENV #   *    "   @ B@F@  ΖΒ@ B @ A@ BA Aΐ ΓA FΓA  Α   LBB] @F@ GΒΒ ]B F@ GΓ Δ  C FC ]B        Duel    Hint    HINT_SELECTMSG    HINTMSG_TODECK    SelectMatchingCard    Card    IsAbleToDeck    LOCATION_ONFIELD       π?	   GetCount            HintSelection    SendtoDeck        @   REASON_EFFECT             @$ "   $   $   $   $   $   $   %   %   %   %   %   %   %   %   %   %   %   %   &   &   &   &   '   '   '   '   (   (   (   (   (   (   (   *   	      e     "      tp     "      eg     "      ep     "      ev     "      re     "      r     "      rp     "      g    "         _ENV        @$                                                 "      #   *   #   *             _ENV 