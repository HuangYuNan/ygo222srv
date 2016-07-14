--Sawawa-Blinding Destruction
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564231.initial_effect(c)
	senya.sww(c,2,true,false,false)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c37564231.effcon)
	e2:SetTarget(c37564231.filter)
	e2:SetValue(aux.TRUE)
	c:RegisterEffect(e2)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564231,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
	e2:SetCountLimit(1)
	e2:SetCost(senya.swwrmcost(1))
	e2:SetOperation(c37564231.atkop)
	c:RegisterEffect(e2)
end
function c37564231.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(1000)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENCE)
	Duel.RegisterEffect(e2,tp)
end
function c37564231.effcon(e)
	local tp=e:GetHandler():GetControler()
	return senya.swwblex(e,tp) and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_GRAVE,0,1,nil,0x773)
end
function c37564231.filter(e,c)
	return c:GetAttack()>=3000 and c:IsFaceup() and not c:IsImmuneToEffect(e) and c:IsDestructable()
end