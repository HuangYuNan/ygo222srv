--幾夜竜
function c9990313.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,function(c) return c:IsRace(RACE_WYRM) and c:IsType(TYPE_PENDULUM) end,aux.NonTuner(Card.IsAttribute,ATTRIBUTE_DARK),2)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e1)
	local succ=Effect.CreateEffect(c)
	succ:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	succ:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	succ:SetCode(EVENT_SPSUMMON_SUCCESS)
	succ:SetCondition(c9990313.condition)
	succ:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		e:GetHandler():RegisterFlagEffect(9990313,0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9990313,0))
	end)
	c:RegisterEffect(succ)
	--Immunity
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetValue(function(e,te)
		if te:IsActiveType(TYPE_SPELL+TYPE_TRAP) then
			return true
		else
			local rc=te:GetHandler()
			return rc:IsLevelBelow(9) or rc:IsRankBelow(9)
		end
	end)
	c:RegisterEffect(e2)
	--Remove
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetCountLimit(1)
	e3:SetCondition(c9990313.condition)
	e3:SetTarget(c9990313.target)
	e3:SetOperation(c9990313.operation)
	c:RegisterEffect(e3)
end
function c9990313.rmfilter(c)
	return c:IsAbleToRemove() and (not c:IsLocation(LOCATION_MZONE)
		or c:IsFacedown() or c:IsLevelBelow(9) or c:IsRankBelow(9))
end
function c9990313.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c9990313.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9990313.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,LOCATION_ONFIELD,LOCATION_ONFIELD)
end
function c9990313.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=Duel.SelectMatchingCard(tp,c9990313.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if sg:GetCount()==0 then return end
	Duel.HintSelection(sg)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end