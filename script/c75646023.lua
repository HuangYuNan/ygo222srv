--若狭悠里
function c75646023.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--sp
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x201)
	e1:SetType(0x40)
	e1:SetRange(0x200)
	e1:SetCountLimit(1,75646023)
	e1:SetCost(c75646023.cost)
	e1:SetTarget(c75646023.target)
	e1:SetOperation(c75646023.operation)
	c:RegisterEffect(e1)
	--sp
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(0x200)
	e3:SetType(0x40)
	e3:SetCountLimit(1,7564603)
	e3:SetRange(0x4)
	e3:SetTarget(c75646023.tg)
	e3:SetOperation(c75646023.op)
	c:RegisterEffect(e3)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(0x80)
	e2:SetType(0x81)
	e2:SetProperty(0x14000)
	e2:SetCode(1017)
	e2:SetCountLimit(1,5646023)
	e2:SetTarget(c75646023.drtg)
	e2:SetOperation(c75646023.drop)
	c:RegisterEffect(e2)
end
function c75646023.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true end
end
function c75646023.cfilter(c,e,tp)
	return c:GetAttack()==1750 and c:GetDefense()==1350 
		and Duel.IsExistingMatchingCard(c75646023.thfilter,tp,0x1,0,1,nil,e,tp,c:GetCode())
end
function c75646023.thfilter(c,e,tp,code)
	return not c:IsCode(code) and c:GetAttack()==1750 and c:GetDefense()==1350 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646023.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,0x4)>0 and Duel.CheckReleaseGroup(tp,c75646023.cfilter,1,nil,e,tp)
	end
	local g=Duel.SelectReleaseGroup(tp,c75646023.cfilter,1,1,nil,e,tp)
	local rc=g:GetFirst()
	e:SetValue(rc:GetCode())
	Duel.Release(rc,0x80)
	Duel.SetOperationInfo(0,0x200,nil,1,tp,0x1)
end
function c75646023.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,0x4)<=0 then return end
	Duel.Hint(3,tp,509)
	local g=Duel.SelectMatchingCard(tp,c75646023.thfilter,tp,0x1,0,1,1,nil,e,tp,e:GetValue())
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,0x5)
		if Duel.SelectYesNo(tp,aux.Stringid(75646020,0)) then
			Duel.Destroy(e:GetHandler(),0x40)
		end
	end
end
function c75646023.filter1(c,e,tp)
	return c:GetAttack()==1750 and c:GetDefense()==1350 and c:IsType(0x1000000) and (c:IsLocation(0x10) or c:IsFaceup()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646023.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646023.filter1,tp,0x50,0,1,nil,e,tp) and Duel.GetLocationCount(tp,0x4)>0 end
	Duel.SetOperationInfo(0,0x8,nil,1,tp,0)
end
function c75646023.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,0x4)<=0 then return end
	local g=Duel.GetMatchingGroup(c75646023.filter1,tp,0x50,0,nil,e,tp)
	if g:GetCount()<1 then return end
	Duel.Hint(3,tp,509)
	local sg=g:Select(tp,1,1,nil)
	if sg:IsExists(Card.IsHasEffect,1,nil,291) then return end
	Duel.SpecialSummon(sg,0,tp,tp,false,false,0x5)
end
function c75646023.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,0x2)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c75646023.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(1-tp,0x2,0,nil)
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoGrave(sg,0x4040)
end