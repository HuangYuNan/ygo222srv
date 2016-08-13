require 'expansions.script.c2150000'
function c2150011.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_ACTIVATE)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetTarget(c2150011.tga)
	a:SetOperation(c2150011.opa)
	a:SetCategory(CATEGORY_SPECIAL_SUMMON)
	c:RegisterEffect(a)
end
function c2150011.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(BiDiuSs,tp,LOCATION_EXTRA,0,1,nil,e,tp)and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c2150011.opa(e,tp)
	local t=Duel.SelectMatchingCard(tp,BiDiuSs,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if not t then return end
	Duel.SpecialSummon(t,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	if t:IsType(TYPE_XYZ)and e:GetHandler():IsLocation(LOCATION_ONFIELD)and	Duel.SelectYesNo(tp,1073)then
		Duel.BreakEffect()
		e:GetHandler():CancelToGrave()
		Duel.Overlay(t,e:GetHandler())
	end
end
