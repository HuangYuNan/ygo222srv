function qinglanMon(c)local t=c:GetCode()return t>11200079 and t<11200083 end
function qinglanSp(c)local t=c:GetCode()return t>11200083 and t<11200087 end
function qinglan(c)local t=c:GetCode()return qinglanMon(c)or qinglanSp(c)end
function qinglanCorm(c)return qinglan(c)and c:IsAbleToRemoveAsCost()end
function qinglanRm(c)return qinglan(c)and c:IsAbleToRemove()end
function qinglanUp(c)return qinglan(c)and c:IsFaceup()end
function qinglanMonRm(c)return qinglanMon(c)and c:IsAbleToRemove()end
function qinglanSpRm(c)return qinglanSp(c)and c:IsAbleToRemove()end
function c11200086.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	a:SetCode(EVENT_PHASE+PHASE_BATTLE)
	a:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	a:SetCategory(CATEGORY_DAMAGE)
	a:SetCost(c11200086.coa)
	a:SetOperation(c11200086.opa)
	a:SetCountLimit(1,11200086+EFFECT_COUNT_CODE_DUEL)
	c:RegisterEffect(a)
	if c11200086.t then return end
	c11200086.t={};c11200086.t[0]=0;c11200086.t[1]=0
	c11200086.v={};c11200086.v[0]=0;c11200086.v[1]=0
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	b:SetCode(EVENT_REMOVE)
	b:SetOperation(c11200086.opb)
	Duel.RegisterEffect(b,0)
end
function c11200086.coa(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return
		e:GetHandler():IsAbleToRemoveAsCost()and
		Duel.IsExistingMatchingCard(qinglanCorm,tp,LOCATION_HAND+LOCATION_ONFIELD,0,2,e:GetHandler())and
		(e:GetHandler():IsLocation(LOCATION_HAND)or e:GetHandler():GetTurnID()<Duel.GetTurnCount())
	end
	local g=Duel.SelectMatchingCard(tp,qinglanCorm,tp,LOCATION_HAND+LOCATION_ONFIELD,0,2,2,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,550)
end
function c11200086.opa(e,tp)
	Debug.Message(c11200086.v[tp])
	for i=1,(c11200086.t[tp]==Duel.GetTurnCount()and c11200086.v[tp]or 1)do
		Duel.Damage(1-tp,550,REASON_EFFECT)
	end
end
function c11200086.opb(e,tp,eg,ep,ev,re,r,rp)
	for p=0,1 do if eg:Filter(qinglan,nil):IsExists(Card.IsControler,1,nil,p)then
		if c11200086.t[p]<Duel.GetTurnCount()then
			c11200086.t[p]=Duel.GetTurnCount()
			c11200086.v[p]=0
		end
		c11200086.v[p]=c11200086.v[p]+1
	end end
end