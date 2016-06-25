function qinglanMon(c)local t=c:GetCode()return t>11200079 and t<11200083 end
function qinglanSp(c)local t=c:GetCode()return t>11200083 and t<11200087 end
function qinglan(c)local t=c:GetCode()return qinglanMon(c)or qinglanSp(c)end
function qinglanCorm(c)return qinglan(c)and c:IsAbleToRemoveAsCost()end
function qinglanRm(c)return qinglan(c)and c:IsAbleToRemove()end
function qinglanUp(c)return qinglan(c)and c:IsFaceup()end
function qinglanMonRm(c)return qinglanMon(c)and c:IsAbleToRemove()end
function qinglanSpRm(c)return qinglanSp(c)and c:IsAbleToRemove()end
function c11200084.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_IGNITION)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetRange(LOCATION_HAND+LOCATION_ONFIELD)
	a:SetCategory(CATEGORY_REMOVE)
	a:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	a:SetCost(c11200084.coa)
	a:SetOperation(c11200084.opa)
	a:SetCountLimit(1,11200084)
	c:RegisterEffect(a)
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_IGNITION)
	b:SetCode(EVENT_FREE_CHAIN)
	b:SetRange(LOCATION_REMOVED)
	b:SetCategory(CATEGORY_REMOVE)
	b:SetCost(c11200084.cob)
	b:SetOperation(c11200084.opa)
	b:SetCountLimit(1,11200084)
	c:RegisterEffect(b)
end
function c11200084.coa(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return
		e:GetHandler():IsAbleToRemoveAsCost()and
		Duel.IsExistingMatchingCard(qinglanCorm,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,e:GetHandler())and
		Duel.IsExistingMatchingCard(qinglanRm,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil)
	end
	local g=Duel.SelectMatchingCard(tp,qinglanCorm,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,RESET_COST)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,tp,LOCATION_GRAVE)
end
function c11200084.opa(e,tp)
	Duel.Remove(Duel.SelectMatchingCard(tp,qinglanRm,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil),POS_FACEUP,REASON_EFFECT)
end
function c11200084.cob(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return
		Duel.IsExistingMatchingCard(qinglanUp,0,LOCATION_REMOVED,LOCATION_REMOVED,1,e:GetHandler())and
		Duel.IsExistingMatchingCard(qinglanRm,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil)
	end
	local g=Duel.SelectMatchingCard(tp,qinglanUp,0,LOCATION_REMOVED,LOCATION_REMOVED,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST+REASON_RETURN)
end
