--Stella-星愿
function c75646113.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x80008)
	e1:SetType(0x10)
	e1:SetCode(1002)
	e1:SetProperty(0x10)
	e1:SetCountLimit(1,75646113+0x10000000)
	e1:SetTarget(c75646113.target)
	e1:SetOperation(c75646113.activate)
	c:RegisterEffect(e1)
end
function c75646113.filter(c)
	return c:IsSetCard(0x62c3) and c:IsType(0x1) and c:IsAbleToHand()
end
function c75646113.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x10) and chkc:IsControler(tp) and c75646113.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646113.filter,tp,0x10,0,1,nil) end
	Duel.Hint(3,tp,551)
	local g=Duel.SelectTarget(tp,c75646113.filter,tp,0x10,0,1,1,nil)
	local atk=g:GetFirst():GetBaseAttack()/2
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,atk)
	Duel.SetOperationInfo(0,0x8,g,1,0,0)
end
function c75646113.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Damage(1-tp,tc:GetBaseAttack()/2,0x40)~=0 then
		Duel.BreakEffect()
		Duel.SendtoHand(tc,nil,0x40)
		Duel.ConfirmCards(1-tp,tc)
		Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0)
	end
end