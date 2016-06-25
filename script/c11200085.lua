function qinglanMon(c)local t=c:GetCode()return t>11200079 and t<11200083 end
function qinglanSp(c)local t=c:GetCode()return t>11200083 and t<11200087 end
function qinglan(c)local t=c:GetCode()return qinglanMon(c)or qinglanSp(c)end
function qinglanCorm(c)return qinglan(c)and c:IsAbleToRemoveAsCost()end
function qinglanRm(c)return qinglan(c)and c:IsAbleToRemove()end
function qinglanUp(c)return qinglan(c)and c:IsFaceup()end
function qinglanMonRm(c)return qinglanMon(c)and c:IsAbleToRemove()end
function qinglanSpRm(c)return qinglanSp(c)and c:IsAbleToRemove()end
function c11200085.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_ACTIVATE)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetCategory(CATEGORY_DESTROY)
	a:SetCountLimit(1,11200085)
	a:SetCost(c11200085.coa)
	a:SetOperation(c11200085.opa)
	c:RegisterEffect(a)
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_IGNITION)
	b:SetCode(EVENT_FREE_CHAIN)
	b:SetRange(LOCATION_REMOVED)
	b:SetCountLimit(1,11200085)
	b:SetCategory(CATEGORY_REMOVE)
	b:SetCost(c11200085.cob)
	b:SetOperation(c11200085.opb)
	c:RegisterEffect(b)
end
function c11200085.coa(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return
		Duel.IsExistingMatchingCard(qinglanCorm,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,0,1,e:GetHandler())and
		Duel.IsExistingMatchingCard(nil,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
	end
	Duel.Remove(Duel.SelectMatchingCard(tp,qinglanCorm,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,0,1,1,e:GetHandler()),POS_FACEUP,RESET_COST)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,PLAYER_ALL,LOCATION_ONFIELD)
end
function c11200085.opa(e,tp)
	Duel.Destroy(Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler()),REASON_EFFECT)
end
function c11200085.cob(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,0,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)end
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT+REASON_RETURN)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,3,PLAYER_ALL,LOCATION_GRAVE)
end
function c11200085.opb(e,tp)
	Duel.Remove(Duel.SelectMatchingCard(tp,nil,0,LOCATION_GRAVE,LOCATION_GRAVE,1,3,e:GetHandler()),POS_FACEUP,REASON_EFFECT)
end