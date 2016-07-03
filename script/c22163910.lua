--傲娇炎发灼眼夏娜
function c22163910.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.FilterBoolFunction(Card.IsSetCard,0x370),1)
	c:EnableReviveLimit()
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	
	local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(22163910,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_ATTACK_ANNOUNCE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCondition(c22163910.regcon)
	e2:SetTarget(c22163910.regtar)
    e2:SetOperation(c22163910.regop)
    c:RegisterEffect(e2)
	
	
end
function c22163910.regcon(e,tp,eg,ep,ev,re,r,rp)
    return (e:GetHandler()==Duel.GetAttacker() 
		and Duel.GetAttackTarget()~=nil) or e:GetHandler()==Duel.GetAttackTarget()
end
function c22163910.regtar(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetChainLimit(aux.FALSE)
end
function c22163910.regop(e,tp,eg,ep,ev,re,r,rp)
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
        e3:SetOperation(c22163910.desop)
        e3:SetReset(RESET_PHASE+PHASE_DAMAGE)
        Duel.RegisterEffect(e3,tp)
    end
end
function c22163910.desop(e,tp,eg,ep,ev,re,r,rp)
    local tg=e:GetOwner():GetBattleTarget()
    if tg then
        Duel.Destroy(tg,REASON_EFFECT)
    end
end
