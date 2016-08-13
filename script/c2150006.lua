require 'expansions.script.c2150000'
function c2150006.initial_effect(c)
	local a=BiDiu(c)
	a:SetType(EFFECT_TYPE_QUICK_O)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetRange(LOCATION_GRAVE)
	a:SetProperty(EFFECT_FLAG_CARD_TARGET)
	a:SetCountLimit(1)
	a:SetTarget(c2150006.tga)
	a:SetOperation(c2150006.opa)
	c:RegisterEffect(a)
end
function c2150006.tga(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD)end
	if chk==0 then return e:GetHandler():GetTurnID()+1==Duel.GetTurnCount()and Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)end
	Duel.SelectTarget(tp,nil,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
end
function c2150006.opa(e)
	local t=Duel.GetFirstTarget()
	if not t:IsRelateToEffect(e)then return end
	local a=Effect.CreateEffect(e:GetHandler())
	a:SetType(EFFECT_TYPE_SINGLE)
	a:SetCode(EFFECT_CANNOT_TRIGGER)
	a:SetRange(LOCATION_ONFIELD)
	a:SetReset(RESET_EVENT+RESET_LEAVE)
	t:RegisterEffect(a)
end
