--Prima-Stella
function c75646112.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75646112,0))
	e1:SetCategory(0x20008)
	e1:SetType(16)
	e1:SetCode(1002)
	e1:SetCountLimit(1,75646112)
	e1:SetTarget(c75646112.target)
	e1:SetOperation(c75646112.activate)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646112,1))
	e2:SetCategory(0x10000)
	e2:SetType(130)
	e2:SetCode(0x10000000+75646112)
	e2:SetRange(16)
	e2:SetCountLimit(1,7564612)
	e2:SetProperty(0x10000)
	e2:SetCost(c75646112.cost)
	e2:SetTarget(c75646112.tg)
	e2:SetOperation(c75646112.op)
	c:RegisterEffect(e2)
end
function c75646112.filter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x62c3)
end
function c75646112.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646112.filter,tp,1,0,1,nil) end
	Duel.SetOperationInfo(0,8,nil,1,tp,1)
end
function c75646112.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(3,tp,506)
	local g=Duel.SelectMatchingCard(tp,c75646112.filter,tp,1,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,64)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c75646112.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),5,128)
end
function c75646112.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,0x10000,nil,0,tp,1)
end
function c75646112.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,128,256)
	Duel.Draw(p,d,64)
end