--Stella-星辰
function c75646119.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(0x2)
	e1:SetCode(34)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(0x2)
	e1:SetCountLimit(1,75646119)
	e1:SetCondition(c75646119.spcon)
	c:RegisterEffect(e1)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(75646119,0))
	e5:SetCategory(0x20008+CATEGORY_DAMAGE)
	e5:SetType(0x82)
	e5:SetRange(0x4)
	e5:SetCountLimit(1,7564619)
	e5:SetCode(0x10000000+75646112)
	e5:SetCost(c75646119.cost)
	e5:SetTarget(c75646119.thtg)
	e5:SetOperation(c75646119.thop)
	c:RegisterEffect(e5)
	Duel.AddCustomActivityCounter(75646119,3,c75646119.counterfilter)
end
function c75646119.counterfilter(c)
	return c:IsSetCard(0x62c3) or c:GetSummonLocation()~=0x40 
end
function c75646119.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(75646119,tp,3)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(0x2)
	e1:SetCode(22)
	e1:SetProperty(0x800+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c75646126.splimit)
	e1:SetReset(RESET_PHASE+0x200)
	Duel.RegisterEffect(e1,tp)
end
function c75646119.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x62c3) and c:IsLocation(0x40)
end
function c75646119.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x62c3) 
end
function c75646119.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),0x4)>0 and
		Duel.IsExistingMatchingCard(c75646119.filter1,c:GetControler(),0x4,0,1,nil)
end
function c75646119.thfilter(c)
	return c:IsSetCard(0x62c3) and c:IsAbleToHand()
end
function c75646119.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646119.thfilter,tp,0x1,0,1,nil) end
	Duel.SetOperationInfo(0,0x8,nil,1,tp,0x1)
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,100)
end
function c75646119.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(3,tp,506)
	local g=Duel.SelectMatchingCard(tp,c75646119.thfilter,tp,0x1,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,0x40)
		Duel.ConfirmCards(1-tp,g)
		if Duel.Damage(1-tp,100,0x40)~=0 then
		local c=e:GetHandler()
		Duel.RaiseEvent(c,0x10000000+75646112,e,0,tp,0,0)
		end
	end   
end