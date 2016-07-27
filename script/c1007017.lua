--家族的继承者·苍崎青子
function c1007017.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x245),7,2)
	--spsummon limit
	local e111=Effect.CreateEffect(c)
	e111:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e111:SetType(EFFECT_TYPE_SINGLE)
	e111:SetCode(EFFECT_SPSUMMON_CONDITION)
	e111:SetValue(c1007017.splimit)
	c:RegisterEffect(e111)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e1)
	--special xyz_summon 
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100053,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c1007017.spcon)
	e1:SetOperation(c1007017.spop)
	c:RegisterEffect(e1)
	--2to1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1101137,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c1007017.con)
	e2:SetCost(c1007017.alicost)
	c:RegisterEffect(e2)
	--immune
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_IMMUNE_EFFECT)
	e6:SetCondition(c1007017.dacon)
	e6:SetValue(c1007017.efilter)
	c:RegisterEffect(e6)
end
function c1007017.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ
end
function c1007017.dacon(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer() and e:GetHandler():GetOverlayCount()>0
end
function c1007017.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c1007017.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c1007017.filter1,1,nil)
end
function c1007017.ovfilter1(c,tp)
	return  c:IsSetCard(0x245) and  Duel.IsExistingMatchingCard(c1007017.ovfilter2,tp,LOCATION_MZONE,0,1,c,tp) and c:GetControler(tp)
end
function c1007017.ovfilter2(c,tp)
	return c:IsSetCard(0x245) and c:GetLevel()==7  and c:GetControler(tp)
end
function c1007017.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return  Duel.IsExistingMatchingCard(c1007017.ovfilter1,tp,LOCATION_MZONE,0,1,nil,tp) 
end
function c1007017.spop(e,tp,eg,ep,ev,re,r,rp,c)  
	local g1=Duel.SelectMatchingCard(tp,c1007017.ovfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local g2=Duel.SelectMatchingCard(tp,c1007017.ovfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst(),tp)
	if g1:GetCount()==1  and g2:GetCount()==1 then
	local og=g1:GetFirst():GetOverlayGroup() 
		if og:GetCount()>0  then
			Duel.SendtoGrave(og,REASON_RULE)
		end
	Duel.Overlay(c,Group.FromCards(g1:GetFirst(),g2:GetFirst()))
	end
end
function c1007017.filter1(c)
	return c:IsSetCard(0x245)
end
function c1007017.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c1007017.filter1,1,nil)
end
function c1007017.alicost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e1:SetTargetRange(0,0xff)
	e1:SetValue(LOCATION_REMOVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c1007017.rmtg)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetOperation(c1007017.disop)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c1007017.rmtg(e,c)
	return c:GetOwner()~=e:GetHandlerPlayer()
end
function c1007017.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_TRAP+TYPE_SPELL) then
		Duel.NegateEffect(ev)
	end
end