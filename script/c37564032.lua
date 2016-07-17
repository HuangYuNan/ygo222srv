--quesar
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564032.initial_effect(c)
	aux.AddXyzProcedure(c,nil,6,4,c37564032.ovfilter,aux.Stringid(37564032,0),5)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c37564032.atkcon)
	e1:SetOperation(c37564032.atkop)
	c:RegisterEffect(e1)
end
function c37564032.ovfilter(c)
	return c:IsFaceup() and c:GetOriginalCode()==37564022 and Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c37564032.filter(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function c37564032.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c37564032.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,e:GetHandler())
end
function c37564032.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsExistingMatchingCard(c37564032.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,e:GetHandler()) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=Duel.SelectMatchingCard(tp,c37564032.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,1,e:GetHandler())
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		local tc=sg:GetFirst()
		senya.copy(e,nil,tc,true)
end