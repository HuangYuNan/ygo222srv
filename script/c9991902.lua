LuaR  

         $    @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@@ eΐ  
@ @ e  
@@ e@ 
@ @ e 
@@ eΐ 
@ @ e  
@@ e@ 
@         require    script/c9990000 	   c9991902    initial_effect    Dazz_name_inheritor       π?   thcon 	   thfilter    thtg    thop    drcon    drtg    drop    thtg2    thop2 
      %    p   F @ G@ΐ    Α  ]@Fΐ@ G Α    ]@ F@A GΑ    ] ΐΑ B FAB A@Β ΑB FC A@@Γ C FΑC A@ Δ AD @Δ ΑD E@@Ε ΑD E@ΐΕ ΑD F@@F   @@A Aΐ    ΜΐAFF έ@ΜBFΑB C Mέ@Μ@CFΑF ΑC Mέ@Μ DFAD έ@ΜDFΑD GΗέ@Μ@EFΑD GAΗέ@ΜΐEFΑD GΗέ@Μ@F @ έ@Ζ@A ΗΑ   έ ΑΑB AΒΑG AAΓH AAΘ AΑΘI AAΕΑD AIAΑΕΑD IAAF A  '      Dazz    InheritorCommonEffect        @   aux    EnablePendulumAttribute    Effect    CreateEffect    SetCategory    CATEGORY_TOHAND    CATEGORY_SEARCH    SetType    EFFECT_TYPE_SINGLE    EFFECT_TYPE_TRIGGER_O    SetProperty    EFFECT_FLAG_DAMAGE_STEP    EFFECT_FLAG_DELAY    SetCode    EVENT_SPSUMMON_SUCCESS    SetCondition 	   c9991902    thcon 
   SetTarget    thtg    SetOperation    thop    RegisterEffect    CATEGORY_DRAW    EFFECT_FLAG_PLAYER_TARGET    drcon    drtg    drop    EFFECT_TYPE_IGNITION    EFFECT_FLAG_CARD_TARGET    SetCountLimit       π?	   SetRange    LOCATION_PZONE    thtg2    thop2             @$ p                                          	   	   	   	   	   
   
   
   
   
                                                                                                                                                                                                                                    !   !   !   "   "   "   "   #   #   #   #   $   $   $   %         c     p      e1    p      e2 2   p      e3 U   p         _ENV '   )       @  B@@           GetHandler    IsPreviousLocation    LOCATION_HAND             @$    (   (   (   (   (   (   )         e           tp           eg           ep           ev           re           r           rp              _ENV *   ,       L @ Ζ@@ ][   @L@ ] [   @Fΐ@ G Α    ] [   ΐ L@A ΖA ]T  _          IsType    TYPE_MONSTER    IsAbleToHand    Dazz    IsInheritor    IsHasEffect    EFFECT_NECRO_VALLEY             @$    +   +   +   +   +   +   +   +   +   +   +   +   +   +   +   +   +   +   +   +   ,         c              _ENV -   0   	     @FB@ GΐΒ@ Aΐ CA A   Δ  ^_  FB@ GΒΑ  ΖB   A  ΖCA ]B  	              Duel    IsExistingMatchingCard 	   c9991902 	   thfilter    LOCATION_DECK       π?   SetOperationInfo    CATEGORY_TOHAND             @$    .   .   .   .   .   .   .   .   .   .   .   .   .   /   /   /   /   /   /   /   /   /   0   	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV 1   8    "   @ B@F@  ΖΒ@ B @ A@ BA Aΐ ΓA A C ΑC   LB] @F@ GΒΒ Δ  C ]B F@ GBΓBΐ ]B        Duel    Hint    HINT_SELECTMSG    HINTMSG_ATOHAND    SelectMatchingCard 	   c9991902 	   thfilter    LOCATION_DECK               π?	   GetCount    SendtoHand    REASON_EFFECT    ConfirmCards             @$ "   2   2   2   2   2   2   3   3   3   3   3   3   3   3   3   3   3   3   4   4   4   4   5   5   5   5   5   5   6   6   6   6   6   8   	      e     "      tp     "      eg     "      ep     "      ev     "      re     "      r     "      rp     "      g    "         _ENV 9   ;       @  B@@           GetHandler    IsPreviousLocation    LOCATION_GRAVE             @$    :   :   :   :   :   :   ;         e           tp           eg           ep           ev           re           r           rp              _ENV <   A   	     @@FB@ Gΐ ΑΒ  ^_  FB@ GΑ ]B FB@ GBΑΒ  ]B FB@ GΑ  ΖΒA   A   ΑΓ  ]B                Duel    IsPlayerCanDraw       π?   SetTargetPlayer    SetTargetParam    SetOperationInfo    CATEGORY_DRAW             @$    =   =   =   =   =   =   =   =   >   >   >   >   ?   ?   ?   ?   @   @   @   @   @   @   @   @   @   A   	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV B   E       @ B@A  Β@ ΖA Β @ BAΐ  FA B         Duel    GetChainInfo            CHAININFO_TARGET_PLAYER    CHAININFO_TARGET_PARAM    Draw    REASON_EFFECT             @$    C   C   C   C   C   C   D   D   D   D   D   D   E   
      e           tp           eg           ep           ev           re           r           rp           p          d             _ENV F   L   
 7   [  ΐΐC@ F@ C  ΐ Β@ Aΐ  @AA ΒAΖΒ@ ΗΑ  F@ C Α     A BBΖB   FΓB B A Cΐ Γ@ A@ @ ΑC  A   ΖA ΗBΓC FC  Α D AD έB        IsLocation    LOCATION_MZONE    LOCATION_GRAVE 	   c9991902 	   thfilter            Duel    IsExistingTarget       π?   Hint    HINT_SELECTMSG    HINTMSG_RTOHAND    SelectTarget    SetOperationInfo    CATEGORY_TOHAND             @$ 7   G   G   G   G   G   G   G   G   G   G   G   G   G   G   H   H   H   H   H   H   H   H   H   H   H   H   H   I   I   I   I   I   I   J   J   J   J   J   J   J   J   J   J   J   J   K   K   K   K   K   K   K   K   K   L         e     7      tp     7      eg     7      ep     7      ev     7      re     7      r     7      rp     7      chk     7      chkc     7      g -   7         _ENV M   S       @  B@  B      @ Β@ LB@ΐ  ][  @F@ GΑ Δ  CA ]B         GetHandler    IsRelateToEffect    Duel    GetFirstTarget    SendtoHand    REASON_EFFECT             @$    N   N   N   N   N   N   N   N   O   O   O   P   P   P   P   P   Q   Q   Q   Q   Q   Q   S   	      e           tp           eg           ep           ev           re           r           rp           tc             _ENV        @$ $               %      &   &   '   )   '   *   ,   *   -   0   -   1   8   1   9   ;   9   <   A   <   B   E   B   F   L   F   M   S   M   S             _ENV 