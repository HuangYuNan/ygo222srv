--Sire of Stagnation
require "expansions/script/c9990000"
function c9991138.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,nil,nil)
	--Devoid
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ex:SetRange(LOCATION_MZONE)
	ex:SetCode(EFFECT_ADD_ATTRIBUTE)
	ex:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(ex)
	--Eat Deck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local p=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_PLAYER)
		if p==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
		if not re:IsActiveType(TYPE_PENDULUM+TYPE_CONTINUOUS+TYPE_FIELD) then return end
		Duel.Hint(HINT_CARD,0,9991138)
		local g=Duel.GetDecktopGroup(1-tp,2)
		Duel.DisableShuffleCheck()
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		Duel.Draw(tp,1,REASON_EFFECT)
	end)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SSET)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if rp==tp then return end
		Duel.Hint(HINT_CARD,0,9991138)
		local g=Duel.GetDecktopGroup(1-tp,2)
		Duel.DisableShuffleCheck()
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		Duel.Draw(tp,1,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
end