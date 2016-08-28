--神之曲 王道泽尔盖恩
function c75000119.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75000119,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c75000119.spcon)
	e1:SetTarget(c75000119.sptg)
	e1:SetOperation(c75000119.spop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c75000119.condition)
	e2:SetCost(c75000119.cost)
	e2:SetTarget(c75000119.target)
	e2:SetOperation(c75000119.activate)
	c:RegisterEffect(e2)
end
function c75000119.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x52f) and c:GetSummonPlayer()==tp and c:IsType(TYPE_SYNCHRO)
end
function c75000119.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c75000119.cfilter,1,nil,tp)
end
function c75000119.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c75000119.filter(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_SPELL)
end
function c75000119.filter2(c)
	return c:IsSetCard(0x52f)
end
function c75000119.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,c75000119.filter,tp,LOCATION_DECK,0,1,1,nil)
		if g1:GetCount()>0 then
			Duel.SendtoGrave(g1,REASON_EFFECT)
		end
	end
end
function c75000119.condition(e,tp,eg,ep,ev,re,r,rp)
	if not rp==1-tp then return false end
	return Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_HAND and Duel.IsChainNegatable(ev) 
end
function c75000119.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() and Duel.IsExistingMatchingCard(c75000119.filter2,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c75000119.filter2,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c75000119.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c75000119.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
