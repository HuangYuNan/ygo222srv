--破坏女神·黑潮
function c1100118.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,1100118+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c1100118.condition)
	e1:SetTarget(c1100118.target)
	e1:SetOperation(c1100118.operation)
	c:RegisterEffect(e1)
	--sset
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c1100118.setcon)
	e2:SetTarget(c1100118.settg)
	e2:SetOperation(c1100118.setop)
	c:RegisterEffect(e2)
end
function c1100118.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
end
function c1100118.filter(c)
	return c:IsSetCard(0xa242) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c1100118.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE+LOCATION_DECK) and c1100118.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1100118.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil) end
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)-Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c1100118.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c1100118.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c1100118.filter1(c,tp)
	return c:IsSetCard(0xa242) and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c1100118.setcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c1100118.filter1,1,nil,tp) and aux.exccon(e)
end
function c1100118.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsSSetable(true) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c1100118.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.SSet(tp,c)
		Duel.ConfirmCards(1-tp,c)
	end
end