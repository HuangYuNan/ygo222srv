--Stella-星灵
function c75646118.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75646118,0))
	e1:SetCategory(0x80000)
	e1:SetType(0x82)
	e1:SetRange(0x4)
	e1:SetProperty(0x10010)
	e1:SetCode(0x10000000+75646112)
	e1:SetCountLimit(1,75646118)
	e1:SetTarget(c75646118.target)
	e1:SetOperation(c75646118.operation)
	c:RegisterEffect(e1)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(75646118,1))
	e3:SetCategory(0x8)
	e3:SetType(0x40)
	e3:SetRange(0x2)
	e3:SetProperty(0x10)
	e3:SetCountLimit(1,7564618)
	e3:SetCost(c75646118.cost)
	e3:SetTarget(c75646118.tg)
	e3:SetOperation(c75646118.op)
	c:RegisterEffect(e3)
end
function c75646118.filter(c)
	return c:IsFaceup() and c:GetBaseAttack()>0
end
function c75646118.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(0x4) and c75646118.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646118.filter,tp,0,0x4,1,nil) end
	Duel.Hint(3,tp,514)
	local g=Duel.SelectTarget(tp,c75646118.filter,tp,0,0x4,1,1,nil)
	local atk=g:GetFirst():GetBaseAttack()
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,atk)
end
function c75646118.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetBaseAttack()
		if atk<0 then atk=0 end
		if Duel.Damage(1-tp,atk,0x40)~=0 then
		Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0)
		end
	end
end
function c75646118.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable()end
	Duel.SendtoGrave(c,0x4080)
end
function c75646118.filter2(c)
	return c:IsSetCard(0x62c3) and c:IsAbleToHand() and not c:IsCode(75646118)
end
function c75646118.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646118.filter2,tp,0x10,0,1,nil) end
	Duel.SetOperationInfo(0,0x8,nil,1,tp,0x10)
end
function c75646118.op(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(3,tp,506)
	local sg=Duel.SelectMatchingCard(tp,c75646118.filter2,tp,0x10,0,1,1,nil)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,0x40)
		Duel.ConfirmCards(1-tp,sg)
	end
end