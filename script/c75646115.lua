--Stella-星夏
function c75646115.initial_effect(c)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(2)
	e2:SetRange(4)
	e2:SetCode(29)
	e2:SetTargetRange(6,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x62c3))
	c:RegisterEffect(e2)
	--damge
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(75646115,0))
	e5:SetCategory(0x80000)
	e5:SetType(0x82)
	e5:SetRange(4)
	e5:SetCountLimit(1,75646115)
	e5:SetProperty(0x10000)
	e5:SetCode(0x10000000+75646112)
	e5:SetTarget(c75646115.tg)
	e5:SetOperation(c75646115.op)
	c:RegisterEffect(e5)
end
function c75646115.damfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x62c3)
end
function c75646115.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c75646115.damfilter,tp,0x0c,0,nil)
	if chk==0 then return ct>0 end
	Duel.SetTargetParam(ct*400)
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,ct*300)
end
function c75646115.op(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c75646115.damfilter,tp,0x0c,0,nil)
	if Duel.Damage(1-tp,ct*300,0x40)~=0 then
	local c=e:GetHandler()
	Duel.RaiseEvent(c,0x10000000+75646112,e,0,tp,0,0)
	end
end
