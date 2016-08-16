--奥利哈刚·天神荡
function c222530.initial_effect(c)
	--win
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetCost(c222530.discost)
	e1:SetOperation(c222530.winop)
	c:RegisterEffect(e1)
end
function c222530.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_HAND,0,6,e:GetHandler()) and Duel.CheckLPCost(tp,5000) end
	Duel.PayLPCost(tp,5000)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_HAND,0,6,6,nil)
	Duel.Remove(g,POS_FACEDOWM,REASON_COST)
end
function c222530.filter(c)
	return c:IsCode(222530) and c:IsAbleToRemoveAsCost()
end
function c222530.winop(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetMatchingGroup(c222530.filter,tp,0,LOCATION_HAND+LOCATION_DECK,nil)
		if g:GetCount()>2 and Duel.SelectYesNo(1-tp,aux.Stringid(222530,1)) then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		if Duel.IsChainDisablable(0) then
			Duel.NegateEffect(0)
			return
		end
	end
	local WIN_REASON_AREKALS_APOCALYPSE=0x1f
	Duel.Win(tp,WIN_REASON_AREKALS_APOCALYPSE)
end