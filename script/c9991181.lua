LuaR  

         
    @ A@  @ @ e   
@@ e@  
@         require    script/c9991100 	   c9991181    initial_effect    exilefilter       K       F @ G@ΐ    ] ΐ Α@ @ Α AA @Α %  @ΐΑ %A  @ Β %  @@B   @  
      Effect    CreateEffect    SetType    EFFECT_TYPE_ACTIVATE    SetCode    EVENT_FREE_CHAIN    SetCost 
   SetTarget    SetOperation    RegisterEffect          	 (   F@ GBΐ Α  Γ@ ] @Α Y  B    @ BAΖA   FΓA B Β  AC C Δ   @ @ BΐB @ ΒBΐC FCC CB        Duel    GetFieldGroup            LOCATION_REMOVED 	   GetCount    Hint    HINT_SELECTMSG    HINTMSG_TOGRAVE    Select       π?   HintSelection    SendtoGrave    REASON_COST    REASON_RETURN             @$ (   	   	   	   	   	   	   
   
   
   
   
   
   
   
   
                                                                              
      e     (      tp     (      eg     (      ep     (      ev     (      re     (      r     (      rp     (      chk     (      g    (         _ENV    7   	 &  F@ GBΐ@ Γ ]@ Δ@FA GDΑ ΖA A AΕ   \X@LΒΖDB ][  ΐLΒΖΔB ][  F@ GΓ ] @ CD  C @ DC	ΐ A  ΔC D	ΐ  @ D   C@άD  άD  ΐ 	ί Α   [D   D  @ ED
@ D ΕDΑ    ΝΔA
  [  D   D  @ ED
@ D ΕDΑ Ζ   ΝDE
ΐ  D   [D  @ ED
@ D ΕDΑ F   ΝE
  ΐ[  @D  ΐ@ ED
@ D ΕDΑ  ΖD ΗΕΔ AΖ έ  ΝΔA
 [  ΐ  @D  ΐ@ ED
@ D ΕDΑ Ζ ΖD ΗΕΔ AF έ  ΝDE
     [D  @ ED
@ D ΕDΑ  ΖD ΗΕΔ AF έ  ΝΔA
@Ε	ΐΑ @  ΐ[  @  ΐ@ ED
@ D ΕDΑ  ΖD ΗΕΔ AΖ έD ΖDA F   ΝΔA
ΕE 	EF  EF
 ΖF ΝΕΖG ΝFG AΖ  ΖD ΗΖΔ NΗΑ	έE  ΐΑ	@G ΕG E@ H
FA GEΑ
 ΖA A D   F@ GEΘ
 ΖΕG   
AΖ  Α ]Eΐ
@Ε	 G H E@ ΕH
@ E @ EH
A H ΐ Ζ A  E Ε	G I ΖEI ΕE@ EH
A EI Δ  Ζ A  E@ EH
A I Δ  Ζ A  E  &      Duel    CheckEvent    EVENT_CHAINING    IsExistingMatchingCard 	   c9991181    exilefilter    LOCATION_MZONE       π?   IsActiveType    TYPE_SPELL 
   IsHasType    EFFECT_TYPE_ACTIVATE    IsChainNegatable    GetLocationCount            Dazz    IsCanCreateEldraziScion    SelectOption    aux 	   Stringid     cA       @      @	   SetLabel    GetHandler    RegisterFlagEffect    RESET_EVENT      ΰA   RESET_CHAIN    EFFECT_FLAG_CLIENT_HINT    SetCategory    CATEGORY_REMOVE    GetMatchingGroup    SetOperationInfo    CATEGORY_NEGATE    SetTargetParam    CATEGORY_SPECIAL_SUMMON    CATEGORY_TOKEN             @$ &                                                                                                                                                                                                                                                                                                                                                                                                                                      !   !   !   !   !   !   !   !   !   !   !   !   !   !   !   !   "   "   "   "   "   "   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   $   $   $   $   %   %   %   %   %   %   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   (   (   (   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   *   *   +   +   +   ,   ,   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   -   -   -   -   -   -   .   .   /   /   /   0   0   0   0   1   1   1   1   1   1   1   1   1   1   2   2   3   3   3   3   3   4   4   4   4   4   4   4   4   4   5   5   5   5   5   5   5   5   5   7         e     &     tp     &     eg     &     ep     &     ev     &     re     &     r     &     rp     &     chk     &     ex    &     eg2    &     ep2    &     ev2    &     re2    &     r2    &     rp2    &     v1 2   &     v2 2   &     v3 2   &     sel ;   &     sg ο   ψ         _ENV 8   I    R   @  @@ F@ GΒΐA BAΐ A FA   ] @ ΒAΖB   FCB B Β  AC  C  Δ   @ @ ΒBΐB @ CΐCC FC B ΐ
ΐC@F@ GΔB ΖD ]@ ΒDΐB ΐ E@F@ GBΕ ΖA ]@ΐ    FE GΒΕ ] [B      FE GΖ  ΐ ]@ BFΐC @  Γ    FDC B      	   GetLabel       π?   Duel    GetMatchingGroup 	   c9991181    exilefilter    LOCATION_MZONE    Hint    HINT_SELECTMSG    HINTMSG_REMOVE    Select    HintSelection    Remove    POS_FACEUP    REASON_EFFECT        @   GetChainInfo            CHAININFO_TARGET_PARAM    NegateActivation       @   GetLocationCount    Dazz    IsCanCreateEldraziScion    CreateEldraziScion    SpecialSummon             @$ R   9   9   :   :   ;   ;   ;   ;   ;   ;   ;   ;   ;   <   <   <   <   <   <   =   =   =   =   =   =   =   >   >   >   >   ?   ?   ?   ?   ?   ?   ?   @   @   A   A   A   A   A   B   B   B   B   B   C   C   D   D   D   D   D   D   D   D   E   E   E   E   E   E   E   F   F   F   F   F   G   G   G   G   G   G   G   G   G   G   I         e     R      tp     R      eg     R      ep     R      ev     R      re     R      r     R      rp     R      sel    R      sg    $      ev2 ,   0      token G   Q         _ENV         @$                                              7      8   I   8   J   J   J   K         c           e1             _ENV L   N       L @ ] [@  ΐL@@ Α  ][@   Lΐ@ Α  ]_          IsFacedown    IsAttackBelow      @@   IsDefenseBelow            @$    M   M   M   M   M   M   M   M   M   M   M   M   M   N         c                   @$ 
               K      L   N   L   N             _ENV 