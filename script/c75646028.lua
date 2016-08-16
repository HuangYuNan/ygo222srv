--一起活下去
function c75646028.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x20008)
	e1:SetType(0x10)
	e1:SetCode(1017)
	e1:SetCountLimit(1,75646028+EFFECT_COUNT_CODE_OATH)
	e1:SetProperty(0x4000+EFFECT_FLAG_DELAY)
	e1:SetCondition(c75646028.condition)
	e1:SetTarget(c75646028.target)
	e1:SetOperation(c75646028.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(0x802)
	e2:SetCode(50)
	e2:SetRange(0x10)
	e2:SetTarget(c75646028.reptg)
	e2:SetValue(c75646028.repval)
	e2:SetOperation(c75646028.repop)
	c:RegisterEffect(e2)
end
function c75646028.ctfilter(c,tp)
	return c:IsReason(0x2) and c:IsPreviousLocation(0xe)
end
function c75646028.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c75646028.ctfilter,1,nil,tp)
end
function c75646028.filter(c)
	return c:GetAttack()==1750 and c:GetDefense()==1350 and c:IsAbleToHand()
end
function c75646028.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646028.filter,tp,1,0,1,nil) end
	Duel.SetOperationInfo(0,0x8,nil,1,tp,1)
end
function c75646028.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(3,tp,506)
	local g=Duel.SelectMatchingCard(tp,c75646028.filter,tp,0x1,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,0x40)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c75646028.repfilter(c,tp)
	return c:IsFaceup() and (c:GetAttack()==1750 and c:GetDefense()==1350 or not c:IsType(c:GetOriginalType())) and c:IsLocation(0xc)
		and c:IsControler(tp) and c:IsReason(0x60)
end
function c75646028.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c75646028.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(75646028,0))
end
function c75646028.repval(e,c)
	return c75646028.repfilter(c,e:GetHandlerPlayer())
end
function c75646028.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),5,0x40)
end