--萃·Snow
function c10969996.initial_effect(c)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetCondition(c10969996.condition2)
	e1:SetValue(c10969996.valcon)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e2:SetCondition(c10969996.condition2)
	e2:SetTarget(c10969996.distarget)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c10969996.condition2)
	e3:SetOperation(c10969996.disop)
	c:RegisterEffect(e3)
	--disable trap monster
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetCondition(c10969996.condition2)
	e4:SetTarget(c10969996.distarget)
	c:RegisterEffect(e4)	
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetCondition(c10969996.condition2)
	e5:SetTarget(c10969996.target)
	e5:SetValue(c10969996.indct)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(LOCATION_MZONE,0)
	e6:SetCondition(c10969996.condition3)
	e6:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x358))
	e6:SetValue(1)
	c:RegisterEffect(e6)
	--cannot be target
	local e7=e6:Clone()
	e7:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e7:SetValue(aux.tgoval)
	c:RegisterEffect(e7)
end
function c10969996.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,112)~=0 or Duel.GetFlagEffect(tp,113)~=0 
end
function c10969996.condition3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,111)~=0 or Duel.GetFlagEffect(tp,113)~=0 
end
function c10969996.valcon(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
function c10969996.distarget(e,c)
	return c~=e:GetHandler() and c:IsType(TYPE_TRAP)
end
function c10969996.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_TRAP) and re:GetHandler()~=e:GetHandler() then
		Duel.NegateEffect(ev)
	end
end
function c10969996.target(e,c)
	return c:IsSetCard(0x358) 
end
function c10969996.indct(e,re,r,rp)
	if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else return 0 end
end

