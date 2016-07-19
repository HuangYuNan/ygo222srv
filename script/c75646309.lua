--双重线圈
function c75646309.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x200)
	e1:SetType(0x0010)
	e1:SetCode(1002)
	e1:SetCost(c75646309.cost)
	e1:SetOperation(c75646309.activate)
	c:RegisterEffect(e1)
   --cannot remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646309,0))
	e2:SetType(0x0002)
	e2:SetCode(67)
	e2:SetRange(0x08)
	e2:SetTargetRange(0x04,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x32c3))
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(0x0001)
	e3:SetProperty(0x20000)
	e3:SetRange(0x08)
	e3:SetCode(1)
	e3:SetValue(c75646309.val)
	c:RegisterEffect(e3)
end
function c75646309.val(e,re)
	return re:GetHandler():IsSetCard(0x52c3) and not re:GetHandler():IsCode(75646309)
end
function c75646309.costfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x52c3) 
		and not c:IsCode(75646309)
		and c:IsAbleToGraveAsCost()
end
function c75646309.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646309.costfilter,tp,0x0c,0,2,nil) end
	Duel.Hint(3,tp,504)
	local g=Duel.SelectMatchingCard(tp,c75646309.costfilter,tp,0x0c,0,2,2,nil)
	Duel.SendtoGrave(g,0x80)
end
function c75646309.spfilter(c,e,tp)
	return c:IsSetCard(0x32c3)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646309.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,0x4)<=0 then return end
	local g=Duel.GetMatchingGroup(c75646309.spfilter,tp,0x21,0,nil,e,tp)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(75646309,0)) then
		Duel.Hint(3,tp,509)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,0x5)
	end
end