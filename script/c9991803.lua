LuaR  

             @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@@ eΐ  
@ @ e  
@  
      require    script/c9990000 	   c9991803    initial_effect    Dazz_name_sliver    Sliver_General_Effect    cost    target 
   operation              F @ G@ΐ    Α  Α  ]@         Dazz    SliverCommonEffect       @   `ΟcA            @$                               c              _ENV        ,   F @ G@ΐ    ] ΐ Α@ AAA  @  ΐΑ B @@Β B @ΐΒ C FAC A@Γ ΑC @ Δ A @Δ ΑD E@@Ε ΑD E@ΐΕ ΑD F@@F   @        Effect    CreateEffect    SetDescription    aux 	   Stringid    `ΟcA           SetCategory    CATEGORY_DESTROY    SetType    EFFECT_TYPE_IGNITION    SetProperty    EFFECT_FLAG_UNCOPYABLE    EFFECT_FLAG_CARD_TARGET 	   SetRange    LOCATION_MZONE    SetCountLimit       π?   SetCost 	   c9991803    cost 
   SetTarget    target    SetOperation 
   operation    RegisterEffect             @$ ,               	   	   	   	   	   	   	   
   
   
                                                                                                   c     ,      e1    ,         _ENV       	 .   L@ ] @@ΐ   @Β@ AΖBA Ηΐ  FA C  ΑΓ   Β@ BΖBB   FB B Β@ ΒBΐ CA @@ A ΑC  Δ AΔ ΜC@έBΖΒ@ ΗBΓ  FC έB        GetHandler            IsReleasable    Duel    IsExistingMatchingCard    Card    LOCATION_ONFIELD       π?   Hint    HINT_SELECTMSG    HINTMSG_RELEASE    SelectMatchingCard    AddCard    Release    REASON_COST             @$ .                                                                                                                                                   e     .      tp     .      eg     .      ep     .      ev     .      re     .      r     .      rp     .      chk     .      c    .      g %   .         _ENV    %   
 Y   [  ΐΐ   Bΐ    ΐC  AΐBA  AΓ   ΐB BBΐ Γ BB ΒBΖC ΗBΐ  A CC ΑΓ    @ B    B CΖΒC CLD ] B  B CΖBD   FD B B ΒDΐ C C@@  ΖCC Δ  AΔ    ΖB ΗΕ FCE  ΑΓ   A έBΖB ΗΕ  AΓ ΓE ΖF ΓΑ Δ  έB      
   IsOnField    IsDestructable    IsControler       π?           GetHandler    IsHasEffect    `ΟcA   Duel    GetFlagEffect        @   IsExistingTarget    Card    LOCATION_ONFIELD    Hint    HINT_OPSELECTED    GetDescription    HINT_SELECTMSG    HINTMSG_DESTROY    SelectTarget    SetOperationInfo    CATEGORY_DESTROY    RegisterFlagEffect    RESET_PHASE 
   PHASE_END             @$ Y                                                                                                                                                                   !   !   !   !   !   !   "   "   "   "   "   "   "   "   "   "   "   "   #   #   #   #   #   #   #   #   #   $   $   $   $   $   $   $   $   $   $   %         e     Y      tp     Y      eg     Y      ep     Y      ev     Y      re     Y      r     Y      rp     Y      chk     Y      chkc     Y      g E   Y         _ENV &   +       @ B@ L@ΐ  ][  @LΒ@] B  F@ GBΑ ΖA ]B        Duel    GetFirstTarget    IsRelateToEffect    GetControler       π?   Destroy    REASON_EFFECT             @$    '   '   '   (   (   (   (   (   (   (   (   (   (   )   )   )   )   )   +   	      e           tp           eg           ep           ev           re           r           rp           tc             _ENV        @$                                                 %      &   +   &   +             _ENV 