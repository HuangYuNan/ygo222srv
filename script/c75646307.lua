--NUMBERS线圈
function c75646307.initial_effect(c)
	--Activate
	local e4=Effect.CreateEffect(c)
	e4:SetType(0x0010)
	e4:SetCode(1002)
	c:RegisterEffect(e4)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(0x0002)
	e2:SetRange(0x08)
	e2:SetCode(29)
	e2:SetTargetRange(0x6,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x32c3))
	c:RegisterEffect(e2)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x4)
	e1:SetType(0x201)
	e1:SetProperty(0x14000)
	e1:SetCode(1011)
	e1:SetCondition(c75646307.con)
	e1:SetOperation(c75646307.op)
	c:RegisterEffect(e1)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(0x200000)
	e3:SetType(0x202)
	e3:SetRange(0x08)
	e3:SetCountLimit(1)
	e3:SetCode(0x1200)
	e3:SetTarget(c75646307.atktg)
	e3:SetOperation(c75646307.atkop)
	c:RegisterEffect(e3)
end

function c75646307.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(0x5) and e:GetHandler():IsPreviousLocation(0x08)
end
function c75646307.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0x0c,0x0c)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.Remove(sg,0x5,0x40)
end
function c75646307.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c75646307.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x32c3)
end
function c75646307.atkop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c75646307.filter,tp,0x04,0,nil)
	local c=e:GetHandler()
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(0x0001)
		e1:SetCode(100)
		e1:SetValue(300)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
end