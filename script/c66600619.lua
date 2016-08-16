local m=66600612
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c66600601") end) then require("script/c66600601") end
function cm.initial_effect(c)
	sixth.setreg(c,m,66600600)
	--td
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c66600619.activate)
	c:RegisterEffect(e1)
end
function c66600619.filter(c)
	return c:IsFaceup() and c:IsAbleToHand() and c:IsHasEffect(66600600)
end
function c66600619.filter1(c)
	return c:IsFaceup() and c:IsAbleToDeck() and c:IsHasEffect(66600600)
end
function c66600619.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c66600619.filter,tp,LOCATION_REMOVED,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(66600619,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		local tg=Duel.GetMatchingGroup(c66600619.filter1,tp,LOCATION_REMOVED,0,sg:GetFirst())
		Duel.SendtoDeck(tg,REASON_EFFECT)
	end
end