--娜娜的绯闻女友
require("/expansions/script/c37564765")
require("/expansions/script/c37564777")
function c66623307.initial_effect(c)
	senya.setreg(c,66623307,66623300)
	c:EnableReviveLimit()
	prim.nnr(c,c66623307.con,senya.sesrop(LOCATION_GRAVE,c66623307.filter),aux.Stringid(66623307,0),CATEGORY_TOHAND)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetLabel(LOCATION_HAND)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		local loc,np=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TRIGGERING_CONTROLER)
		return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and re:IsActiveType(TYPE_MONSTER) and bit.band(loc,e:GetLabel())~=0 and np~=tp and re:GetHandler():IsAbleToDeck()
	end)
	e3:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if re:GetHandler():IsAbleToDeck() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	end
	end)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if re:GetHandler():IsRelateToEffect(re) and Duel.SendtoDeck(eg,nil,2,REASON_EFFECT) then
			Duel.Draw(1-tp,1,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e3)
	local e1=e3:Clone()
	e1:SetLabel(LOCATION_GRAVE)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if re:GetHandler():IsRelateToEffect(re) and Duel.SendtoDeck(eg,nil,2,REASON_EFFECT) then
			local g=Duel.GetMatchingGroup(c66623307.gfilter,tp,0,LOCATION_DECK,nil)
			if g:GetCount()>0 then
				Duel.BreakEffect()
				local sg=g:Select(1-tp,1,1,nil)
				Duel.SendtoGrave(sg,REASON_EFFECT)
			end
		end
	end)
	c:RegisterEffect(e1)
end
function c66623307.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c66623307.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c66623307.filter(c)
	return c:IsHasEffect(66623399) and c:GetType()==0x82 and c:IsAbleToHand()
end
function c66623307.gfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end