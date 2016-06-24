--破坏女神·神罚
function c1100119.initial_effect(c)
 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c1100119.target1)
	e1:SetOperation(c1100119.operation)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1100119,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCost(c1100119.cost2)
	e2:SetTarget(c1100119.target2)
	e2:SetOperation(c1100119.operation)
	c:RegisterEffect(e2)
	--tograve
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,11119)
	e3:SetCost(c1100119.tgcost)
	e3:SetTarget(c1100119.tdtg)
	e3:SetOperation(c1100119.tdop)
	c:RegisterEffect(e3)
end
function c1100119.cfilter(c)
	return c:IsSetCard(0xa242) and c:IsType(TYPE_MONSTER)
end
function c1100119.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_ONFIELD) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return true end
	if Duel.CheckReleaseGroup(tp,c1100119.cfilter,1,nil)
		and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE+LOCATION_ONFIELD,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(1100119,0)) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		local cg=Duel.SelectReleaseGroup(tp,c1100119.cfilter,1,1,nil)
		Duel.Release(cg,REASON_COST)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE+LOCATION_ONFIELD,1,2,nil)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
		e:GetHandler():RegisterFlagEffect(1100119,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	else e:SetProperty(0) end
end
function c1100119.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c1100119.cfilter,1,nil) end
	local cg=Duel.SelectReleaseGroup(tp,c1100119.cfilter,1,1,nil)
	Duel.Release(cg,REASON_COST)
end
function c1100119.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_ONFIELD) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return e:GetHandler():GetFlagEffect(1100119)==0
		and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE+LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE+LOCATION_ONFIELD,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	e:GetHandler():RegisterFlagEffect(1100119,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c1100119.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	g=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
function c1100119.cfilter(c)
	return c:IsSetCard(0xa242) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost()
end
function c1100119.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost()
		and Duel.IsExistingMatchingCard(c1100119.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c1100119.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c1100119.tdfilter(c)
	return c:IsFaceup()
end
function c1100119.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c1100119.tdfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c1100119.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c1100119.tdfilter,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end