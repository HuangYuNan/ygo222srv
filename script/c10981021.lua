--暗之渡魂者
function c10981021.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsAttribute,ATTRIBUTE_DARK),1)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,10981021)
	e1:SetCondition(c10981021.tdcon)
	e1:SetTarget(c10981021.target)
	e1:SetOperation(c10981021.operation)
	c:RegisterEffect(e1) 
end
function c10981021.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c10981021.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c10981021.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_GRAVE)
	Duel.SendtoDeck(g1,tp,2,REASON_EFFECT)
	local g2=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0)
	Duel.SendtoDeck(g2,1-tp,2,REASON_EFFECT) 
end
