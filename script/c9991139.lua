--Reality Smasher
require "expansions/script/c9990000"
function c9991139.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,nil,nil)
	--Negate Target
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
		if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
		local loc,tg=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TARGET_CARDS)
		if not tg or not tg:IsContains(c) then return false end
		return Duel.IsChainNegatable(ev) and loc~=LOCATION_DECK
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if not Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,0,LOCATION_HAND,1,nil)
			or not Duel.SelectYesNo(1-tp,aux.Stringid(9991139,0)) then
			Duel.NegateActivation(ev)
			if re:GetHandler():IsRelateToEffect(re) then
				Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
			end
		else
			Duel.DiscardHand(1-tp,Card.IsDiscardable,1,1,REASON_EFFECT+REASON_DISCARD)
		end
	end)
	c:RegisterEffect(e1)
	--Exile Battle Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
end