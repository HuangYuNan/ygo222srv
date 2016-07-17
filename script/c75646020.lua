--丈枪由纪
function c75646020.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x20009)
	e1:SetType(0x40)
	e1:SetCountLimit(1,75646020)
	e1:SetRange(0x200)
	e1:SetCost(c75646020.cost)
	e1:SetTarget(c75646020.target)
	e1:SetOperation(c75646020.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(0x200)
	e3:SetType(0x40)
	e3:SetCountLimit(1,7564600)
	e3:SetRange(0x4)
	e3:SetTarget(c75646020.tg)
	e3:SetOperation(c75646020.op)
	c:RegisterEffect(e3)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(0x10000)
	e2:SetType(0x81)
	e2:SetProperty(0x14000)
	e2:SetCode(1017)
	e2:SetCountLimit(1,5646020)
	e2:SetTarget(c75646020.drtg)
	e2:SetOperation(c75646020.drop)
	c:RegisterEffect(e2)
end
function c75646020.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,Card.IsReleasable,1,nil) end
	local g=Duel.SelectReleaseGroupEx(tp,c75646020.cfilter,1,1,nil)
	Duel.Release(g,0x80)
end
function c75646020.thfilter(c)
	return c:GetAttack()==1750 and c:GetDefense()==1350 and c:IsAbleToHand() and not c:IsCode(75646020)
end
function c75646020.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646020.thfilter,tp,0x1,0,1,nil) end
	Duel.SetOperationInfo(0,0x8,nil,1,tp,0x1)
end
function c75646020.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(3,tp,506)
	local g=Duel.SelectMatchingCard(tp,c75646020.thfilter,tp,0x1,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,0x40)
		Duel.ConfirmCards(1-tp,g)
		Duel.BreakEffect()
		if Duel.SelectYesNo(tp,aux.Stringid(75646020,0)) then
			Duel.Destroy(e:GetHandler(),0x40)
		end
	end
end
function c75646020.filter(c,e,tp)
	return c:GetAttack()==1750 and c:GetDefense()==1350 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(75646020)
end
function c75646020.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>0
		and Duel.IsExistingMatchingCard(c75646020.filter,tp,0x2,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,0x200,nil,1,tp,0x2)
end
function c75646020.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,0x4)<=0 then return end
	Duel.Hint(3,tp,509)
	local g=Duel.SelectMatchingCard(tp,c75646020.filter,tp,0x2,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,0x5)
	end
end
function c75646020.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,0x10000,nil,0,tp,1)
end
function c75646020.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,0x40)
end