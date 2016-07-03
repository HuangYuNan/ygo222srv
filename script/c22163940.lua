--傲娇希望
function c22163940.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c22163940.target)
	e1:SetOperation(c22163940.activate)
	c:RegisterEffect(e1)
end
function c22163940.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x370) and c:IsAbleToHand()
end
function c22163940.filter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsDestructable()
end
function c22163940.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c22163940.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,2,nil)
		and Duel.IsExistingMatchingCard(c22163940.filter1,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectTarget(tp,c22163940.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c22163940.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()==2 then
		if Duel.IsExistingMatchingCard(c22163940.filter1,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil) then
			local g=Duel.SelectMatchingCard(tp,c22163940.filter1,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil)
			if g:GetFirst():IsLocation(LOCATION_ONFIELD) then
				Duel.HintSelection(g)
			end
			if Duel.Destroy(g,REASON_EFFECT)~=0 then
				Duel.SendtoHand(sg,nil,REASON_EFFECT)
			end
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DECREASE_TRIBUTE)
	e1:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e1:SetTarget(c22163940.rfilter)
	e1:SetValue(0x370)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c22163940.rfilter(e,c)
	return c:IsSetCard(0x370)
end