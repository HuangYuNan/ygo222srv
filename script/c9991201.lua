LuaR  

             @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@@ eΐ  
@   	      require    script/c9990000 	   c9991201    initial_effect    Dazz_name_godra    filter1    filter2 	   tdfilter       N    I   F @ G@ΐ    ]@ F@ Gΐΐ    ]  Α AA AAΑ  @  @Β B @ΐΒ C @@Γ C @ΐΓ  AA @ Δ %  @ΐΔ %A  @ E   @@ ΐ@ΐ    Μ AFAA GΑΑ Α ]έ@  Μ@BFAE E Mέ@ΜΐBFC έ@Μ@CFC έ@ΜΐCA Α έ@ ΜDe  έ@ΜΐDeΑ  έ@Μ E @ έ@        Dazz    GodraMainCommonEffect    Effect    CreateEffect    SetDescription    aux 	   Stringid     cA           SetCategory    CATEGORY_SPECIAL_SUMMON    SetType    EFFECT_TYPE_IGNITION 	   SetRange    LOCATION_HAND    SetCountLimit       π?   ͺsA
   SetTarget    SetOperation    RegisterEffect    CATEGORY_TODECK    CATEGORY_DRAW    |A         	 ;   L@ ] @@@	ΐΓ@   ΐΑ   ΐBΑ   B   A ΒAΐ B X@@@A BBΖB ΗΒΒ  FC C  ΑC @  @   @ B    A CΑB  ΓC D  C ΐ D BA BDΖD CLΓD ] B          GetHandler            IsRace 
   RACE_WYRM    IsCanBeFusionMaterial    IsImmuneToEffect    Duel    GetLocationCount    LOCATION_MZONE    IsExistingMatchingCard 	   c9991201    filter1    LOCATION_HAND       π?   SetOperationInfo    CATEGORY_SPECIAL_SUMMON    LOCATION_EXTRA    Hint    HINT_OPSELECTED    GetDescription             @$ ;                                                                                                                                                                                    
      e     ;      tp     ;      eg     ;      ep     ;      ev     ;      re     ;      r     ;      rp     ;      chk     ;      c    ;         _ENV    .    ³   @  FB@ Gΐ ΖΒ@ ]Z ΑΐL@ ] LBΑΐ  ][   LA] [   LΒAΐ  ][      FB@ GΒBB Bΐ ΓB A  Μ@ έ    @ ][B  ΐFB@ GBΓ ΖΒB  ] B@ BCΐ C A  ΜΒΓέ ΐΜDFCD GΔ Δ  έΫ  ΖB@ ΗΒΔ  έ Ϋ   ΖB@ ΗΕ  AC έΫB  @ΖB@ ΗΕC @έBΖB@ ΗΕC @ έBΖB@ ΗΒΕ  έB   FF GBΖ] B@ FΖΒF   FG B B@ BGΐ CB B@ ΓB Α  A @  ΐ    ΖB@ ΗΕC @ έBΜGL@ ] έB  ΖB@ ΗΖΓF @ ΓG έB ΖB@ ΗBΗ  FCB GΘ ΖC  A  Δ     @  έ CΘ H CC@ ΓH@ I ΖCI ΓΖI ΓCC@ ΓIC C@ J@CJ ΐ   C    ΖJ C CΘ ΓJC   ,      GetHandler    Duel    GetLocationCount    LOCATION_MZONE            IsRelateToEffect    IsCanBeFusionMaterial    IsImmuneToEffect    IsExistingMatchingCard 	   c9991201    filter1    LOCATION_HAND       π?   GetFieldGroup    LOCATION_EXTRA 	   GetCount 	   IsExists    Card    IsFacedown    IsPlayerCanSpecialSummon    IsPlayerAffectedByEffect     ͺMzA   ConfirmCards    ShuffleHand    Group    CreateGroup    Hint    HINT_SELECTMSG    HINTMSG_FMATERIAL    SelectMatchingCard    AddCard    HINTMSG_SPSUMMON    filter2 	   GetFirst    SetMaterial    SendtoGrave    REASON_EFFECT    REASON_MATERIAL    REASON_FUSION    BreakEffect    SpecialSummon    SUMMON_TYPE_FUSION    POS_FACEUP    CompleteProcedure             @$ ³                                                                                                                                                                                                                                                                                           "   "   "   #   #   #   #   #   #   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   %   %   %   %   %   &   &   &   &   '   '   '   '   '   '   (   (   (   (   (   (   (   (   (   (   (   (   (   (   (   )   )   )   )   )   *   *   *   *   *   *   *   *   *   +   +   +   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   .         e     ³      tp     ³      eg     ³      ep     ³      ev     ³      re     ³      r     ³      rp     ³      c    ³      cg1 /   ]      cg2 5   ]      fm `   ³      g1 u   ³      g2    ³         _ENV 7   =   
 4    @ΐB@  @    Β@ Aΐ C   @Β@ AΖΒA ΗΒ  FCB   ΑC    Β@ BΑ  ΓB D  C Α  DB BΒ@ BΑ  C D    ΐ D BΒ@ BCΖC CLD ] B                  GetHandler    IsAbleToDeck    Duel    IsPlayerCanDraw        @   IsExistingMatchingCard 	   c9991201 	   tdfilter    LOCATION_GRAVE    SetOperationInfo    CATEGORY_TODECK    CATEGORY_DRAW    Hint    HINT_OPSELECTED       π?   GetDescription             @$ 4   8   8   8   8   8   8   8   8   8   8   8   8   8   9   9   9   9   9   9   9   9   9   9   9   9   9   :   :   :   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   ;   <   <   <   <   <   <   <   =   
      e     4      tp     4      eg     4      ep     4      ev     4      re     4      r     4      rp     4      chk     4      chkc     4         _ENV >   L    X   @  LB@ΐ  ][  L@] [  FΒ@ GΑ ΑB ][  ΐFΒ@ GΑΒA Bΐ CB A C Δ  ][B      FΒ@ GΒΒC ΐ CC ]B FΒ@ GΓ ΖΒA ΗΒ  FCB  ΑC D D  ]Β@ ΒCΐB Δ  BΒ@ BDΐ  A D BΒ@ ΒD ECE ED  ΓE ΐ Β@ Fΐ B Β@ BFB Β@ Fΐ C FD B         GetHandler    IsRelateToEffect    IsAbleToDeck    Duel    IsPlayerCanDraw        @   IsExistingMatchingCard 	   c9991201 	   tdfilter    LOCATION_GRAVE            Hint    HINT_SELECTMSG    HINTMSG_TODECK    SelectMatchingCard    HintSelection    AddCard    SendtoDeck    REASON_EFFECT    GetOperatedGroup    FilterCount    Card    IsLocation    LOCATION_DECK    ShuffleDeck    BreakEffect    Draw             @$ X   ?   ?   @   @   @   @   @   @   @   @   @   @   @   @   @   @   A   A   A   A   A   A   A   A   A   A   A   A   A   A   A   B   B   B   B   B   B   C   C   C   C   C   C   C   C   C   C   C   C   D   D   D   D   E   E   E   F   F   F   F   F   F   F   G   G   G   G   G   G   G   G   G   G   G   H   H   H   H   J   J   J   K   K   K   K   K   K   L   
      e     X      tp     X      eg     X      ep     X      ev     X      re     X      r     X      rp     X      c    X      g 1   X         _ENV         @$ I                                                         	   	   	   
   
   
                           .      /   /   /   1   1   1   1   2   2   2   2   2   2   2   3   3   3   3   3   4   4   4   5   5   5   6   6   6   6   7   =   7   >   L   >   M   M   M   N         c     I      e1    I      e2 )   I         _ENV P   S       Μ @ FA@ έΫ   @Μ@ έ Ϋ   @Ζΐ@ Η ΑAA A@ ΑA Α B D   ΐ B ΓB@  Γ    έ  ί          IsRace 
   RACE_WYRM    IsCanBeFusionMaterial    Duel    IsExistingMatchingCard 	   c9991201    filter2    LOCATION_EXTRA               π?   Group 
   FromCards    GetHandler             @$    Q   Q   Q   Q   Q   Q   Q   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   S         c           e           tp              _ENV T   V       @ A@@      @ Α@   ΐA  ΖAA   C       A          Dazz    IsGodra    IsType    TYPE_FUSION    IsCanBeSpecialSummoned    SUMMON_TYPE_FUSION    CheckFusionMaterial             @$    U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   U   V         c           e           tp           mg              _ENV W   Y    
   F @ G@ΐ    ] [   @ L@ ] _          Dazz    IsGodra    IsAbleToDeck             @$ 
   X   X   X   X   X   X   X   X   X   Y         c     
         _ENV        @$                N      O   O   P   S   P   T   V   T   W   Y   W   Y             _ENV 