--傲娇萌王夏娜
function c22163915.initial_effect(c)
	c:SetUniqueOnField(1,1,221639)
	--synchro summon
	aux.AddSynchroProcedure2(c,aux.FilterBoolFunction(Card.IsSetCard,0x370),aux.FilterBoolFunction(Card.IsCode,22163915))
	c:EnableReviveLimit()
	--no fuck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTarget(c22163915.targets)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c22163915.indval)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e1)
	
	local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(22163915,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE)
    e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e3:SetCode(EVENT_ATTACK_ANNOUNCE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCondition(c22163915.regcon)
	e3:SetTarget(c22163915.regtar)
    e3:SetOperation(c22163915.regop)
    c:RegisterEffect(e3)
end
function c22163915.targets(e,c)
	return c:IsSetCard(0x370)
end
function c22163915.indval(e,re,tp)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() and re:IsActiveType(TYPE_MONSTER)
end
function c22163915.regcon(e,tp,eg,ep,ev,re,r,rp)
    return (e:GetHandler()==Duel.GetAttacker() 
		and Duel.GetAttackTarget()~=nil) or e:GetHandler()==Duel.GetAttackTarget()
end
function c22163915.regtar(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetChainLimit(aux.FALSE)
end
function c22163915.regop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	local tc=c:GetBattleTarget()
    if tc:IsRelateToEffect(e) and tc:IsFaceup() then
        Duel.NegateRelatedChain(tc,RESET_TURN_SET)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e2:SetCode(EFFECT_DISABLE_EFFECT)
        e2:SetValue(RESET_TURN_SET)
        e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e2)
        local e3=Effect.CreateEffect(c)
        e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        e3:SetCode(EVENT_BATTLED)
        e3:SetOperation(c22163915.desop)
        e3:SetReset(RESET_PHASE+PHASE_DAMAGE)
        Duel.RegisterEffect(e3,tp)
    end
end
function c22163915.desop(e,tp,eg,ep,ev,re,r,rp)
    local tg=e:GetOwner():GetBattleTarget()
    if tg then
        Duel.Destroy(tg,REASON_EFFECT)
    end
end
