LuaR  

             @ A@  @ @ e   
@@ e@  
@ @ e  
@@ eΐ  
@ @ e  
@        require    expansions/script/c9990000 	   c9990404    initial_effect    cost    filter    target 
   operation           2   L @ ]@ F@@ Gΐ    ε   Α  ]@ F A G@Α    ] Α ΑA FB A@@Β B @ΐΒ C @@Γ C FΑC A@ Δ AD @Δ Α @ Ε AE E@ΐΕ AE F@@Ζ AE F@ΐF   @        EnableReviveLimit    Dazz    AddXyzProcedureLevelFree        @   Effect    CreateEffect    SetCategory    CATEGORY_DESTROY    CATEGORY_DISABLE    SetType    EFFECT_TYPE_QUICK_O    SetCode    EVENT_FREE_CHAIN    SetProperty    EFFECT_FLAG_CARD_TARGET    EFFECT_FLAG_DAMAGE_STEP 	   SetRange    LOCATION_MZONE    SetCountLimit       π?   SetCost 	   c9990404    cost 
   SetTarget    target    SetOperation 
   operation    RegisterEffect              L @ Ζ@@ ][   @L@ ] Xΐΐ   C@  C  _          IsType 	   TYPE_XYZ    GetRank       @            @$                                                 c              _ENV         @$ 2                                       	   	   	   	   	   
   
   
                                                                                                   c     2      e1    2         _ENV       	     @ΐLB@ ] Lΐΐ Γ  FA ^_  LB@ ] LBΑΐ Γ  AΓ  A ]B                 GetHandler    CheckRemoveOverlayCard       π?   REASON_COST    RemoveOverlayCard             @$                                                             	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV           L @ Ζ@@ ][    F@ Gΐΐ  A  Ζ@@ ]@@ X @ C   _  L@A ΖA ][   ΐLΐA ] [   ΐ L B Ζ@B ]T  _    
      IsType    TYPE_EFFECT    bit    band    GetOriginalType    IsPosition    POS_FACEUP    IsDestructable    IsHasEffect    EFFECT_DISABLE             @$                                                                                                       c              _ENV    #   
 C   [  ΐC   ΐΓ@   ΐ A BAΐ  AΒA BΖA ΗBΑ  A Γ@ ΑC      ΒA BBΖB   FΓB B ΒA Cΐ A CA@  ΖΓ@ D  AD    ΖΒA ΗBΓ FC  ΑC   A έBΖΒA ΗBΓ FΓC  ΑC   A έB        IsControler       π?   IsLocation    LOCATION_MZONE 	   c9990404    filter            Duel    IsExistingTarget    Hint    HINT_SELECTMSG    HINTMSG_DESTROY    SelectTarget    SetOperationInfo    CATEGORY_DISABLE    CATEGORY_DESTROY             @$ C                                                                                                                                                               !   !   !   !   !   !   !   !   !   "   "   "   "   "   "   "   "   "   #         e     C      tp     C      eg     C      ep     C      ev     C      re     C      r     C      rp     C      chk     C      chkc     C      g 0   C         _ENV $   9    W   @ B@ L@ ]    Β@   B      ACA       A Ζ@ ΗΒΑ  FB έBΖBB ΗΒ έ ΓΒC CCΓCA CΓΓC DCCDCΔ LCCΖΓD ]CLEΖB ]CLCDΐ ]CF@ GCΕ ΖE ]ΐΕ    FCB GΒ] ΓΒC CCΓF CΓΔC DFDF DFF DCΕΔFCCΔ C        Duel    GetFirstTarget    GetHandler    IsRelateToEffect    IsHasEffect    EFFECT_DISABLE 
   GetAttack    NegateRelatedChain    RESET_TURN_SET    Effect    CreateEffect    SetType    EFFECT_TYPE_SINGLE    SetCode 	   SetReset    RESET_EVENT      ΰA   RegisterEffect    Clone    EFFECT_DISABLE_EFFECT 	   SetValue    Destroy    REASON_EFFECT            EFFECT_UPDATE_ATTACK    RESET_PHASE 
   PHASE_END        @            @$ W   %   %   %   %   %   &   &   &   &   &   &   &   &   '   '   '   '   '   '   (   (   (   (   (   (   (   )   )   )   )   *   *   *   +   +   +   ,   ,   ,   ,   -   -   -   .   .   /   /   /   0   0   0   1   1   1   2   2   2   2   2   2   2   2   3   3   3   3   4   4   4   5   5   5   6   6   6   6   6   6   6   6   7   7   7   8   8   8   9         e     W      tp     W      eg     W      ep     W      ev     W      re     W      r     W      rp     W      tc    W      c    W      val    W      e1    W      e2 -   W      e3 B   W         _ENV        @$                                           #      $   9   $   9             _ENV 