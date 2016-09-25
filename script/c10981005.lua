--萌王EX-神眷的恶魔使·所罗门
function c10981005.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c10981005.spcon)
	e1:SetTarget(c10981005.sptg)
	e1:SetOperation(c10981005.spop)
	c:RegisterEffect(e1)		 
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10981005,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetCost(c10981005.cost)
	e2:SetTarget(c10981005.target)
	e2:SetOperation(c10981005.operation)
	c:RegisterEffect(e2) 
end
function c10981005.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) 
end
function c10981005.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10981005.cfilter,1,nil,tp)
end
function c10981005.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10981005.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
function c10981005.thfilter(c)
	return c:IsSetCard(0x2236) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c10981005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	local ct=Duel.GetMatchingGroupCount(nil,1-tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(c10981005.thfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,0,ct,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c10981005.thfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,0,ct,ct,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c10981005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,sg:GetCount(),0,0)
end
function c10981005.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SendtoGrave(sg,REASON_EFFECT)
end
