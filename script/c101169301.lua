--空明-明日宿伞
function c101169301.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE),true)
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xf1),aux.NonTuner(Card.IsSetCard,0xf1),1)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c101169301.efilter)
	c:RegisterEffect(e1)
	--only 1 can exists
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	e2:SetCondition(c101169301.excon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,1)
	e4:SetCode(EFFECT_CANNOT_SUMMON)
	e4:SetTarget(c101169301.sumlimit)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e6)

	--atk
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetCode(EFFECT_SET_ATTACK_FINAL)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCondition(c101169301.adcon)
	e14:SetValue(c101169301.adval)
	c:RegisterEffect(e14)
	local e15=e14:Clone()
	e15:SetCode(EFFECT_SET_DEFENSE_FINAL)
	c:RegisterEffect(e15)
	--exodia killer
	local e33=Effect.CreateEffect(c)
	e33:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e33:SetCode(EVENT_TO_HAND)
	e33:SetRange(LOCATION_MZONE)
	e33:SetCondition(c101169301.condition)
	e33:SetOperation(c101169301.activate)
	c:RegisterEffect(e33)
end
function c101169301.check(g)
	local a1=false
	local a2=false
	local a3=false
	local a4=false
	local a5=false
	local tc=g:GetFirst()
	while tc do
		local code=tc:GetCode()
		if code==8124921 then a1=true
		elseif code==44519536 then a2=true
		elseif code==70903634 then a3=true
		elseif code==7902349 then a4=true
		elseif code==33396948 then a5=true
		end
		tc=g:GetNext()
	end
	return a1 and a2 and a3 and a4 and a5
end
function c101169301.condition(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	return c101169301.check(g1)
end
function c101169301.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Win(PLAYER_NONE,WIN_REASON_EXODIA)
end
function c101169301.sumlimit(e,c)
	return c:GetOriginalCode()==101169301
end
function c101169301.exfilter(c)
	return c:IsFaceup() and c:GetOriginalCode()==101169301
end
function c101169301.excon(e)
	return Duel.IsExistingMatchingCard(c101169301.exfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end

function c101169301.efilter(e,te)
	return te:GetOwner()~=e:GetOwner() and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SYNCHRO)==SUMMON_TYPE_SYNCHRO
end
function c101169301.adcon(e,c)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c101169301.filter(c)
	return c:IsFaceup() and c:GetCode()~=101169301
end
function c101169301.adval(e,c)
	local g=Duel.GetMatchingGroup(c101169301.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then 
		return 1000
	else
		local tg,val=g:GetMaxGroup(Card.GetAttack)
		return val+1000
	end
end