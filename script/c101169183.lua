--空明-樱守姬绿野
function c101169183.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(c101169183.atkfilter)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101169183,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCondition(c101169183.condition)
	e2:SetTarget(c101169183.destg)
	e2:SetOperation(c101169183.desop)
	c:RegisterEffect(e2)
end
function c101169183.atkfilter(e,c)
	return c:GetAttack()<e:GetHandler():GetAttack()
end
function c101169183.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsFaceup() and Duel.GetAttackTarget():IsFaceup() and Duel.GetAttacker():GetAttack()>Duel.GetAttackTarget():GetAttack()
end
function c101169183.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c101169183.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		Duel.BreakEffect()
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end