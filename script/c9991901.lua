LuaR  �

         $    @ A@  @ �@ e   
@���@ 
@A��@ e@  
@ ��@ e�  
@���@ e�  
@ ��@ e  
@���@ e@ 
@ ��@ e� 
@���@ e� 
@ ��@ e  
@���@ e@ 
@ � �       require    script/c9990000 	   c9991901    initial_effect    Dazz_name_inheritor       �?   tunerop    costfilter    tgcost 	   thfilter    thtg    thop    drcon    drtg    drop 
      %    	n   F @ G@� �   ��  ]@�F�@ G � �   ]@ F@A G�� �   ]� ��� B FAB A�@���� �B FC A�@��@� �C �@���� D AD�@���D  � �@���� �� �@CFE �@�̀D @ �@��@A ǀ�   ݀ A���E A�����B ��E ��A����F �AB ��A�A��E A�A��D ��FA����D �GA����D �AGA��D ��A�AA �A@  � LAEƁG �G ��]A�L�B�H ]A�LAH�� ]A�L�H�I ]A�LAI�D ǁ�]A�L�F�D ���]A�L�C�D ��]A�L�D � ]A� � )      Dazz    InheritorCommonEffect        @   aux    EnablePendulumAttribute    Effect    CreateEffect    SetProperty    EFFECT_FLAG_CANNOT_DISABLE    EFFECT_FLAG_DELAY    SetType    EFFECT_TYPE_SINGLE    EFFECT_TYPE_CONTINUOUS    SetCode    EVENT_SUMMON_SUCCESS    SetOperation 	   c9991901    tunerop    RegisterEffect    Clone    EVENT_SPSUMMON_SUCCESS    SetCategory    CATEGORY_DRAW    EFFECT_TYPE_TRIGGER_O    EFFECT_FLAG_PLAYER_TARGET    SetCondition    drcon 
   SetTarget    drtg    drop    CATEGORY_TOHAND    CATEGORY_SEARCH    EFFECT_TYPE_IGNITION    SetCountLimit       �?	   SetRange    LOCATION_PZONE    SetCost    tgcost    thtg    thop             @$ n                                          	   	   	   	   	   
   
   
   
   
                                                                                                                                                                                                                           !   !   !   !   "   "   "   "   #   #   #   #   $   $   $   %         c     n      e1    n      e2 #   n      e3 -   n      e4 P   n         _ENV '   0   	    L@ ]� LB�Ƃ@ ]��[  ��F�@ G��@ � ]�  �B��A �B����B �B��B��B �B�B���CC �B��@ �� ��C ��B� �       GetHandler    IsPreviousLocation    LOCATION_HAND    Effect    CreateEffect    SetType    EFFECT_TYPE_SINGLE    SetCode    EFFECT_ADD_TYPE 	   SetReset    RESET_EVENT      �A	   SetValue    TYPE_TUNER    RegisterEffect             @$    (   (   (   (   (   (   (   )   )   )   )   )   *   *   *   +   +   +   ,   ,   ,   ,   -   -   -   .   .   .   .   .   0   
      e           tp           eg           ep           ev           re           r           rp           chk           e1             _ENV 1   3    
   L @ ]� [   � �F@@ G�� �   ]� _   �       IsDiscardable    Dazz    IsInheritor             @$ 
   2   2   2   2   2   2   2   2   2   3         c     
         _ENV 4   7   	     @��FB@ G����@ �A�� CA A  �� ��A � ^  _  FB@ G��� ��@ ��� A� �CB ƃB ��]B  �               Duel    IsExistingMatchingCard 	   c9991901    costfilter    LOCATION_HAND       �?   GetHandler    DiscardHand    REASON_COST    REASON_DISCARD             @$    5   5   5   5   5   5   5   5   5   5   5   5   5   5   6   6   6   6   6   6   6   6   6   6   6   7   	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV 8   :    
   L @ ]� [   � �L@@ ��  �  ]� _   �       IsAbleToHand    IsCode    ��cA   ��cA           @$ 
   9   9   9   9   9   9   9   9   9   :         c     
       ;   >   	     @��FB@ G����@ �A�� CA A  �� �  ^�_  FB@ G���  �B   A� �� �CA ]B� � 	              Duel    IsExistingMatchingCard 	   c9991901 	   thfilter    LOCATION_DECK       �?   SetOperationInfo    CATEGORY_TOHAND             @$    <   <   <   <   <   <   <   <   <   <   <   <   <   =   =   =   =   =   =   =   =   =   >   	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV ?   I    /   @ �B@ ��  ���@ � �@�  ��B    � � A BAF�A �� ��A B A B@� �BB ��B�� �B A �C �C   ��L�C]� @���FA G��� �  D ]B FA GB��B��� ]B� �    
   IsHasType    EFFECT_TYPE_IGNITION    GetHandler    IsRelateToEffect    Duel    Hint    HINT_SELECTMSG    HINTMSG_ATOHAND    SelectMatchingCard 	   c9991901 	   thfilter    LOCATION_DECK               �?	   GetCount    SendtoHand    REASON_EFFECT    ConfirmCards             @$ /   @   @   @   @   @   A   A   A   A   A   A   A   A   C   C   C   C   C   C   D   D   D   D   D   D   D   D   D   D   D   D   E   E   E   E   F   F   F   F   F   F   G   G   G   G   G   I   	      e     /      tp     /      eg     /      ep     /      ev     /      re     /      r     /      rp     /      g    /         _ENV J   L       @ � B@��@ �   �       GetHandler    IsPreviousLocation    LOCATION_GRAVE             @$    K   K   K   K   K   K   L         e           tp           eg           ep           ev           re           r           rp              _ENV M   R   	     @@�FB@ G���� ��  ^�_  FB@ G��� ]B FB@ GB���  ]B FB@ G���  ��A   A  �� ��  ]B� �               Duel    IsPlayerCanDraw       �?   SetTargetPlayer    SetTargetParam    SetOperationInfo    CATEGORY_DRAW             @$    N   N   N   N   N   N   N   N   O   O   O   O   P   P   P   P   Q   Q   Q   Q   Q   Q   Q   Q   Q   R   	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV S   V       @ B@A�  ��@ �A � �@ �BA�  �F�A �B  �       Duel    GetChainInfo            CHAININFO_TARGET_PLAYER    CHAININFO_TARGET_PARAM    Draw    REASON_EFFECT             @$    T   T   T   T   T   T   U   U   U   U   U   U   V   
      e           tp           eg           ep           ev           re           r           rp           p          d             _ENV        @$ $               %      &   &   '   0   '   1   3   1   4   7   4   8   :   8   ;   >   ;   ?   I   ?   J   L   J   M   R   M   S   V   S   V             _ENV 