--Stella-星蝶
function c75646127.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x62c3),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(0x200+CATEGORY_DAMAGE)
	e1:SetType(0x40)
	e1:SetRange(0x4)
	e1:SetCountLimit(1)
	e1:SetCode(1002)
	e1:SetCost(c75646127.spcost)
	e1:SetTarget(c75646127.sptg)
	e1:SetOperation(c75646127.spop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(75646127,3,c75646127.counterfilter)
	--effect gain
	local e2=Effect.CreateEffect(c)
	e2:SetType(0x801)
	e2:SetCode(1108)
	e2:SetCondition(c75646127.efcon)
	e2:SetOperation(c75646127.efop)
	c:RegisterEffect(e2)
end
function c75646127.counterfilter(c)
	return c:IsSetCard(0x62c3) or c:GetSummonLocation()~=LOCATION_EXTRA
end
function c75646127.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(75646127,tp,3)==0 and
	Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,0x2,0,1,e:GetHandler()) end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(0x2)
	e1:SetCode(22)
	e1:SetProperty(0x800+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c75646127.splimit)
	e1:SetReset(RESET_PHASE+0x200)
	Duel.RegisterEffect(e1,tp)
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,0x80+0x4000)
end
function c75646127.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x62c3) and c:IsLocation(0x40)
end
function c75646127.filter(c,e,tp)
	return c:IsSetCard(0x62c3) and c:IsType (0x1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
end
function c75646127.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>0
		and Duel.IsExistingMatchingCard(c75646127.filter,tp,0x1,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,0x200,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,100)
end
function c75646127.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,0x4)<=0 then return end
	Duel.Hint(3,tp,509)
	local g=Duel.SelectMatchingCard(tp,c75646127.filter,tp,0x1,0,1,1,nil,e,tp)
	if Duel.SpecialSummon(g,0,tp,tp,false,false,0x5)~=0 then 
	if Duel.Damage(1-tp,100,0x40)~=0 then 
		Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0)
	end end
end
function c75646127.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c75646127.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75646127,0))
	e1:SetType(0x40)
	e1:SetCode(1002)
	e1:SetRange(0x4)
	e1:SetCountLimit(1,75646127)
	e1:SetCondition(c75646127.matcon)
	e1:SetTarget(c75646127.mattg)
	e1:SetOperation(c75646127.matop)
	e1:SetReset(0x1000+0x1fe0000)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(0x20) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(0x1)
		e2:SetCode(115)
		e2:SetValue(0x20)
		e2:SetReset(0x1000+0x1fe0000)
		rc:RegisterEffect(e2,true)
	end
end
function c75646127.matcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ 
end
function c75646127.matfilter(c)
	return c:IsDestructable() and c:IsType(0x1)
end
function c75646127.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c75646127.matfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646127.matfilter,tp,0,0xc,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,0x1,g,1,0,0)
end
function c75646127.matop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(3,tp,502)
	local g=Duel.SelectMatchingCard(tp,c75646127.matfilter,tp,0,0xc,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,0x40)
	end
end