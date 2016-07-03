--傲娇萌王·蕾咪
function c22163931.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure2(c,aux.FilterBoolFunction(c22163931.sfliter),aux.FilterBoolFunction(Card.IsCode,19990010))
	c:EnableReviveLimit()
	--immune
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetOperation(c22163931.atkop)
	c:RegisterEffect(e4)
end
function c22163931.sfliter(c)
	return c:IsSetCard(0x197) or c:IsSetCard(0x370)
end
function c22163931.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c22163931.efilter)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	e:GetHandler():RegisterEffect(e1)
end
function c22163931.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end