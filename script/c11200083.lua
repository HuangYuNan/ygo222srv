function fqinglan(c)local t=c:GetCode()return t>11200079 and t<11200087 and t~=11200083 end
function fcoRemoveQinglan(c)return fqinglan(c)and c:IsAbleToRemoveAsCost()end
function fremoveQinglan(c)return fqinglan(c)and c:IsAbleToRemove()end
function fupQinglan(c)return fqinglan(c)and c:IsFaceup()end
function fcoRemoveQinglanMon(c)local t=c:GetCode()return t>11200079 and t<11200083 and c:IsAbleToRemove()end
function fcoRemoveQinglanSp(c)local t=c:GetCode()return t>11200083 and t<11200087 and c:IsAbleToRemove()end
function c11200083.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_ACTIVATE)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetCategory(CATEGORY_SEARCH)
	a:SetCost(c11200083.coa)
	a:SetOperation(c11200083.opa)
	a:SetCountLimit(1,11200083)
	a:SetCategory(CATEGORY_REMOVE)
	c:RegisterEffect(a)
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_FIELD)
	b:SetCode(EFFECT_CANNOT_TRIGGER)
	b:SetRange(LOCATION_SZONE)
	b:SetValue(c11200083.vb)
	c:RegisterEffect(b)
end
function c11200083.coa(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(fcoRemoveQinglan,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil)end
	local g=Duel.SelectMatchingCard(tp,fcoRemoveQinglan,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,999,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	e:SetLabel((g:IsExists(Card.IsType,1,nil,TYPE_MONSTER)and 1 or 0)+(g:IsExists(Card.IsType,1,nil,TYPE_SPELL)and 2 or 0))
	Duel.SetOperationInfo(0,CATEGORY_SEARCH,nil,e:GetLabel(),tp,LOCATION_DECK)
end
function c11200083.opa(e,tp)
	if not e:GetHandler():IsRelateToEffect(e)then return end
	if e:GetLabel()%2>0 then Duel.Remove(Duel.SelectMatchingCard(tp,fcoRemoveQinglanMon,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil),POS_FACEUP,REASON_EFFECT)end
	if e:GetLabel()>1 then Duel.Remove(Duel.SelectMatchingCard(tp,fcoRemoveQinglanSp,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil),POS_FACEUP,REASON_EFFECT)end
end
function c11200083.vb(e,re,tp)
	return re:GetHandlerPlayer()~=e:GetHandlerPlayer()and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end