--AIW·归来的爱丽丝
function c66619907.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x666),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20366274,1))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCost(c66619907.cost1)
	e1:SetCondition(c66619907.descon)
	e1:SetTarget(c66619907.destg)
	e1:SetOperation(c66619907.desop)
	c:RegisterEffect(e1)
	--th
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29200014,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c66619907.con)
	e2:SetCost(c66619907.cost)
	e2:SetTarget(c66619907.target)
	e2:SetOperation(c66619907.operation)
	c:RegisterEffect(e2)
end
function c66619907.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_CONTINUOUS) and c:IsAbleToGraveAsCost()
end
function c66619907.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66619907.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c66619907.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c66619907.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsFaceup()
end
function c66619907.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler():GetBattleTarget(),1,0,0)
end
function c66619907.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.SendtoDeck(bc,nil,2,REASON_EFFECT)
	end
end
function c66619907.cfilter1(c)
	return c:IsCode(66619916) and c:IsFaceup() 
end
function c66619907.con(e)
	local g=Duel.GetFieldGroup(e:GetHandlerPlayer(),LOCATION_ONFIELD,0)
	return g:IsExists(c66619907.cfilter1,1,nil)
end
function c66619907.spfilter(c)
	return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c66619907.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66619907.spfilter,tp,LOCATION_GRAVE,0,3,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c66619907.spfilter,tp,LOCATION_GRAVE,0,3,3,e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end
function c66619907.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c66619907.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLocation(LOCATION_HAND) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end