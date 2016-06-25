function qinglanMon(c)local t=c:GetCode()return t>11200079 and t<11200083 end
function qinglanSp(c)local t=c:GetCode()return t>11200083 and t<11200087 end
function qinglan(c)local t=c:GetCode()return qinglanMon(c)or qinglanSp(c)end
function qinglanCorm(c)return qinglan(c)and c:IsAbleToRemoveAsCost()end
function qinglanRm(c)return qinglan(c)and c:IsAbleToRemove()end
function qinglanUp(c)return qinglan(c)and c:IsFaceup()end
function qinglanMonRm(c)return qinglanMon(c)and c:IsAbleToRemove()end
function qinglanSpRm(c)return qinglanSp(c)and c:IsAbleToRemove()end
function c11200083.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_ACTIVATE)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetCategory(CATEGORY_SEARCH+CATEGORY_REMOVE)
	a:SetCost(c11200083.coa)
	a:SetOperation(c11200083.opa)
	a:SetCountLimit(1,11200083)
	c:RegisterEffect(a)
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_FIELD)
	b:SetRange(LOCATION_FZONE)
	b:SetCode(EFFECT_CANNOT_ACTIVATE)
	b:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	b:SetTargetRange(0,1)
	b:SetValue(c11200083.vb)
	c:RegisterEffect(b)
end
function c11200083.coa(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(qinglanCorm,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil)end
	local g=Duel.SelectMatchingCard(tp,qinglanCorm,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,999,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	e:SetLabel((g:IsExists(Card.IsType,1,nil,TYPE_MONSTER)and 1 or 0)+(g:IsExists(Card.IsType,1,nil,TYPE_SPELL)and 2 or 0))
	Duel.SetOperationInfo(0,CATEGORY_SEARCH,nil,e:GetLabel(),tp,LOCATION_DECK)
end
function c11200083.opa(e,tp)
	if not e:GetHandler():IsRelateToEffect(e)then return end
	if e:GetLabel()%2>0 then Duel.Remove(Duel.SelectMatchingCard(tp,qinglanMonRm,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil),POS_FACEUP,REASON_EFFECT)end
	if e:GetLabel()>1 then Duel.Remove(Duel.SelectMatchingCard(tp,qinglanSpRm,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil),POS_FACEUP,REASON_EFFECT)end
end
function c11200083.vb(e,re,tp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end