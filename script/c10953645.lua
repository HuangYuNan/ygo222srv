--大霸星祭
function c10953645.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,10953645+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c10953645.spcost)
	e1:SetTarget(c10953645.target)
	e1:SetOperation(c10953645.activate)
	c:RegisterEffect(e1)	
end
function c10953645.cfilter(c)
	return ((c:IsSetCard(0x350) and c:IsLevelBelow(5)) or c:IsSetCard(0x23c) and c:IsType(TYPE_MONSTER)) and c:IsAbleToGraveAsCost()
end
function c10953645.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10953645.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c10953645.cfilter,1,1,REASON_COST,nil)
end
function c10953645.filter(c,e,tp)
	return ((c:IsSetCard(0x350) and c:IsLevelBelow(4) and not c:IsType(TYPE_PENDULUM)) or c:IsSetCard(0x23c) and c:IsLevelBelow(5)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10953645.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10953645.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c10953645.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10953645.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
