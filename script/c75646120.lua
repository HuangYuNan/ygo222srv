--Stella-星珖
function c75646120.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(0x802)
	e1:SetCode(1027)
	e1:SetRange(0x4)
	e1:SetProperty(0x400)
	e1:SetOperation(c75646120.regop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(0x802)
	e2:SetCode(1022)
	e2:SetRange(0x4)
	e2:SetCondition(c75646120.damcon)
	e2:SetOperation(c75646120.damop)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(0x80200)
	e3:SetType(0x81)
	e3:SetCode(1014)
	e3:SetProperty(0x10000)
	e3:SetTarget(c75646120.tgtg)
	e3:SetOperation(c75646120.tgop)
	c:RegisterEffect(e3)
end
function c75646120.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(75646120,0x1000+0x1fc0000+0x80000000,0,1)
end
function c75646120.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return re:GetHandler():IsSetCard(0x62c3) 
		and c:GetFlagEffect(75646120)~=0
end
function c75646120.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(10,0,75646120)
	if Duel.Damage(1-tp,500,0x400)~=0 then
	Duel.RaiseEvent(c,0x10000000+75646112,e,0,tp,0,0)
	end
end
function c75646120.filter(c,e,tp)
	return c:IsSetCard(0x62c3) and not c:IsCode(75646120) and c:IsType(0x1) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646120.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x10) and chkc:IsControler(tp) and c75646120.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646120.filter,tp,0x10,0,1,nil,e,tp) end
	Duel.Hint(3,tp,551)
	local g=Duel.SelectTarget(tp,c75646120.filter,tp,0x10,0,1,1,nil,e,tp)
	local atk=g:GetFirst():GetBaseAttack()
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,atk)
	Duel.SetOperationInfo(0,0x200,g,1,0,0)
end
function c75646120.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Damage(1-tp,tc:GetBaseAttack(),0x40)~=0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,0x5)
		Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0)
	end
end