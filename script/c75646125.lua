--Stella-星夏
function c75646122.initial_effect(c)
		--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(0x2)
	e1:SetCode(34)
	e1:SetProperty(0x40000)
	e1:SetRange(0x2)
	e1:SetCondition(c75646122.spcon)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(0x2)
	e2:SetRange(4)
	e2:SetCode(29)
	e2:SetTargetRange(0x6,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x62c3))
	c:RegisterEffect(e2)
	--damge
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(75646122,0))
	e5:SetCategory(0x80000)
	e5:SetType(0x82)
	e5:SetRange(0x4)
	e5:SetCountLimit(1,75646122)
	e5:SetProperty(0x10000)
	e5:SetCode(0x10000000+75646112)
	e5:SetTarget(c75646122.tg)
	e5:SetOperation(c75646122.op)
	c:RegisterEffect(e5)
end
function c75646122.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x62c3) 
end
function c75646122.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),0x4)>0 and
		Duel.IsExistingMatchingCard(c75646122.filter1,c:GetControler(),0x4,0,1,nil)
end
function c75646122.damfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x62c3)
end
function c75646122.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c75646122.damfilter,tp,0x0c,0,nil)
	if chk==0 then return ct>0 end
	Duel.SetTargetParam(ct*400)
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,ct*300)
end
function c75646122.op(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c75646122.damfilter,tp,0x0c,0,nil)
	if Duel.Damage(1-tp,ct*300,0x40)~=0 then
	local c=e:GetHandler()
	Duel.RaiseEvent(c,0x10000000+75646112,e,0,tp,0,0)
	end
