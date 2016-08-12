--小鸟的魔物·琪比摩斯
function c1100800.initial_effect(c)
	c:EnableUnsummonable()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c1100800.splimit)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetCountLimit(1)
	e2:SetValue(c1100800.valcon1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(1)
	e3:SetValue(c1100800.valcon2)
	c:RegisterEffect(e3)
	--untargetable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c1100800.atlimit)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c1100800.tglimit)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--atkup
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(c1100800.atkval)
	c:RegisterEffect(e5) 
end
function c1100800.splimit(e,se,sp,st)
	local sc=se:GetHandler()
	return sc:IsType(TYPE_SYNCHRO) and sc:IsSetCard(0x1243)
end
function c1100800.valcon1(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c1100800.valcon2(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
function c1100800.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x1243) and c~=e:GetHandler()
end
function c1100800.tglimit(e,c)
	return c:IsSetCard(0x1243) and c~=e:GetHandler()
end
function c1100800.atkval(e,c)
	local lps=Duel.GetLP(c:GetControler())
	local lpo=Duel.GetLP(1-c:GetControler())
	if lps>=lpo then return 0
	else return lpo-lps end
end