--Stella-星坠
function c75646114.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75646114,0))  
	e1:SetCategory(512)
	e1:SetType(16)
	e1:SetCode(1002)
	e1:SetCountLimit(1,75646114+0x10000000)
	e1:SetCondition(c75646114.condition)
	e1:SetCost(c75646114.cost)
	e1:SetTarget(c75646114.target)
	e1:SetOperation(c75646114.activate)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646114,1))
	e2:SetCategory(0x80000)
	e2:SetType(64)
	e2:SetRange(16)
	e2:SetProperty(16)
	e2:SetCost(c75646114.dacost)
	e2:SetTarget(c75646114.datg)
	e2:SetOperation(c75646114.daop)
	c:RegisterEffect(e2)
end

function c75646114.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,tp,4,0,1,nil)
end
function c75646114.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,6)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(2)
	e1:SetCode(185)
	e1:SetProperty(0x80800)
	e1:SetTargetRange(1,0)
	e1:SetReset(0x40000200)
	Duel.RegisterEffect(e1,tp)
end
function c75646114.filter(c,e,tp)
	return c:IsSetCard(0x62c3) and c:IsType(1) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646114.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,4)>0
		and Duel.IsExistingMatchingCard(c75646114.filter,tp,1,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,512,nil,1,tp,1)
end
function c75646114.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,4)<=0 then return end
	Duel.Hint(3,tp,509)
	local g=Duel.SelectMatchingCard(tp,c75646114.filter,tp,1,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,5)
	end
end

function c75646114.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),5,128)
end
function c75646114.filter1(c)
	return c:IsSetCard(0x62c3) and c:IsType(1) 
end
function c75646114.datg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(4) and chkc:IsControler(tp) and c75646114.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646114.filter1,tp,4,0,1,nil) end
	Duel.Hint(3,tp,551)
	local g=Duel.SelectTarget(tp,c75646114.filter1,tp,4,0,1,1,nil)
	local atk=g:GetFirst():GetBaseAttack()
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,atk)
end
function c75646114.daop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.Damage(1-tp,tc:GetBaseAttack(),64)~=0 then
	Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0)
	end
end
