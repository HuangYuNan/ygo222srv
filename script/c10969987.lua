--萃·Distress
function c10969987.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10969987,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,10969987)
	e2:SetCondition(c10969987.condition)
	e2:SetCost(c10969987.cost)
	e2:SetTarget(c10969987.tg)
	e2:SetOperation(c10969987.activate)
	c:RegisterEffect(e2)   
end
function c10969987.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetFlagEffect(tp,111)==0 and Duel.GetFlagEffect(tp,112)==0) or Duel.GetFlagEffect(tp,113)~=0
end
function c10969987.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c10969987.filter(c,e,tp)
	return c:IsSetCard(0x358) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10969987.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10969987.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c10969987.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10969987.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
