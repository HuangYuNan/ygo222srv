--绽放于大地的旋律
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564044.initial_effect(c)
	senya.rxyz1(c,4,aux.FilterBoolFunction(Card.IsSetCard,0x770),true)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_BASE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c37564044.atkval)
	c:RegisterEffect(e2)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_SET_BASE_DEFENSE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(c37564044.atkval)
	c:RegisterEffect(e8)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(aux.tgoval)
	e4:SetCondition(senya.xmcon(5))
	c:RegisterEffect(e4)
	senya.atkdr(c,nil,nil,nil,nil,nil,true)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564765,5))
	e3:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_SPSUMMON)
	e3:SetCountLimit(1)
	e3:SetCondition(c37564044.discon)
	e3:SetCost(c37564044.cost)
	e3:SetTarget(c37564044.distg)
	e3:SetOperation(c37564044.disop)
	c:RegisterEffect(e3)
	senya.neg(c,1,nil,senya.rmovcost(2),c37564044.prcon)
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(37564044,8))
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c37564044.xmcon)
	e7:SetCost(senya.serlcost)
	e7:SetTarget(c37564044.spptg)
	e7:SetOperation(c37564044.sppop)
	c:RegisterEffect(e7)
end
function c37564044.nfilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsCode(37564050)
end
function c37564044.xmcon(e,tp,eg,ep,ev,re,r,rp)
		local g=e:GetHandler():GetOverlayGroup()
		local dct=g:FilterCount(Card.IsCode,nil,37564050)
		local xct=6-dct
		local fg=g:Filter(c37564044.nfilter,nil)
		return fg:GetClassCount(Card.GetAttribute)>=xct and g:IsExists(Card.IsCode,1,nil,37564013)
end
function c37564044.atkval(e,c)
	return c:GetOverlayCount()*500
end
function c37564044.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if not c:CheckRemoveOverlayCard(tp,1,REASON_COST) then return false end
	local ct=c:GetOverlayCount()/2
	if ct%1~=1 then ct=math.floor(ct)+1 end
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,ct,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,ct,ct,REASON_COST)
end
function c37564044.fffilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,true) and not c:IsCode(37564044)
end
function c37564044.spptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c37564044.fffilter,tp,LOCATION_EXTRA,LOCATION_EXTRA,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c37564044.sppop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetMatchingGroup(c37564044.fffilter,tp,LOCATION_EXTRA,LOCATION_EXTRA,nil,e,tp)
	if g:GetCount()>0 then
		for i=0,9 do
			Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(37564044,i))
		end
		Duel.ConfirmCards(tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,true,true,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
	end
end
function c37564044.filter(c,tp)
	return c:GetSummonPlayer()==tp
end
function c37564044.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and eg:IsExists(c37564044.filter,1,nil,1-tp)
end
function c37564044.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c37564044.filter,nil,1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c37564044.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()  
	local g=eg:Filter(c37564044.filter,nil,1-tp)
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) then
		Duel.NegateSummon(g)
		Duel.SendtoGrave(g,REASON_EFFECT)
		return
	end
	local tc=g:GetFirst()
	local gg=Group.CreateGroup()
	local dg=Group.CreateGroup()
	while tc do
		local og=tc:GetOverlayGroup()
		local mg=tc:GetMaterial()
		local g1=og:Filter(c37564044.filter1,nil,mg)
		local g2=og:Filter(c37564044.filter2,nil,mg)
		gg:Merge(g1)
		dg:Merge(g2)
		tc=g:GetNext()
	end
	Duel.NegateSummon(g)
	Duel.Overlay(c,gg)
	Duel.SendtoGrave(dg,REASON_RULE)
	Duel.Overlay(c,g)
end
function c37564044.filter1(c,g)
	if not g then return false end
	return g:IsContains(c)
end
function c37564044.filter2(c,g)
	if not g then return true end
	return not g:IsContains(c)
end
function c37564044.prcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,37564013)
end