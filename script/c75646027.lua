--想·和·你·做·朋·友
function c75646027.initial_effect(c)
	--Equip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP+CATEGORY_CONTROL)
	e1:SetType(0x10)
	e1:SetCode(1002)
	e1:SetProperty(0x10)
	e1:SetCondition(c75646027.condition)
	e1:SetCost(c75646027.cost)
	e1:SetTarget(c75646027.target)
	e1:SetOperation(c75646027.activate)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(0x1)
	e2:SetCode(76)
	e2:SetProperty(0x400)
	e2:SetValue(c75646027.eqlimit)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetType(0x4)
	e3:SetCode(4)
	e3:SetValue(c75646027.cval)
	c:RegisterEffect(e3)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(0x4)
	e4:SetCode(101)
	e4:SetValue(1750)
	c:RegisterEffect(e4)
	--def
	local e5=Effect.CreateEffect(c)
	e5:SetType(0x4)
	e5:SetCode(105)
	e5:SetValue(1350)
	c:RegisterEffect(e5)
	--maintain
	local e6=Effect.CreateEffect(c)
	e6:SetType(0x802)
	e6:SetProperty(0x400+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(0x1200)
	e6:SetRange(0x8)
	e6:SetCountLimit(1)
	e6:SetCondition(c75646027.mtcon)
	e6:SetOperation(c75646027.mtop)
	c:RegisterEffect(e6)
end
function c75646027.cfilte(c)
	return c:IsFaceup() and c:IsReleasable()
end
function c75646027.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c75646027.cfilte,tp,0xc,0,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,c75646027.cfilte,tp,0xc,0,1,1,e:GetHandler())
	Duel.Release(g,0x80)
end
function c75646027.cfilter(c)
	return c:IsFaceup() and c:GetAttack()==1750 and c:GetDefense()==1350
	and c:IsType(0x1)
end
function c75646027.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c75646027.cfilter,tp,0x4,0,1,nil)
end
function c75646027.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c75646027.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x4) and chkc:IsControler(1-tp) and c75646027.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646027.filter,tp,0,0x4,1,nil) end
	Duel.Hint(3,tp,518)
	local g=Duel.SelectTarget(tp,c75646027.filter,tp,0,0x4,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,0x2000,g,1,0,0)
end
function c75646027.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c75646027.eqlimit(e,c)
	return e:GetHandlerPlayer()~=c:GetControler() or e:GetHandler():GetEquipTarget()==c
end
function c75646027.cval(e,c)
	return e:GetHandlerPlayer()
end
function c75646027.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c75646027.rfilter(c)
	return c:IsType(0x1) and c:IsReleasableByEffect()
end
function c75646027.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckReleaseGroupEx(tp,c75646027.rfilter,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(75646027,0)) then
		local g=Duel.SelectReleaseGroupEx(tp,c75646027.rfilter,1,1,nil)
		Duel.Release(g,0x80)
	else
		Duel.SendtoGrave(e:GetHandler(),0x400)
	end
end