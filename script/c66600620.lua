local m=66600620
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c66600601") end) then require("script/c66600601") end
function cm.initial_effect(c)
	sixth.setreg(c,m,66600600)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,66600620)
	e1:SetTarget(c66600620.target)
	e1:SetOperation(c66600620.activate)
	c:RegisterEffect(e1)
end
function c66600620.filter(c)
	return c:IsAbleToGrave() and c:IsHasEffect(66600600)
end
function c66600620.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and Duel.IsExistingTarget(c66600620.filter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.SelectTarget(tp,c66600620.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c66600620.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end