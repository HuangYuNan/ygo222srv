--神天竜－ウェーブ
require "expansions/script/c9990000"
function c9991203.initial_effect(c)
	Dazz.GodraMainCommonEffect(c)
	--Special Summon From Grave
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,19991203)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
		Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c9991203.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c9991203.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP_DEFENSE)
			g:GetFirst():CompleteProcedure()
		end
	end)
	c:RegisterEffect(e1)
	--Send Monster Back to Hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(0xfe)
	e2:SetCountLimit(1,29991203)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg and eg:IsExists(function(c,mc)
			local mg=c:GetMaterial()
			return mg and mg:IsContains(mc) and Dazz.IsGodra(c) and bit.band(c:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		end,1,nil,e:GetHandler())
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetMatchingGroupCount(c9991203.thfilter,tp,0x30,0x30,nil)~=0 end
		local sg=Duel.GetMatchingGroup(c9991203.thfilter,tp,0x30,0x30,nil,e,e:GetHandler():GetCode())
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,1,0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(c9991203.thfilter,tp,0x30,0x30,nil)
		if sg and sg:GetCount()~=0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local rg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(rg)
			Duel.SendtoHand(rg,tp,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e2)
end
c9991203.Dazz_name_godra=true
function c9991203.spfilter(c,e,tp)
	return Dazz.IsGodra(c) and not c:IsHasEffect(EFFECT_NECRO_VALLEY) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c9991203.thfilter(c)
	if c:IsLocation(LOCATION_GRAVE) then
		if c:IsHasEffect(EFFECT_NECRO_VALLEY) then return false end
	else
		if c:IsFacedown() then return false end
	end
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and not c:IsCode(9991203)
end