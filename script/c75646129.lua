--Stella-星序
function c75646129.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	--spsummon limit
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(0x400+EFFECT_FLAG_UNCOPYABLE)
	e4:SetType(0x1)
	e4:SetCode(30)
	e4:SetValue(aux.xyzlimit)
	c:RegisterEffect(e4)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(0x2)
	e1:SetCode(34)
	e1:SetRange(0x40)
	e1:SetCondition(c75646129.xyzcon)
	e1:SetOperation(c75646129.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--cannot activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(0x2)
	e2:SetProperty(0x800)
	e2:SetCode(6)
	e2:SetRange(0x4)
	e2:SetTargetRange(0,1)
	e2:SetValue(c75646129.aclimit)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(0x2+0x800)
	e3:SetCode(1107)
	e3:SetRange(0x4)
	e3:SetOperation(c75646129.aclimset)
	c:RegisterEffect(e3)
	--negate
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(0x1+CATEGORY_NEGATE+CATEGORY_DAMAGE)
	e5:SetType(0x100)
	e5:SetCode(1027)
	e5:SetCountLimit(1)
	e5:SetRange(0x4)
	e5:SetCondition(c75646129.discon)
	e5:SetTarget(c75646129.distg)
	e5:SetOperation(c75646129.disop)
	c:RegisterEffect(e5)
	--spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(0x200+CATEGORY_DAMAGE)
	e6:SetType(0x1+0x80)
	e6:SetCode(1014)
	e6:SetProperty(0x10+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetCondition(c75646129.spcon)
	e6:SetTarget(c75646129.sptg)
	e6:SetOperation(c75646129.spop)
	c:RegisterEffect(e6)
end
function c75646129.mfilter(c,xyzc)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x62c3) and c:GetRank()==4 and c:IsCanBeXyzMaterial(xyzc)
end
function c75646129.xyzfilter1(c,g,ct)
	return g:IsExists(c75646129.xyzfilter2,ct,c,c:GetRank())
end
function c75646129.xyzfilter2(c,rk)
	return c:GetRank()==4
end
function c75646129.xyzcon(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,0x4)
	local minc=3
	local maxc=3
	if min then
		minc=math.max(minc,min)
		maxc=max
	end
	local ct=math.max(minc-1,-ft)
	local mg=nil
	if og then
		mg=og:Filter(c75646129.mfilter,nil,c)
	else
		mg=Duel.GetMatchingGroup(c75646129.mfilter,tp,0x4,0,nil,c)
	end
	return maxc>=3 and mg:IsExists(c75646129.xyzfilter1,1,nil,mg,ct)
end
function c75646129.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	local g=nil
	if og and not min then
		g=og
	else
		local mg=nil
		if og then
			mg=og:Filter(c75646129.mfilter,nil,c)
		else
			mg=Duel.GetMatchingGroup(c75646129.mfilter,tp,0x4,0,nil,c)
		end
		local ft=Duel.GetLocationCount(tp,0x4)
		local minc=3
		local maxc=3
		if min then
			minc=math.max(minc,min)
			maxc=max
		end
		local ct=math.max(minc-1,-ft)
		Duel.Hint(3,tp,513)
		g=mg:FilterSelect(tp,c75646129.xyzfilter1,1,1,nil,mg,ct)
		Duel.Hint(3,tp,513)
		local g2=mg:FilterSelect(tp,c75646129.xyzfilter2,ct,maxc-1,g:GetFirst(),g:GetFirst():GetRank())
		g:Merge(g2)
	end
	local sg=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		sg:Merge(tc:GetOverlayGroup())
		tc=g:GetNext()
	end
	Duel.SendtoGrave(sg,0x400)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
function c75646129.aclimit(e,re,tp)
	if not re:IsHasType(0x10) or not re:IsActiveType(0x2) then return false end
	local c=re:GetHandler()
	return not c:IsLocation(0x8) or c:GetFlagEffect(75646129)>0
end
function c75646129.aclimset(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		tc:RegisterFlagEffect(75646129,0x1000+0x1fe0000+RESET_PHASE+0x200+RESET_OPPO_TURN,0,1)
		tc=eg:GetNext()
	end
end
function c75646129.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetChainInfo(ev,0x10)==LOCATION_HAND 
		and re:IsActiveType(0x1) and Duel.IsChainDisablable(ev) and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
end
function c75646129.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c75646129.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		if Duel.Damage(1-tp,500,0x40)~=0 then 
		Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0)
	end
	end   
end
function c75646129.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()>0 and e:GetHandler():GetPreviousLocation()==LOCATION_MZONE
end
function c75646129.spfilter(c,e,tp)
	return c:IsSetCard(0x62c3) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646129.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x10) and chkc:IsControler(tp) and c75646129.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>0
		and Duel.IsExistingTarget(c75646129.spfilter,tp,0x10,0,1,nil,e,tp) end
	Duel.Hint(3,tp,509)
	local g=Duel.SelectTarget(tp,c75646129.spfilter,tp,0x10,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,0x200,g,1,0,0)  
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,100)
end
function c75646129.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,0x5)~=0 then
		if Duel.Damage(1-tp,100,0x40)~=0 then 
		Duel.RaiseEvent(e:GetHandler(),0x10000000+75646112,e,0,tp,0,0)
		end
	end end
end