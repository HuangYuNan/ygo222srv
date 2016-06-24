--只有这次，我不会再放手了
function c10953642.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c10953642.cost)
	e1:SetTarget(c10953642.target)
	e1:SetOperation(c10953642.activate)
	c:RegisterEffect(e1)	
end
function c10953642.cfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c10953642.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10953642.cfilter,tp,LOCATION_GRAVE,0,1,nil,5012603)
		and Duel.IsExistingMatchingCard(c10953642.cfilter,tp,LOCATION_GRAVE,0,1,nil,5012601)
		and Duel.IsExistingMatchingCard(c10953642.cfilter,tp,LOCATION_GRAVE,0,1,nil,10953617)
		and Duel.IsExistingMatchingCard(c10953642.cfilter,tp,LOCATION_GRAVE,0,1,nil,10953641) end
	local tc1=Duel.GetFirstMatchingCard(c10953642.cfilter,tp,LOCATION_GRAVE,0,nil,5012603)
	local tc2=Duel.GetFirstMatchingCard(c10953642.cfilter,tp,LOCATION_GRAVE,0,nil,5012601)
	local tc3=Duel.GetFirstMatchingCard(c10953642.cfilter,tp,LOCATION_GRAVE,0,nil,10953617)
	local tc4=Duel.GetFirstMatchingCard(c10953642.cfilter,tp,LOCATION_GRAVE,0,nil,10953641)
	local g=Group.FromCards(tc1,tc2,tc3,tc4)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c10953642.filter(c,e,tp)
	return c:IsCode(10953643) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c10953642.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10953642.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c10953642.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10953642.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end
