--Stella-星末
function c75646121.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75646121,0))
	e1:SetCategory(0x20008)
	e1:SetType(0x40)
	e1:SetCountLimit(1,75646121)
	e1:SetRange(4)
	e1:SetCost(c75646121.cost)
	e1:SetTarget(c75646121.target)
	e1:SetOperation(c75646121.operation)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646121,1))
	e2:SetCategory(0x80000)
	e2:SetType(0x40)
	e2:SetRange(4)
	e2:SetCountLimit(1)
	e2:SetCost(c75646121.dacost)
	e2:SetTarget(c75646121.tg)
	e2:SetOperation(c75646121.op)
	c:RegisterEffect(e2)
end
function c75646121.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,0x80) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,0x80)
end
function c75646121.thfilter(c)
	return c:IsSetCard(0x62c3) and c:IsAbleToHand()
end
function c75646121.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646121.thfilter,tp,0x1,0,1,nil) end
	Duel.SetOperationInfo(0,0x8,nil,1,tp,0x1)
end
function c75646121.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(3,tp,506)
	local g=Duel.SelectMatchingCard(tp,c75646121.thfilter,tp,0x1,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,0x40)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c75646121.cfilter(c)
	return c:IsSetCard(0x62c3) and c:IsType(0x1) and c:GetBaseAttack()>0 and c:IsAbleToGraveAsCost()
end
function c75646121.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646121.cfilter,tp,0x2,0,1,nil) end
	Duel.Hint(3,tp,504)
	local g=Duel.SelectMatchingCard(tp,c75646121.cfilter,tp,0x2,0,1,1,nil)
	Duel.SendtoGrave(g,0x80)
	e:SetLabel(g:GetFirst():GetBaseAttack())
end
function c75646121.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,e:GetLabel())
end
function c75646121.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,0x80,0x100)
	if Duel.Damage(p,d,0x40)~=0 then
	Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0)
	end
end