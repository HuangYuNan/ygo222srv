--Stella-星坠
function c75646114.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75646114,0))  
	e1:SetCategory(0x80200)
	e1:SetType(0x10)
	e1:SetCode(1002)
	e1:SetCountLimit(1,75646114+0x10000000)
	e1:SetCondition(c75646114.condition)
	e1:SetCost(c75646114.cost)
	e1:SetTarget(c75646114.target)
	e1:SetOperation(c75646114.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(75646114,3,c75646114.counterfilter)
end

function c75646114.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0x4,0,1,nil)
end
function c75646114.counterfilter(c)
	return c:IsSetCard(0x62c3) or c:GetSummonLocation()~=0x40 
end
function c75646114.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(75646114,tp,3)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(0x2)
	e1:SetCode(22)
	e1:SetProperty(0x800+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c75646114.splimit)
	e1:SetReset(RESET_PHASE+0x200)
	Duel.RegisterEffect(e1,tp)
end
function c75646114.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x62c3) and c:IsLocation(0x40)
end
function c75646114.filter(c,e,tp)
	return c:IsSetCard(0x62c3) and c:IsType(0x1) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646114.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>0
		and Duel.IsExistingMatchingCard(c75646114.filter,tp,0x1,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,0x200,nil,1,tp,0x1)
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,100)
end
function c75646114.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,0x4)<=0 then return end
	Duel.Hint(3,tp,509)
	local g=Duel.SelectMatchingCard(tp,c75646114.filter,tp,0x1,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		if Duel.SpecialSummon(g,0,tp,tp,false,false,0x5)~=0 then 
			if Duel.Damage(1-tp,100,0x40)~=0 then 
			Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0) end
		end
	end 
end
