LuaR  

             @ e   
@ @ e@  
@  @ e  
@ @ eΐ  
@      	   c9990001    initial_effect    filter    target 
   operation           %   F @ G@ΐ    ]@ F@ Gΐΐ    ]  Α AA FA A@ΐΑ B @@Β B @ΐΒ  @@Γ C @ΐΓ D AD@Δ D ΑD@ E   @        aux    EnablePendulumAttribute    Effect    CreateEffect    SetCategory    CATEGORY_DISABLE    CATEGORY_CONTROL    SetType    EFFECT_TYPE_IGNITION    SetProperty    EFFECT_FLAG_CARD_TARGET    SetCountLimit       π?	   SetRange    LOCATION_PZONE 
   SetTarget 	   c9990001    target    SetOperation 
   operation    RegisterEffect             @$ %                                                   	   	   	   
   
   
                                                      c     %      e1    %         _ENV        '    @ A@    @      @ΐ@   @      @A      A ΐAΜ B έ AB XBΐB  X@ ΐ  C  @ @              IsLocation    LOCATION_SZONE    IsControler    GetSequence       @	   IsFaceup    bit    band    GetOriginalType    TYPE_PENDULUM            GetControler    IsAbleToChangeControler             @$ '                                                                                                                              c     '      tp     '         _ENV        
 [   [  @ΐC@   ΐ @ Β@ΐ   AΐBA AΖ@ ΗΒΐ  FΓA C@ Α   @    @BA BBΐ B AΓ  B  @BA BBΐ B A   BA BCΖC   FΓC GΔC Α ]B  BA Dΐ @ Γ@@ ΓA ΖC@  A   ΐ  ΖBA ΗΒΔ FE  Α  A έBΜBEέ ΜΕέ C   ΖBA ΗΒΔ FΓE  Α  A έB        IsLocation    LOCATION_ONFIELD 	   c9990001    filter            Duel    IsExistingTarget    LOCATION_MZONE       π?   CheckLocation    LOCATION_SZONE       @      @   Hint    HINT_SELECTMSG    aux 	   Stringid     ξcA   SelectTarget    SetOperationInfo    CATEGORY_DISABLE 	   GetFirst    GetControler    CATEGORY_CONTROL             @$ [                                                                                                                                                                                                                                                                                           e     [      tp     [      eg     [      ep     [      ev     [      re     [      r     [      rp     [      chk     [      chkc     [      g A   [         _ENV !   9    h   @ B@ L@ ] Βΐ        Β@     @A   B   @ BAΐ A AΓ  B  ΐ@ BAΐ A A     BBA    @ Bΐ  B@ ΒBΐ   @ A ΖC  X@Cΐ
C ΒCΐ ΜDFCD έBΜDFΓD έBΜEFCE MΕέBΜΒE@ έBΜFέ ΔCF CΓECΖ LDΖF ]CLΓFΑ ]CLΓEΐ ]CLF] ΔDG CΓE C        Duel    GetFirstTarget    GetHandler    IsRelateToEffect    IsImmuneToEffect    CheckLocation    LOCATION_SZONE       @      @   IsLocation    Overlay    MoveToField    POS_FACEUP            Effect    CreateEffect    SetType    EFFECT_TYPE_SINGLE    SetCode    EFFECT_DISABLE 	   SetReset    RESET_EVENT      ΰA   RegisterEffect    Clone    EFFECT_DISABLE_EFFECT    EFFECT_CHANGE_LSCALE 	   SetValue        @   EFFECT_CHANGE_RSCALE             @$ h   "   "   "   #   #   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   &   &   &   &   &   &   &   &   &   &   '   '   '   '   '   '   '   '   '   '   '   (   (   (   (   )   )   )   *   *   *   +   +   +   +   ,   ,   ,   -   -   .   .   .   /   /   /   0   0   1   1   1   2   2   2   3   3   3   4   4   5   5   5   6   6   6   9         e     h      tp     h      eg     h      ep     h      ev     h      re     h      r     h      rp     h      tc    h      c    h      e1 ?   g      e1 N   g      e3 V   g      e4 a   g         _ENV        @$                                !   9   !   9             _ENV 