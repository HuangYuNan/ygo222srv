--傲娇黑炎黑猫
function c22163918.initial_effect(c)
	--synchro summon
    aux.AddSynchroProcedure2(c,aux.FilterBoolFunction(Card.IsSetCard,0x370),aux.FilterBoolFunction(Card.IsCode,22163906))
    c:EnableReviveLimit()
	--cannot disable summon
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
    e1:SetRange(LOCATION_MZONE)
    e1:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
    e1:SetTargetRange(1,0)
    e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x370))
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
    c:RegisterEffect(e2)
	--remove
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(22163918,0))
    e3:SetCategory(CATEGORY_REMOVE)
    e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e3:SetType(EFFECT_TYPE_QUICK_O)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1)
    e3:SetCode(EVENT_FREE_CHAIN)
    e3:SetHintTiming(0,0x1e0)
    e3:SetTarget(c22163918.thtg)
    e3:SetOperation(c22163918.thop)
    c:RegisterEffect(e3)
end
function c22163918.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
    if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c22163918.thop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        if Duel.Remove(tc,nil,REASON_EFFECT+REASON_TEMPORARY)~=0 then
			if Duel.GetCurrentPhase()==PHASE_END then
				Duel.ReturnToField(tc)
			else
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_PHASE+PHASE_END)
				e1:SetReset(RESET_PHASE+PHASE_END)
				e1:SetLabelObject(tc)
				e1:SetCountLimit(1)
				e1:SetOperation(c22163918.retop)
				Duel.RegisterEffect(e1,tp)
			end
		end
    end
end
function c22163918.retop(e,tp,eg,ep,ev,re,r,rp)
    local tc=e:GetLabelObject()
    if tc:IsForbidden() then 
        Duel.SendtoGrave(tc,REASON_RULE)
    else
		Duel.ReturnToField(tc)
    end
end
