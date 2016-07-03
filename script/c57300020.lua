--终焉的物语·物凄
require "expansions/script/c37564765"
function c57300020.initial_effect(c)
	senya.rxyz1(c,nil)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c57300020.effcon)
	e2:SetTarget(c57300020.filter)
	e2:SetValue(aux.TRUE)
	c:RegisterEffect(e2)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57300020,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
	e1:SetCountLimit(1)
	e1:SetCost(senya.rmovcost(1))
	e1:SetOperation(c57300020.atkop)
	c:RegisterEffect(e1)
end
function c57300020.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(-3)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_RANK)
	Duel.RegisterEffect(e2,tp)
end
function c57300020.effcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c57300020.filter(e,c)
	local val=e:GetHandler():GetOverlayCount()
	return c:IsFaceup() and not c:IsImmuneToEffect(e) and c:IsDestructable() and (c:IsLevelBelow(val) or c:IsRankBelow(val))
end