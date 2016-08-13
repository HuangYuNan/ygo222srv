require 'script.c2150000'
function c2150008.initial_effect(c)
	local a=BiDiu(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	a:SetCode(EVENT_TO_HAND)
	a:SetRange(LOCATION_MZONE)
	a:SetOperation(c2150008.opa)
	c:RegisterEffect(a)
end
function c2150008.opa(e,tp,eg,ep,ev,re,r,rp)
	if eg:GetFirst():IsReason(REASON_DRAW)then return end
	Duel.SendtoDeck(eg,nil,2,REASON_EFFECT)
	Duel.Draw(tp,rp==tp and 1 or 2,REASON_EFFECT+REASON_DRAW)
end
	
