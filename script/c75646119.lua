--Stella-星辰
function c75646119.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(2)
	e1:SetCode(34)
	e1:SetProperty(0x40000)
	e1:SetRange(2)
	e1:SetCondition(c75646119.spcon)
	c:RegisterEffect(e1)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(75646119,0))
	e5:SetCategory(0x20008)
	e5:SetType(0x82)
	e5:SetRange(4)
	e5:SetCountLimit(1,75646119)
	e5:SetCode(0x10000000+75646112)
	e5:SetTarget(c75646119.thtg)
	e5:SetOperation(c75646119.thop)
	c:RegisterEffect(e5)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646119,1))
	e2:SetCategory(0x80000)
	e2:SetType(0x40)
	e2:SetRange(2)
	e2:SetCountLimit(1,7564619)
	e2:SetCost(c75646119.cost)
	e2:SetTarget(c75646119.damtg)
	e2:SetOperation(c75646119.damop)
	c:RegisterEffect(e2)
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
end
function c75646119.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(3,tp,506)
	local g=Duel.SelectMatchingCard(tp,c75646119.thfilter,tp,0x1,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,0x40)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c75646119.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),0x80)
end
function c75646119.damfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x62c3)
end
function c75646119.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c75646119.damfilter,tp,0x0c,0,nil)
	if chk==0 then return ct>0 end
	Duel.SetTargetParam(ct*400)
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,ct*400)
end
function c75646119.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c75646119.damfilter,tp,0x0c,0,nil)
	if Duel.Damage(1-tp,ct*400,0x40)~=0 then
	local c=e:GetHandler()
	Duel.RaiseEvent(c,0x10000000+75646112,e,0,tp,0,0)
	end
end