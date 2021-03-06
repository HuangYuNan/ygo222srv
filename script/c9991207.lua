--神天竜－オンブラ
require "expansions/script/c9990000"
function c9991207.initial_effect(c)
	Dazz.GodraMainCommonEffect(c)
	--To Hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,19991207)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local c=e:GetHandler()
		if chk==0 then return c:IsDiscardable() end
		Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local sg=Duel.GetMatchingGroup(c9991207.thfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
		if chk==0 then return sg:GetCount()~=0 end
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,1,0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(c9991207.thfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
		if sg and sg:GetCount()~=0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local rg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(rg)
			Duel.SendtoHand(rg,tp,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCountLimit(1,29991207)
	e2:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_RETURN)
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c9991207.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c9991207.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
			g:GetFirst():CompleteProcedure()
		end
	end)
	c:RegisterEffect(e2)
end
c9991207.Dazz_name_godra=true
function c9991207.thfilter(c)
	return Dazz.IsGodra(c) and not c:IsHasEffect(EFFECT_NECRO_VALLEY) and not c:IsCode(9991207) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c9991207.spfilter(c,e,tp)
	return Dazz.IsGodra(c) and not c:IsHasEffect(EFFECT_NECRO_VALLEY) and not c:IsCode(9991207) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end