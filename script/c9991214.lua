LuaR  

             @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@@ eΐ  
@   	      require    expansions/script/c9990000 	   c9991214    initial_effect    Dazz_name_godra    cfilter    ctg    cop           <   F @ G@ΐ    Α  ]@Fΐ@ G Α    ε   Α@ AAFA GΑΑB C ]@L@B ]@ FB GΐΒ    ]  Γ Α@ ACA Α @   Δ AD FD A@ΐΔ E @@Ε Α A @ ΐΕ F @@Ζ %A  @Ζ ΑF G@@Η ΑF G@ΐG   @         Dazz    GodraExtraCommonEffect    ΰͺsA   aux    AddFusionProcFun2    FilterBoolFunction    Card    IsAttribute    ATTRIBUTE_FIRE    EnableReviveLimit    Effect    CreateEffect    SetDescription 	   Stringid    ΐcA      π?   SetCategory    CATEGORY_DAMAGE    CATEGORY_DRAW    SetType    EFFECT_TYPE_IGNITION    SetCountLimit    ΰ|A	   SetRange    LOCATION_MZONE    SetCost 
   SetTarget 	   c9991214    ctg    SetOperation    cop    RegisterEffect              F @ G@ΐ    Ζ@ Ηΐΐ^ _           Dazz    IsGodra    Card    GetFusionCode             @$                                  c              _ENV           L @ Α@  ]@C  _       	   SetLabel       π?           @$                            e                    @$ <                                                            	   	   	   	   
   
   
   
   
   
   
                                                                                                   c     <      e1    <         _ENV        	   L @ Ζ@@ ][   @ L@ ] _          IsRace 
   RACE_WYRM    IsAbleToRemoveAsCost             @$ 	                                    c     	         _ENV    )   	 X    @ΐLB@ ] ΐΐ LΒ@ Α  ]B@ C  _ FA GBΑA ΒAΐ B A    Δ  ][   FA GBΒ Α  ]_ LΒ@ Α  ]BFA GΒΒB ΐ C ]B FA GBΓ ΖA ΗΒΑ  FB   Α    D  ]LΓ] A ΒCΞB B A DΜBΔέ B  A DΐΓD FE B A BEΑ  E D    ΞC DΔ B  A BEΑ  ΓE D    ΐ   B             	   GetLabel       π?	   SetLabel    Duel    IsExistingMatchingCard 	   c9991214    cfilter    LOCATION_GRAVE    IsPlayerCanDraw    Hint    HINT_SELECTMSG    HINTMSG_REMOVE    SelectMatchingCard 	   GetFirst    SetTargetPlayer    SetTargetParam 
   GetAttack    Remove    POS_FACEUP    REASON_COST    SetOperationInfo    CATEGORY_DAMAGE    CATEGORY_DRAW             @$ X                                                                                             !   !   !   "   "   "   "   "   "   #   #   #   #   #   #   #   #   #   #   #   #   #   #   $   $   $   $   %   %   %   %   %   &   &   &   &   &   &   '   '   '   '   '   '   '   '   '   '   (   (   (   (   (   (   (   (   (   )   
      e     X      tp     X      eg     X      ep     X      ev     X      re     X      r     X      rp     X      chk     X      cc 5   X         _ENV *   0       @ B@A  Β@ ΖA Β @ BAΐ  FA  X@ @ ΒAB @ Bΐ C FA B   
      Duel    GetChainInfo            CHAININFO_TARGET_PLAYER    CHAININFO_TARGET_PARAM    Damage    REASON_EFFECT    BreakEffect    Draw       π?            @$    +   +   +   +   +   +   ,   ,   ,   ,   ,   ,   ,   ,   -   -   -   .   .   .   .   .   .   0   
      e           tp           eg           ep           ev           re           r           rp           p          d             _ENV        @$                                        )      *   0   *   0             _ENV 