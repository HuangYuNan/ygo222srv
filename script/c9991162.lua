LuaR  �

             @ A@  @ �@ e   
@�� �       require    script/c9991100 	   c9991162    initial_effect       -    E   L @ ]@ F@@ G�� �   ��   D� ]@ F@A G�� �   ]� ��� B �@��@� �B �@���� C �@��@� �C �@���� D �@��@D  � �@��@A ��A�   �� ̀DF�D �@���AFE �@��@CFAE �@�̀EA� �@��@BFF �@���BFC �@��@FA� �@���Fe  �@�� GeA  �@��@Ge�  �@��@D @ �@� �       EnableReviveLimit    Dazz    AddXyzProcedureEldrazi       @       @   Effect    CreateEffect    SetType    EFFECT_TYPE_SINGLE    SetProperty    EFFECT_FLAG_SINGLE_RANGE 	   SetRange    LOCATION_MZONE    SetCode    EFFECT_ADD_ATTRIBUTE 	   SetValue    ATTRIBUTE_LIGHT    RegisterEffect    SetCategory    CATEGORY_DRAW    EFFECT_TYPE_QUICK_O    EVENT_FREE_CHAIN    SetHintTiming      �@@   EFFECT_FLAG_PLAYER_TARGET    SetCountLimit       �?   SetCost 
   SetTarget    SetOperation       !   	 5    @ �FB@ G���� ��    A�  �A ^ _  FB@ GB���A ��@�� �A A  �  �� �  FA ]������ X�@ ��B@ �BBƂB  � A� �B �� � A�  ��  �  �� @ �B@ �BC���B ����� ��C � A�  ��  �A �B  �               Duel    CheckRemoveOverlayCard       �?   REASON_COST    GetMatchingGroup    Card    LOCATION_MZONE 	   GetCount    Hint    HINT_SELECTMSG      ��@   Select    HintSelection 	   GetFirst    RemoveOverlayCard             @$ 5                                                                                                                                                                       !   
      e     5      tp     5      eg     5      ep     5      ev     5      re     5      r     5      rp     5      chk     5      sg    5         _ENV "   '   	     @@�FB@ G���� ��  ^�_  FB@ G��� ]B FB@ GB���  ]B FB@ G���  ��A   A  �� ��  ]B� �               Duel    IsPlayerCanDraw       �?   SetTargetPlayer    SetTargetParam    SetOperationInfo    CATEGORY_DRAW             @$    #   #   #   #   #   #   #   #   $   $   $   $   %   %   %   %   &   &   &   &   &   &   &   &   &   '   	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV (   +   	    F@ GB���  ��@ A ]� �@ �B� �@ ��A �B  �       Duel    GetChainInfo            CHAININFO_TARGET_PLAYER    CHAININFO_TARGET_PARAM    Draw    REASON_EFFECT             @$    )   )   )   )   )   )   *   *   *   *   *   *   +         e           tp           eg           ep           ev           re           r           rp           chk           p          d             _ENV         @$ E                                          	   	   	   
   
   
                                                                                                                     !      "   '   "   (   +   (   ,   ,   ,   -         c     E      ex    E      e1 #   E         _ENV        @$                -      -             _ENV 