--大地的使者·未来来篝
function c1100806.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(CATEGORY_TOGRAVE)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetDescription(aux.Stringid(1100806,1))
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,1100806)
	e1:SetCost(c1100806.descost)
	e1:SetTarget(c1100806.destg)
	e1:SetOperation(c1100806.desop)
	c:RegisterEffect(e1)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1100806,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,1100806)
	e1:SetCost(c1100806.cost)
	e1:SetTarget(c1100806.target)
	e1:SetOperation(c1100806.operation)
	c:RegisterEffect(e1) 
end
function c1100806.cfilter0(c)
	return c:IsSetCard(0x1243) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost()
end
function c1100806.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1100806.cfilter0,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c1100806.cfilter0,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoDeck(g,POS_FACEUP,REASON_COST)
end
function c1100806.dfilter(c)
	return c:IsAttackAbove(2500) and c:IsFaceup()
end
function c1100806.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1100806.dfilter,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(c1100806.dfilter,tp,0,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,sg:GetCount(),0,0)
end
function c1100806.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c1100806.dfilter,tp,0,LOCATION_MZONE,e:GetHandler())
	local ct=Duel.SendtoGrave(sg,REASON_EFFECT,LOCATION_GRAVE)
	if ct>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(ct*500)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
function c1100806.cfilter(c)
	return c:IsSetCard(0x1243) and c:IsAbleToRemoveAsCost() and c:IsType(TYPE_FUSION+TYPE_SYNCHRO)
end
function c1100806.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1100806.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c1100806.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c1100806.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c1100806.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
