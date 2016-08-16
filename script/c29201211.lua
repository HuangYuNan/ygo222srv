--幽邃教主教 婕咪·色欲
function c29201211.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x63e1),aux.NonTuner(Card.IsSetCard,0x63e1),1)
    c:EnableReviveLimit()
    --synchro summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29201211,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(c29201211.sccon)
    e1:SetTarget(c29201211.sctg)
    e1:SetOperation(c29201211.scop)
    c:RegisterEffect(e1)
    --remove
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
    e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCondition(c29201211.pccon)
    e2:SetTarget(c29201211.rmtarget)
    e2:SetTargetRange(0,LOCATION_HAND+LOCATION_DECK)
    e2:SetValue(LOCATION_REMOVED)
    c:RegisterEffect(e2)
    --atk
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29201211,0))
    e10:SetCategory(CATEGORY_DAMAGE+CATEGORY_ATKCHANGE)
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_DELAY)
    e10:SetCode(EVENT_SPSUMMON_SUCCESS)
    e10:SetCondition(c29201211.atkcon)
    e10:SetTarget(c29201211.damtg)
    e10:SetOperation(c29201211.atkop)
    c:RegisterEffect(e10)
end
function c29201211.sfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201211.pccon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(c29201211.sfilter,tp,LOCATION_HAND,0,1,nil)
end
function c29201211.rmtarget(e,c)
    return c:IsType(TYPE_MONSTER)
end
function c29201211.sccon(e,tp,eg,ep,ev,re,r,rp)
    local ph=Duel.GetCurrentPhase()
    return not e:GetHandler():IsStatus(STATUS_CHAINING) and Duel.GetTurnPlayer()~=tp
        and (ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2)
end
function c29201211.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler()) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29201211.scop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:GetControler()~=tp or not c:IsRelateToEffect(e) then return end
    local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,c)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local sg=g:Select(tp,1,1,nil)
        Duel.SynchroSummon(tp,sg:GetFirst(),c)
    end
end
function c29201211.atkcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c29201211.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local ct=Duel.GetMatchingGroupCount(c29201211.sfilter,tp,LOCATION_HAND,0,nil)
    if chk==0 then return Duel.IsExistingMatchingCard(c29201211.sfilter,tp,LOCATION_HAND,0,1,nil) end
    Duel.SetTargetPlayer(1-tp)
    Duel.SetTargetParam(ct*300)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*300)
end
function c29201211.atkop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    local val=Duel.Damage(p,d,REASON_EFFECT)
    local c=e:GetHandler()
    if c:IsFaceup() and c:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(val)
        e1:SetReset(RESET_EVENT+0x1ff0000)
        c:RegisterEffect(e1)
    end
end


