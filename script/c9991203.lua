LuaR  

             @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@        require    expansions/script/c9990000 	   c9991203    initial_effect    Dazz_name_godra 	   spfilter 	   thfilter       ;    D   F @ G@ΐ    ]@ F@ Gΐΐ    ]  Α AA @Α ΑA @ Β AB @Β Α A @ @Γ %  @Γ %A  @ΐΓ %  @ D   @@ ΐ@ΐ    Μ AFAD έ@ΜAFD ΑD Mέ@Μ EFAE έ@Μ BA έ@ΜBAΑ Α έ@ Μ FeΑ  έ@ΜCe έ@ΜΐCeA έ@Μ D @ έ@        Dazz    GodraMainCommonEffect    Effect    CreateEffect    SetCategory    CATEGORY_SPECIAL_SUMMON    SetType    EFFECT_TYPE_IGNITION 	   SetRange    LOCATION_HAND    SetCountLimit       π?   0ͺsA   SetCost 
   SetTarget    SetOperation    RegisterEffect    CATEGORY_TOHAND    EFFECT_TYPE_FIELD    EFFECT_TYPE_TRIGGER_O    SetCode    EVENT_SPSUMMON_SUCCESS      ΐo@   0|A   SetCondition          	     @ LB@ ] Lΐ^ _  FΒ@ GΑB@  ΖBA ]B                GetHandler    IsAbleToGraveAsCost    Duel    SendtoGrave    REASON_COST             @$                                              	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV       	 #    @FB@ Gΐ ΖΒ@ ]@ FB@ GΑBA Aΐ ΓA FΓA  Δ     @ ]@ CB  C _ FB@ GBΒ  ΖB   A  ΖΓA ]B                Duel    GetLocationCount    LOCATION_MZONE    IsExistingMatchingCard 	   c9991203 	   spfilter    LOCATION_GRAVE       π?   SetOperationInfo    CATEGORY_SPECIAL_SUMMON             @$ #                                                                                                            	      e     #      tp     #      eg     #      ep     #      ev     #      re     #      r     #      rp     #      chk     #         _ENV        3   @ B@@ @ ΐ@    @ AFBA  ΖA B @ ΒA@ B BBΐ B FB Γ ΑΓ   @   LC] @@F@ GBΓ ]B F@ GΓ ΑΒ    @  Γ ΔC ]B LD] LBΔ]B         Duel    GetLocationCount    LOCATION_MZONE            Hint    HINT_SELECTMSG    HINTMSG_SPSUMMON    SelectMatchingCard 	   c9991203 	   spfilter    LOCATION_GRAVE       π?	   GetCount    HintSelection    SpecialSummon    POS_FACEUP_DEFENSE 	   GetFirst    CompleteProcedure             @$ 3                                                                                                                                                            	      e     3      tp     3      eg     3      ep     3      ev     3      re     3      r     3      rp     3      g    3         _ENV &   +        @₯  ΑB    L@ ]         	   IsExists       π?   GetHandler    '   *        @  ά  @Μ@@@ έΫ    Ζ@ Ηΐΐ   έ Ϋ   Ζ A Η@ΑA  FΑA έΑA X   Γ@  Γ  ί          GetMaterial    IsContains    Dazz    IsGodra    bit    band    GetSummonType    SUMMON_TYPE_FUSION             @$    (   (   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   *         c           mc           mg             _ENV         @$    '   '   '   *   *   *   *   *   '   *   +         e           tp           eg           ep           ev           re           r           rp              _ENV ,   0   	 (    @@FB@ GΐΒ@ Aΐ C AC   ]  ΐ  CB  C _ FB@ GΑΒ@ Aΐ C AC   ΐ  ΔA  B ]  B@ BBΑ  B @Γ Α    B                Duel    GetMatchingGroupCount 	   c9991203 	   thfilter       H@   GetMatchingGroup    GetHandler    GetCode    SetOperationInfo    CATEGORY_TOHAND       π?            @$ (   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   .   .   .   .   .   .   .   .   .   .   .   .   .   .   /   /   /   /   /   /   /   /   /   0   
      e     (      tp     (      eg     (      ep     (      ev     (      re     (      r     (      rp     (      chk     (      sg    (         _ENV 1   9    &   @ B@F@ GΒΐ Α  D     @LBA] XΑ@F@ GΒΑB ΐ CB ]B LBΐ Γ AΓ   ] @ CΐB @ BCΐ  FC B         Duel    GetMatchingGroup 	   c9991203 	   thfilter       H@	   GetCount            Hint    HINT_SELECTMSG    HINTMSG_ATOHAND    Select       π?   HintSelection    SendtoHand    REASON_EFFECT             @$ &   2   2   2   2   2   2   2   2   2   3   3   3   3   3   3   4   4   4   4   4   4   5   5   5   5   5   5   6   6   6   6   7   7   7   7   7   7   9   
      e     &      tp     &      eg     &      ep     &      ev     &      re     &      r     &      rp     &      sg 	   &      rg    %         _ENV         @$ D                                             	   	   	   
   
   
   
                                                       !   !   !   "   "   "   "   "   #   #   #   $   $   $   %   %   %   %   &   +   &   ,   0   ,   1   9   1   :   :   :   ;         c     D      e1    D      e2 %   D         _ENV =   ?    
   Ζ @ Η@ΐ   έ Ϋ   Μ@ FΑ@ έΫ@  ΐΜ A @ A ΐ  C έ@ Γ@  Γ  ί          Dazz    IsGodra    IsHasEffect    EFFECT_NECRO_VALLEY    IsCanBeSpecialSummoned                     @$    >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   ?         c           e           tp              _ENV @   G    "   L @ Ζ@@ ][   ΐL@ Ζΐ@ ][    C   _  @L A ] [   @ C   _  L@A ΖA ][   ΐLΐA ] [   ΐ L B Α@ ]T  _    
      IsLocation    LOCATION_GRAVE    IsHasEffect    EFFECT_NECRO_VALLEY    IsFacedown    IsType    TYPE_MONSTER    IsAbleToHand    IsCode    `cA            @$ "   A   A   A   A   A   B   B   B   B   B   B   B   B   D   D   D   D   D   D   F   F   F   F   F   F   F   F   F   F   F   F   F   F   G         c     "         _ENV        @$                ;      <   <   =   ?   =   @   G   @   G             _ENV 