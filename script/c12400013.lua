--帝国卫队 战壕集结
function c12400013.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c12400013.condition)
	e1:SetCost(c12400013.cost1)
	e1:SetTarget(c12400013.target)
	e1:SetOperation(c12400013.activate)
	c:RegisterEffect(e1)
	--reg
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	ea:SetCode(EVENT_TO_GRAVE)
	ea:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	ea:SetCondition(c12400013.descon)
	ea:SetOperation(c12400013.regop)
	c:RegisterEffect(ea)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(12400013,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c12400013.thcon)
	e4:SetCost(c12400013.cost2)
	e4:SetTarget(c12400013.thtg)
	e4:SetOperation(c12400013.thop)
	c:RegisterEffect(e4)
end
function c12400013.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c12400013.cfilter(c)
	return c:IsSetCard(0x3390) and c:IsAbleToGraveAsCost()
end
function c12400013.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local loc=LOCATION_MZONE
	if chk==0 then return Duel.IsExistingMatchingCard(c12400013.cfilter,tp,loc,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c12400013.cfilter,tp,loc,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c12400013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsAbleToRemove() then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,re:GetHandler(),1,0,0)
	end
end
function c12400013.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		--Duel.Destroy(re:GetHandler(),REASON_EFFECT)
		Duel.Remove(re:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end
function c12400013.descon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsSetCard(0x3390)
end
function c12400013.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(12400013,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c12400013.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(12400013)>0
end
function c12400013.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c12400013.filter(c,e,tp)
	return c:IsSetCard(0x3390) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12400013.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c12400013.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c12400013.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c12400013.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end


