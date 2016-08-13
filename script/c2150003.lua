require 'expansions.script.c2150000'
function c2150003.initial_effect(c)
	local a=BiDiu(c)
	a:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	a:SetCode(EVENT_SUMMON_SUCCESS)
	a:SetCountLimit(1,2150003)
	a:SetTarget(c2150003.tga)
	a:SetOperation(c2150003.opa)
	c:RegisterEffect(a)
	a=a:Clone()
	a:SetCode(EVENT_SPSUMMON_SUCCESS)
	a:SetCost(c2150003.cob)
	c:RegisterEffect(a)
end
function c2150003.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(BiDiuSs,tp,LOCATION_DECK,0,1,nil,e,tp)and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c2150003.opa(e,tp)Duel.SpecialSummon(Duel.SelectMatchingCard(tp,BiDiuSs,tp,LOCATION_DECK,0,1,1,nil,e,tp),0,tp,tp,false,false,POS_FACEUP_DEFENSE)end
function c2150003.cob(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	Duel.DiscardHand(tp,nil,1,1,REASON_COST,nil)
end
