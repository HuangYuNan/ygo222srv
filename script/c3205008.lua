--���
function c3205008.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,3205008+EFFECT_COUNT_CODE_DUEL)
	c:RegisterEffect(e1)
	--cannot Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c3205008.desrepcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetCondition(c3205008.desrepcon)
	e5:SetValue(aux.tgoval)
	c:RegisterEffect(e5)
	--cannot disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_DISABLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_SZONE,0)
	e4:SetValue(c3205008.effectfilter)
	c:RegisterEffect(e4)
	--inactivatable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_INACTIVATE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetValue(c3205008.effectfilter)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CANNOT_DISEFFECT)
	e6:SetRange(LOCATION_SZONE)
	e6:SetValue(c3205008.effectfilter)
	c:RegisterEffect(e6)
end
function c3205008.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x340) and c:IsType(TYPE_MONSTER)
end
function c3205008.desrepcon(e)
	return Duel.IsExistingMatchingCard(c3205008.filter1,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,1,nil)
end
function c3205008.effectfilter(e,ct)
	local p=e:GetHandlerPlayer()
	local te,tp,loc=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TRIGGERING_LOCATION)
	local tc=te:GetHandler()
	return p==tp and bit.band(loc,LOCATION_ONFIELD)~=0 and tc:IsSetCard(0x340) and tc:IsType(TYPE_MONSTER) and tc~=e:GetHandler()
end