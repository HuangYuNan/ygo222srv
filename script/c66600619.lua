local m=66600619
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c66600601") end) then require("script/c66600601") end
function cm.initial_effect(c)
	sixth.setreg(c,m,66600600)
	--td
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetOperation(c66600619.activate)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_BECOME_TARGET)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetTarget(cm.tg)
	e1:SetOperation(cm.op)
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
		Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)
	end
end
function cm.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(sixth.gtgf,1,nil) end
end
function cm.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(sixth.gtgf,nil)
	g:ForEach(function(c)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetValue(cm.efilter)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_CHAIN)
		c:RegisterEffect(e3)
	end)
end