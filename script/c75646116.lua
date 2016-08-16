--Stella-星夜
function c75646116.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75646116,0))
	e1:SetCategory(0x80000)
	e1:SetType(0x100)
	e1:SetCode(1131)
	e1:SetRange(0x2)
	e1:SetCondition(c75646116.nacon)
	e1:SetCost(c75646116.nacost)
	e1:SetTarget(c75646116.natg)
	e1:SetOperation(c75646116.naop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646116,1))
	e2:SetCategory(0x200)
	e2:SetType(0x40)
	e2:SetRange(0x10)
	e2:SetCountLimit(1,75646116)
	e2:SetCost(c75646116.spcost)
	e2:SetTarget(c75646116.sptg)
	e2:SetOperation(c75646116.spop)
	c:RegisterEffect(e2)	
end

function c75646116.nacon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsControler(tp) and at:IsFaceup() and at:IsSetCard(0x62c3) 
end
function c75646116.nacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),0x80)
end
function c75646116.natg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsOnField() end
	local dam=Duel.GetAttacker():GetAttack()
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,dam)
end
function c75646116.naop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if Duel.NegateAttack() then
		if Duel.Damage(1-tp,a:GetAttack(),0x40)~=0 then
		Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0)
		end
	end
end
function c75646116.cfilter(c)
	return c:IsSetCard(0x62c3) and c:IsAbleToGraveAsCost()
end
function c75646116.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646116.cfilter,tp,0xc,0,1,nil) end
	Duel.Hint(3,tp,504)
	local g=Duel.SelectMatchingCard(tp,c75646116.cfilter,tp,0xc,0,1,1,nil)
	Duel.SendtoGrave(g,0x80)
end
function c75646116.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,0x200,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,900)
end
function c75646116.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
	Duel.SpecialSummon(c,0,tp,tp,false,false,0x5)
		if Duel.Damage(1-tp,900,0x40)~=0 then 
		Duel.RaiseEvent(c,0x10000000+75646112,e,0,tp,0,0)
		end
	end
end