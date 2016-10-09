--超高校级的格斗家 大神樱
function c99991020.initial_effect(c)
    c:SetUniqueOnField(1,1,99991020)
    --synchro summon
    aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),2)
    c:EnableReviveLimit()
	 --battle indestructable
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e1:SetValue(1)
    c:RegisterEffect(e1)
    --actlimit
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetCode(EFFECT_CANNOT_ACTIVATE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTargetRange(0,1)
    e2:SetValue(1)
    e2:SetCondition(c99991020.actcon)
    c:RegisterEffect(e2)
	--sp
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(99991020,0))
    e3:SetCategory(CATEGORY_TOGAVE)
    e3:SetType(EFFECT_TYPE_QUICK_O)
    e3:SetCode(EVENT_FREE_CHAIN)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1,99991020)
    e3:SetTarget(c99991020.tg)
    e3:SetOperation(c99991020.op)
    c:RegisterEffect(e3)
	--pos
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(99991020,1))
    e4:SetCategory(CATEGORY_POS)
    e4:SetType(EFFECT_TYPE_QUICK_O)
    e4:SetCode(EVENT_FREE_CHAIN)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCountLimit(1,99991020)
    e4:SetTarget(c99991020.tg2)
    e4:SetOperation(c99991020.op2)
    c:RegisterEffect(e4)
	
end
function c99991020.actcon(e)
    return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c99991020.filter(c)
    return  c:IsAbleToGrave() or c:IsAbleToRemove()
end
function c99991020.tg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c99991020.filter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,e:GetHandler()) end
    Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c99991020.op(e,tp,eg,ep,ev,re,r,rp)
		  if not e:GetHandler():IsRelateToEffect(e) or not e:GetHandler():IsControler(tp) then return end
         Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)		
		local g=Duel.SelectMatchingCard(tp,c99991020.filter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,e:GetHandler())
		 local tc=g:GetFirst()
		 if tc then
        if not tc:IsAbleToRemove() or Duel.SelectYesNo(tp,aux.Stringid(99991020,2)) then
		if Duel.SendtoGrave(tc,REASON_EFFECT)>0 and Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and not e:GetHandler():IsForbidden()  
         and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP) then
        Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
		end
		else
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 and Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and not e:GetHandler():IsForbidden()  
         and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP) then
        Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
		end
end
end
end
function c99991020.filter2(c)
    return  c:IsAbleToHand() or c:IsAbleToDeck()
end
function c99991020.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c99991020.filter2,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,e:GetHandler()) end
end
function c99991020.op2(e,tp,eg,ep,ev,re,r,rp)
		 if not e:GetHandler():IsRelateToEffect(e) or not e:GetHandler():IsControler(tp) then return end
         Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)		
		local g=Duel.SelectMatchingCard(tp,c99991020.filter2,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,e:GetHandler())
		 local tc=g:GetFirst()
		 if tc then
        if not tc:IsAbleToDeck() or Duel.SelectYesNo(tp,aux.Stringid(99991020,3)) then
		if Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and Duel.ChangePosition(e:GetHandler(),POS_FACEDOWN_DEFENSE)~=0 then
       Duel.ChangePosition(e:GetHandler(),POS_FACEUP_ATTACK)
		end
		else
		if Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)>0 and Duel.ChangePosition(e:GetHandler(),POS_FACEDOWN_DEFENSE)~=0 then
       Duel.ChangePosition(e:GetHandler(),POS_FACEUP_ATTACK)
		end
end
end
end