--Stella-rium
function c75646109.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x20008)
	e1:SetType(16)
	e1:SetCode(1002)
	e1:SetCountLimit(1,75646109+0x10000000)
	e1:SetTarget(c75646109.target)
	e1:SetOperation(c75646109.activate)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(2)
	e2:SetCode(113)
	e2:SetRange(8)
	e2:SetTargetRange(4,0)
	e2:SetTarget(c75646109.tgtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2) 
end
function c75646109.filter(c)
	return (c:IsSetCard(0x2c0) or c:IsSetCard(0x62c3)) 
	and c:IsAbleToHand() and not c:IsCode(75646109) and c:IsType(2)
end
function c75646109.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646109.filter,tp,1,0,1,nil) end
	Duel.SetOperationInfo(0,8,nil,1,tp,1)
end
function c75646109.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(3,tp,506)
	local g=Duel.SelectMatchingCard(tp,c75646109.filter,tp,1,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,0x40)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c75646109.tgtg(e,c)
	return c:IsSetCard(0x2c0)
end