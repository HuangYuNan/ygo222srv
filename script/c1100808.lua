--暗黑德鲁伊·神户小鸟
function c1100808.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x1243),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1100808,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCountLimit(1,1100808)
	e3:SetCondition(c1100808.spcon)
	e3:SetTarget(c1100808.tg)
	e3:SetOperation(c1100808.op)
	c:RegisterEffect(e3)
	--to grave/search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1100808,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,1100809)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c1100808.tgtg)
	e1:SetOperation(c1100808.tgop)
	c:RegisterEffect(e1)
end
function c1100808.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c1100808.spfilter(c,e,tp)
	return c:IsCode(1100800) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1100808.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1100808.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND)
end
function c1100808.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1100808.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c1100808.filter(c,tp)
	return c:IsSetCard(0x1243) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
		and Duel.IsExistingMatchingCard(c1100808.thfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,c)
end
function c1100808.tgfilter(c)
	return c:IsSetCard(0x1243) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c1100808.thfilter(c)
	return c:IsType(TYPE_EQUIP) and c:IsAbleToHand()
end
function c1100808.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1100808.filter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c1100808.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c1100808.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0
		and g:GetFirst():IsLocation(LOCATION_GRAVE) then
		local sg=Duel.GetMatchingGroup(c1100808.thfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,nil)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local tg=sg:Select(tp,1,1,nil)
			Duel.SendtoHand(tg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tg)
		end
	end
end