LuaR  

             @ A@  @ @ e   
@@ e@  
@ @ e  
@@ eΐ  
@         require    expansions/script/c9990000 	   c9991221    initial_effect    filter    target 	   activate              F @ G@ΐ    ] ΐ Α@ FA A@@Α A @ΐΑ B @@Β B ΑB@ Γ B AC@C   @        Effect    CreateEffect    SetCategory    CATEGORY_TOHAND    CATEGORY_SEARCH    SetType    EFFECT_TYPE_ACTIVATE    SetCode    EVENT_FREE_CHAIN 
   SetTarget 	   c9991221    target    SetOperation 	   activate    RegisterEffect             @$                                                 	   	   	   	   
   
   
   
                     c           e1             _ENV        
   L @ ] [   ΐ F@@ Gΐ    ] _          IsAbleToHand    Dazz    IsGodra             @$ 
                                       c     
         _ENV       	     @FB@ GΐΒ@ Aΐ CA A   Δ  ^_  FB@ GΒΑ  ΖB   A  ΖCA ]B  	              Duel    IsExistingMatchingCard 	   c9991221    filter    LOCATION_DECK       π?   SetOperationInfo    CATEGORY_TOHAND             @$                                                                         	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV        "   @ B@F@  ΖΒ@ B @ A@ BA Aΐ ΓA A C ΑC   B   F@ GΒΒ Δ  C ]B F@ GBΓBΐ ]B        Duel    Hint    HINT_SELECTMSG    HINTMSG_ATOHAND    SelectMatchingCard 	   c9991221    filter    LOCATION_DECK               π?	   GetFirst    SendtoHand    REASON_EFFECT    ConfirmCards             @$ "                                                                                                         	      e     "      tp     "      eg     "      ep     "      ev     "      re     "      r     "      rp     "      g    "         _ENV        @$                                                              _ENV 