--帝国卫队 帝国指挥官
function c12400009.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,12400009+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c12400009.activate)
	c:RegisterEffect(e1)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(12400009,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c12400009.spcost)
	e4:SetTarget(c12400009.sptg)
	e4:SetOperation(c12400009.spop)
	c:RegisterEffect(e4)
	--discard & draw
	local e14=Effect.CreateEffect(c)
	e14:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e14:SetDescription(aux.Stringid(12400009,2))
	e14:SetType(EFFECT_TYPE_IGNITION)
	e14:SetRange(LOCATION_FZONE)
	e14:SetCountLimit(1)
	e14:SetCondition(c12400009.spcon)
	e14:SetCost(c12400009.cost)
	e14:SetTarget(c12400009.target)
	e14:SetOperation(c12400009.operation)
	c:RegisterEffect(e14)
	--reg
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	ea:SetCode(EVENT_TO_GRAVE)
	ea:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	ea:SetCondition(c12400009.descon)
	ea:SetOperation(c12400009.regop)
	c:RegisterEffect(ea)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(12400009,3))
	e4:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c12400009.thcon)
	e4:SetCost(c12400009.cost2)
	e4:SetTarget(c12400009.thtg)
	e4:SetOperation(c12400009.thop)
	c:RegisterEffect(e4)
end
function c12400009.filter8(c)
	return c:IsSetCard(0x3390) and c:IsAbleToHand()
end
function c12400009.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c12400009.filter8,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(12400009,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c12400009.drcfilter(c)
	return c:IsSetCard(0x3390) and c:IsDiscardable()
end
function c12400009.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c12400009.drcfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c12400009.drcfilter,1,1,REASON_DISCARD+REASON_COST)
end
function c12400009.spfilter(c,e,tp)
	return c:IsCode(12400001) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12400009.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c12400009.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c12400009.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c12400009.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c12400009.cfilter1(c)
	return c:IsSetCard(0x3390) 
end
function c12400009.spcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c12400009.cfilter1,tp,LOCATION_GRAVE,0,nil)
	return g:GetClassCount(Card.GetCode)>=4
end
function c12400009.cfilter(c)
	return c:IsSetCard(0x3390) and c:IsAbleToRemoveAsCost()
end
function c12400009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c12400009.cfilter,tp,LOCATION_GRAVE,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c12400009.cfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c12400009.filter(c)
	return c:IsCode(12400008) and c:IsAbleToHand()
end
function c12400009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c12400009.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c12400009.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c12400009.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c12400009.descon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsSetCard(0x3390)
end
function c12400009.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(12400009,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c12400009.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(12400009)>0
end
function c12400009.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c12400009.spfilter1(c)
	return (c:IsSetCard(0x3390) or c:IsCode(12400008)) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c12400009.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c12400009.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c12400009.spfilter1,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c12400009.spfilter1,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c12400009.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end


