--直树美纪
function c75646022.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--pendulum set
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(0x1)
	e3:SetType(0x40)
	e3:SetRange(0x200)
	e3:SetCountLimit(1,75646022)
	e3:SetCost(c75646022.cost)
	e3:SetCondition(c75646022.pencon)
	e3:SetTarget(c75646022.pentg)
	e3:SetOperation(c75646022.penop)
	c:RegisterEffect(e3) 
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x200)
	e1:SetType(0x40)
	e1:SetCountLimit(1,7564602)
	e1:SetRange(0x4)
	e1:SetCost(c75646022.scost)
	e1:SetTarget(c75646022.tg)
	e1:SetOperation(c75646022.op)
	c:RegisterEffect(e1)
	--th
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(0x8)
	e2:SetType(0x81)
	e2:SetProperty(0x14000)
	e2:SetCode(1017)
	e2:SetCountLimit(1,5646022)
	e2:SetTarget(c75646022.drtg)
	e2:SetOperation(c75646022.drop)
	c:RegisterEffect(e2)
end
function c75646022.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,Card.IsReleasable,1,nil) end
	local g=Duel.SelectReleaseGroupEx(tp,c75646022.cfilter,1,1,nil)
	Duel.Release(g,0x80)
end
function c75646022.pencon(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),0x8,13-seq)
	return not tc
end
function c75646022.penfilter(c)
	return c:GetAttack()==1750 and c:GetDefense()==1350 and c:IsType(0x1000000) and not c:IsCode(75646022) and not c:IsForbidden()
end
function c75646022.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable()
		and Duel.IsExistingMatchingCard(c75646022.penfilter,tp,0x1,0,1,nil) end
	Duel.SetOperationInfo(0,0x1,e:GetHandler(),1,0,0)
end
function c75646022.penop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(3,tp,527)
	local g=Duel.SelectMatchingCard(tp,c75646022.penfilter,tp,0x1,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,0x8,0x5,true)
		Duel.BreakEffect()
		if Duel.SelectYesNo(tp,aux.Stringid(75646022,0)) then
			Duel.Destroy(e:GetHandler(),0x40)
		end
	end
end
function c75646022.sfilter(c)
	return not c:IsCode(75646022)
end
function c75646022.scost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c75646022.sfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c75646022.sfilter,1,1,nil)
	Duel.Release(g,0x80)
end
function c75646022.filter(c,e,tp)
	return c:GetAttack()==1750 and c:GetDefense()==1350 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(75646022)
end
function c75646022.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>-1
		and Duel.IsExistingMatchingCard(c75646022.filter,tp,0x1,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,0x200,nil,1,tp,0x1)
end
function c75646022.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,0x4)<=0 then return end
	Duel.Hint(3,tp,509)
	local g=Duel.SelectMatchingCard(tp,c75646022.filter,tp,0x1,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,0x5)
	end
end
function c75646022.thfilter(c)
	return c:GetAttack()==1750 and c:GetDefense()==1350 and c:IsAbleToHand() and not c:IsCode(75646022)
end
function c75646022.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646022.thfilter,tp,0x1,0,1,nil) end
	Duel.SetOperationInfo(0,0x8,nil,1,tp,0x1)
end
function c75646022.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(3,tp,506)
	local g=Duel.SelectMatchingCard(tp,c75646022.thfilter,tp,0x1,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,0x40)
		Duel.ConfirmCards(1-tp,g)
	end
end