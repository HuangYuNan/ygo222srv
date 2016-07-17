--死亡线圈
function c75646312.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(0x0010)
	e1:SetCode(1002)
	e1:SetTarget(c75646312.target)
	c:RegisterEffect(e1)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(0x0002)
	e3:SetCode(100)
	e3:SetRange(0x08)
	e3:SetTargetRange(0x04,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x32c3))
	e3:SetValue(700)
	c:RegisterEffect(e3)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(0x4)
	e2:SetType(0x201)
	e2:SetProperty(0x14000)
	e2:SetCode(1011)
	e2:SetCondition(c75646312.con)
	e2:SetOperation(c75646312.op)
	c:RegisterEffect(e2)
end
function c75646312.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(0x802)
	e1:SetProperty(0x0400)
	e1:SetRange(0x08)
	e1:SetCode(0x1200)
	e1:SetLabel(2)
	e1:SetCountLimit(1)
	e1:SetCondition(c75646312.tgcon)
	e1:SetOperation(c75646312.tgop)
	e1:SetReset(0x51fe1200)
	e:GetHandler():RegisterEffect(e1)
end
function c75646312.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c75646312.tgop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	ct=ct-1
	e:SetLabel(ct)
	if ct==0 then
		Duel.Remove(e:GetHandler(),0x5,0x40)
	end
end
function c75646312.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(0x5) and e:GetHandler():IsPreviousLocation(0x08)
end
function c75646312.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0x0c,0x0c)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.Remove(sg,0x5,0x40)
end