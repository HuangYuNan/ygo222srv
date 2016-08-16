--Stella-星时
function c75646117.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75646117,0))
	e1:SetCategory(0x200)
	e1:SetType(0x40)
	e1:SetCountLimit(1,75646117)
	e1:SetRange(0x4)
	e1:SetCost(c75646117.spcost)
	e1:SetTarget(c75646117.sptg)
	e1:SetOperation(c75646117.spop)
	c:RegisterEffect(e1)	
	--spsummon2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646117,1))
	e2:SetCategory(0x200)
	e2:SetType(0x82)
	e2:SetCode(0x10000000+75646112)
	e2:SetRange(0x10)
	e2:SetProperty(0x10000)
	e2:SetCountLimit(1,7564617)
	e2:SetTarget(c75646117.sptg1)
	e2:SetOperation(c75646117.spop1)
	c:RegisterEffect(e2)
end
function c75646117.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x62c3) 
		and c:IsAbleToGraveAsCost()
end
function c75646117.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646117.cfilter,tp,0xc,0,1,nil) end
	Duel.Hint(3,tp,504)
	local g=Duel.SelectMatchingCard(tp,c75646117.cfilter,tp,0xc,0,1,1,nil)
	Duel.SendtoGrave(g,0x80)
end
function c75646117.filter(c,e,tp)
	return c:IsSetCard(0x62c3) and c:IsType(0x1) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646117.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>0
		and Duel.IsExistingMatchingCard(c75646117.filter,tp,0x1,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,0x200,nil,1,tp,0x1)
end
function c75646117.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,0x4)<=0 then return end
	Duel.Hint(3,tp,509)
	local g=Duel.SelectMatchingCard(tp,c75646117.filter,tp,0x1,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,0x5)
	end
end
function c75646117.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,0x200,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,700)
end
function c75646117.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then 
	Duel.SpecialSummon(c,0,tp,tp,false,false,0x5)
		if Duel.Damage(1-tp,700,0x40)~=0 then 
		Duel.RaiseEvent(c,0x10000000+75646112,e,0,tp,0,0)
		end
	end
end