--惠飞须泽胡桃
function c75646021.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(0x10081)
	e2:SetCountLimit(1,75646021)
	e2:SetType(0x40)
	e2:SetRange(0x200)
	e2:SetCost(c75646021.cost)
	e2:SetTarget(c75646021.drtg)
	e2:SetOperation(c75646021.drop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(0x8)
	e3:SetType(0x40)
	e3:SetCountLimit(1,7564601)
	e3:SetRange(0x4)
	e3:SetTarget(c75646021.tg)
	e3:SetOperation(c75646021.op)
	c:RegisterEffect(e3)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x1)
	e1:SetType(0x81)
	e1:SetProperty(0x14000)
	e1:SetCode(1017)
	e1:SetCountLimit(1,5646021)
	e1:SetTarget(c75646021.detg)
	e1:SetOperation(c75646021.deop)
	c:RegisterEffect(e1)
end
function c75646021.cfilter(c)
	return c:GetAttack()==1750 and c:GetDefense()==1350
end
function c75646021.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,c75646021.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroupEx(tp,c75646021.cfilter,1,1,nil)
	Duel.Release(g,0x80)
end
function c75646021.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) 
	and e:GetHandler():IsDestructable() end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,0x1,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,0x10000,nil,0,tp,2)
	Duel.SetOperationInfo(0,0x80,nil,0,tp,1)
end
function c75646021.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.Destroy(e:GetHandler(),0x40)~=0 then
		local p=Duel.GetChainInfo(0,0x80)
		if Duel.Draw(p,2,0x40)==2 then
		Duel.ShuffleHand(tp)
		Duel.BreakEffect()
		Duel.DiscardHand(tp,nil,1,1,0x40+0x4000)
		end
	end
end
function c75646021.filter(c)
	return  c:GetAttack()==1750 and c:GetDefense()==1350 and c:IsType(0x100000) and (c:IsLocation(0x10) or c:IsFaceup()) and c:IsAbleToHand()
end
function c75646021.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646021.filter,tp,0x50,0,1,nil) end
	Duel.SetOperationInfo(0,0x8,nil,1,tp,0)
end
function c75646021.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c75646021.filter,tp,0x50,0,nil)
	if g:GetCount()<1 then return end
	Duel.Hint(3,tp,506)
	local sg=g:Select(tp,1,1,nil)
	if sg:IsExists(Card.IsHasEffect,1,nil,291) then return end
	Duel.SendtoHand(sg,nil,0x40)
	Duel.ConfirmCards(1-tp,sg)
end
function c75646021.detg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x4) and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,0x4,1,nil) end
	Duel.Hint(3,tp,502)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,0x4,1,1,nil)
	Duel.SetOperationInfo(0,0x1,g,1,0,0)
end
function c75646021.deop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,0x40)
	end
end