--Idol Heart·荧光舞台
require("/expansions/script/c37564765")
function c66623316.initial_effect(c)
	senya.setreg(c,66623316,66623399) 
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,66623316+EFFECT_COUNT_CODE_OATH)
	e2:SetOperation(c66623316.activate)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66623316,1))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg and eg:IsExists(c66623316.sfilter,1,nil,tp)
	end)
	e1:SetTarget(senya.sesrtg(LOCATION_DECK,aux.FilterBoolFunction(Card.IsHasEffect,66623300)))
	e1:SetOperation(senya.sesrop(LOCATION_DECK,aux.FilterBoolFunction(Card.IsHasEffect,66623300)))
	c:RegisterEffect(e1)
end
function c66623316.filter(c)
	return c:IsHasEffect(66623399) and c:IsAbleToDeck()
end
function c66623316.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c66623316.filter,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>2 and Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,aux.Stringid(66623316,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local sg=g:Select(tp,3,3,nil)
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c66623316.sfilter(c,tp,l)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL and c:IsHasEffect(66623300) and c:GetSummonPlayer()==tp and c:GetMaterialCount()>1
end