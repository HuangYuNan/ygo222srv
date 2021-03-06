--インダストメカ・エンダード・ドラゴン
function c9990409.initial_effect(c)
	--Xyz
	aux.AddXyzProcedure(c,nil,8,3)
	c:EnableReviveLimit()
	--Rule Effect
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.FALSE)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if e:GetHandler():GetSummonType()~=SUMMON_TYPE_XYZ then return end
		Duel.SetChainLimitTillChainEnd(function(e,lp,tp) return lp==tp end)
	end)
	c:RegisterEffect(e3)
	--Fuck All
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(0,0x17c0)
	e4:SetCountLimit(1)
	e4:SetCost(c9990409.cost)
	e4:SetTarget(c9990409.target)
	e4:SetOperation(c9990409.operation)
	c:RegisterEffect(e4)
end
function c9990409.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c9990409.fuckfilter(c,atk)
	return c:IsDestructable() and c:IsAbleToDeck() and (c:IsFacedown() or c:IsFaceup() and c:GetAttack()<atk and c:IsLocation(LOCATION_MZONE))
end
function c9990409.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local atk=e:GetHandler():GetAttack()
	if chk==0 then return Duel.IsExistingMatchingCard(c9990409.fuckfilter,tp,0,LOCATION_ONFIELD,1,nil,atk) end
	local g=Duel.GetMatchingGroup(c9990409.fuckfilter,tp,0,LOCATION_ONFIELD,nil,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end
function c9990409.operation(e,tp,eg,ep,ev,re,r,rp)
	local atk=e:GetHandler():GetAttack()
	local g=Duel.GetMatchingGroup(c9990409.fuckfilter,tp,0,LOCATION_ONFIELD,nil,atk)
	if g:GetCount()==0 then return end
	local effect_set={}
	g:ForEach(function(tc)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(LOCATION_DECKSHF)
		tc:RegisterEffect(e1,true)
		table.insert(effect_set,e1)
	end)
	Duel.Destroy(g,REASON_EFFECT)
	for i,e in pairs(effect_set) do  
		e:Reset()
	end
end