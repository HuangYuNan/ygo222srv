LuaR  

             @ e   
@ @ e@  
@  @ e  
@ @ eΐ  
@  @ e  
@ @ e@ 
@  @ e 
@     	   c9990803    initial_effect 
   confilter    handcon    filter    target 	   activate 	   synlimit           /   F @ G@ΐ    ] ΐ Α@ FA A@@Α A @ΐΑ B @@Β B @ΐΒ C AC@Γ C ΑC@ D   @ @ @@ΐ    Μ@AFAD έ@Μ@BFD έ@ΜΐDFC GΕέ@Μ D @ έ@        Effect    CreateEffect    SetCategory    CATEGORY_TODECK    CATEGORY_SPECIAL_SUMMON    SetType    EFFECT_TYPE_ACTIVATE    SetProperty    EFFECT_FLAG_CARD_TARGET    SetCode    EVENT_FREE_CHAIN 
   SetTarget 	   c9990803    target    SetOperation 	   activate    RegisterEffect    EFFECT_TYPE_SINGLE    EFFECT_TRAP_ACT_IN_HAND    SetCondition    handcon             @$ /                                                         	   	   	   	   
   
   
   
                                                                        c     /      e1    /      e2 !   /         _ENV           L @ Ζ@@ ][   ΐ L@ Ζΐ@ ]T  _          IsType    TYPE_MONSTER    IsRace 
   RACE_WYRM             @$                                           c              _ENV           F @ G@ΐ @ ΐ@Μ A έ Μ@Αέ A AΑ   ] XΐΑ   C@  C  _          Duel    GetMatchingGroupCount 	   c9990803 
   confilter    GetHandler    GetControler    LOCATION_GRAVE                     @$                                                                e              _ENV        %    @     @@ @    @ΐ@  AΜ@A έ A XΐAΐΐ@  Bΐ  A AΑ  ΑΑ Β AΒ  ΑB  LCA ]   @ @              IsAbleToDeck    IsType    TYPE_MONSTER    Duel    GetLocationCount 	   GetOwner    LOCATION_MZONE             IsPlayerCanSpecialSummonMonster    RcA    @Τ@       @      `A      @@      @            @$ %                                                                                                                        c     %      tp     %         _ENV    %   
 J   [  @ B@ΐ     ΐΓ@   AΐBA AΖ@ ΗBΐ  FΓ@ Γ@ ΑΓ   @    BA BΖBB   FB B BA ΒBΐ @ C@@ Γ@ ΖΓ@ Δ AΔ   ΐ  ΖBA ΗΓ FCC  ΑΓ  A έBΖBA ΗΓ FC   ΑΓ  A έBΖBA ΗΓ FΓC   ΑΓ  A έB     	   c9990803    filter    IsLocation    LOCATION_GRAVE            Duel    IsExistingTarget       π?   Hint    HINT_SELECTMSG    HINTMSG_TODECK    SelectTarget    SetOperationInfo    CATEGORY_TODECK    CATEGORY_TOKEN    CATEGORY_SPECIAL_SUMMON             @$ J                                                                                                            !   !   !   !   !   !   !   !   !   !   !   !   !   "   "   "   "   "   "   "   "   "   #   #   #   #   #   #   #   #   #   $   $   $   $   $   $   $   $   $   %         e     J      tp     J      eg     J      ep     J      ev     J      re     J      r     J      rp     J      chk     J      chkc     J      g .   J         _ENV &   I       @  FB@ GΐΒ  ΖA ]LBΑΖA ΗΒΑ  @  ]LΒ] [B      BΒ ΜΒέ C@ ΓB@  Α DC Xΐ@@C@ C@ΓC Xΐ@ΐC@ D@ C ΑΓ   AΔ  Δ  Α Ε A E ΐ C      C@ EC C@ ΓE@ C FC@ GΖ ΑΓ    @  Γ  EF ]C FF GΓΖ ] ΗDG CΗΔG CΘDH CΘΔH ICCΙ  CΙΔI JCCJ C
 ΑΓ
  Λ@Δ  AD Δ
 !K ΕK
@ ΕΕXΐ@
@LE ΖΕI ΝΚL AΖ
 Ζ  ΐ E   ΓJ ΔϊΟΓΜΐψD@ MD   5      GetHandler    Duel    GetChainInfo            CHAININFO_TARGET_CARDS    Filter    Card    IsRelateToEffect 	   GetFirst    GetRace 	   GetOwner    SendtoDeck        @   REASON_EFFECT    GetLocationCount    LOCATION_MZONE     IsPlayerCanSpecialSummonMonster    RcA    @Τ@      `A      @@      @   BreakEffect    CreateToken    SpecialSummonStep    POS_FACEUP_DEFENSE    Effect    CreateEffect    SetType    EFFECT_TYPE_SINGLE    SetProperty    EFFECT_FLAG_CANNOT_DISABLE    SetCode "   EFFECT_CANNOT_BE_SYNCHRO_MATERIAL 	   SetValue 	   c9990803 	   synlimit 	   SetLabel 	   SetReset    RESET_EVENT      ΰA   RegisterEffect      ΰ@      π?      0A      @   bit    band    RegisterFlagEffect    `RcA   EFFECT_FLAG_CLIENT_HINT       0@   SpecialSummonComplete             @$    '   '   (   (   (   (   (   (   (   (   (   (   (   (   (   )   )   )   *   *   +   +   ,   ,   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   -   -   -   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   /   /   /   0   0   0   0   0   1   1   1   1   1   1   1   1   1   1   2   2   2   2   3   3   3   4   4   4   5   5   5   6   6   6   6   7   7   7   8   8   8   8   9   9   9   ;   <   =   =   >   >   >   >   ?   ?   ?   ?   ?   ?   ?   ?   @   @   @   @   @   @   @   @   @   @   B   >   E   E   G   G   G   I         e           tp           eg           ep           ev           re           r           rp           c          tc          race          tkp          token ?         e1 M         val e         level f         (for index) k         (for limit) k         (for step) k         i l            _ENV J   M       [@  @       ΐ A@                IsRace 	   GetLabel            @$    K   K   K   K   L   L   L   L   L   L   M         e           c                   @$                                           %      &   I   &   J   M   J   M             _ENV 