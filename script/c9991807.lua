LuaR  

             @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@@ eΐ  
@ @ e  
@  
      require    script/c9990000 	   c9991807    initial_effect    Dazz_name_sliver    Sliver_General_Effect 
   condition    target 
   operation              F @ G@ΐ    Α  Α  ]@         Dazz    SliverCommonEffect       @   ΰΟcA            @$                               c              _ENV        '   F @ G@ΐ    ] ΐ Α@ AAA  @  ΐΑ B @@Β B @ΐΒ C @@Γ  @ΐΓ D AD@Δ D ΑD@ Ε D AE@E   @        Effect    CreateEffect    SetDescription    aux 	   Stringid    ΰΟcA           SetCategory    CATEGORY_DRAW    SetType    EFFECT_TYPE_IGNITION 	   SetRange    LOCATION_MZONE    SetCountLimit       π?   SetCondition 	   c9991807 
   condition 
   SetTarget    target    SetOperation 
   operation    RegisterEffect             @$ '               	   	   	   	   	   	   	   
   
   
                                                                                    c     '      e1    '         _ENV           @  B@@           GetHandler    IsPosition    POS_FACEUP_ATTACK             @$                               e           tp           eg           ep           ev           re           r           rp              _ENV       	 <    @LB@ ] LΐΑΒ  ][  FA GBΑ ΑΒ  ]Α@FA GΒΑ Α ]@ CB  C _ FA GBΒB ΞB ΓB  ]B  FA GΓ ΑΒ  CC FC CA   ]B FA GΒΓ ]B FA GΔ ]B FA GBΔ  ΖD   A   Α ]B                GetHandler    IsHasEffect    ΰΟcA   Duel    GetFlagEffect        @   IsPlayerCanDraw       π?   Hint    HINT_OPSELECTED    GetDescription    RegisterFlagEffect    RESET_PHASE 
   PHASE_END    SetTargetPlayer    SetTargetParam    SetOperationInfo    CATEGORY_DRAW             @$ <                                                                                                                                                                                       	      e     <      tp     <      eg     <      ep     <      ev     <      re     <      r     <      rp     <      chk     <         _ENV    ,    ?   @ B@A  Β@ ΖA Β @ BAΐ  FA  @    ΒA  ΜB@  έΫ   ΜBBFB έΫB      Ζ@ ΗΒΒ  FC έBΖBC ΗΓ  έ ΓΓD CDΑ   C  ΓΔE CCΕE CΓΕF ΖCF ΓCΖΓF GCCGC        Duel    GetChainInfo            CHAININFO_TARGET_PLAYER    CHAININFO_TARGET_PARAM    Draw    REASON_EFFECT    GetHandler    IsRelateToEffect    IsPosition    POS_FACEUP_ATTACK    ChangePosition    POS_FACEUP_DEFENSE    Effect    CreateEffect    SetDescription    aux 	   Stringid     ΟcA   SetType    EFFECT_TYPE_SINGLE    SetCode    EFFECT_CANNOT_CHANGE_POSITION    SetProperty    EFFECT_FLAG_CANNOT_DISABLE    EFFECT_FLAG_CLIENT_HINT 	   SetReset    RESET_EVENT      ΰA   RegisterEffect             @$ ?                           !   !   !   !   !   !   !   !   !   "   "   #   #   #   #   #   #   #   #   #   #   #   $   $   $   $   $   %   %   %   %   &   &   &   &   &   &   &   '   '   '   (   (   (   )   )   )   )   )   *   *   *   *   +   +   +   ,         e     ?      tp     ?      eg     ?      ep     ?      ev     ?      re     ?      r     ?      rp     ?      p    ?      d    ?      c    ?      e1 %   ?         _ENV        @$                                                          ,      ,             _ENV 