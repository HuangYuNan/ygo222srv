--幻想物语 午夜零时的仙度瑞拉
function c80100003.initial_effect(c)
    c:EnableReviveLimit()
    --pendulum summon
    aux.EnablePendulumAttribute(c,false)
    --spsummon condition
    local ea=Effect.CreateEffect(c)
    ea:SetType(EFFECT_TYPE_SINGLE)
    ea:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    ea:SetCode(EFFECT_SPSUMMON_CONDITION)
    ea:SetValue(c80100003.splimit)
    c:RegisterEffect(ea)
    --spsummon limit
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e3:SetTargetRange(1,0)
    e3:SetTarget(c80100003.sumlimit)
    c:RegisterEffect(e3)
    --
    local eb=Effect.CreateEffect(c)
    eb:SetType(EFFECT_TYPE_SINGLE)
    eb:SetCode(EFFECT_UNRELEASABLE_SUM)
    eb:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    eb:SetRange(LOCATION_MZONE)
    eb:SetValue(1)
    c:RegisterEffect(eb)
    --atkup
    local e8=Effect.CreateEffect(c)
    e8:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
    e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e8:SetCode(EVENT_CHAINING)
    e8:SetRange(LOCATION_MZONE)
    e8:SetOperation(aux.chainreg)
    c:RegisterEffect(e8)
    --change effect
    local ec=Effect.CreateEffect(c)
    ec:SetDescription(aux.Stringid(80100003,1))
    ec:SetCategory(CATEGORY_ATKCHANGE)
    ec:SetType(EFFECT_TYPE_QUICK_O)
    ec:SetCode(EVENT_CHAINING)
    ec:SetRange(LOCATION_MZONE)
    ec:SetCountLimit(1,80100003)
    ec:SetCondition(c80100003.chcon)
    ec:SetOperation(c80100003.chop)
    c:RegisterEffect(ec)
    --to hand
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(80100003,2))
    e2:SetCategory(CATEGORY_TOHAND)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
    e2:SetCode(EVENT_RELEASE)
    e2:SetCountLimit(1,80100003)
    e2:SetCost(c80100003.rlcost)
    e2:SetTarget(c80100003.rltg)
    e2:SetOperation(c80100003.rlop)
    c:RegisterEffect(e2)
end
function c80100003.splimit(e,se,sp,st)
    return se:GetHandler():IsSetCard(0x3400) or bit.band(st,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c80100003.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
    return c:IsLocation(LOCATION_GRAVE+LOCATION_HAND)
end
function c80100003.chcon(e,tp,eg,ep,ev,re,r,rp)
    --[[local rc=re:GetHandler()
    return rc:GetType()==TYPE_QUICKPLAY and re:IsHasType(EFFECT_TYPE_ACTIVATE)]]
    local tpe=re:GetActiveType()
    return re:IsHasType(EFFECT_TYPE_ACTIVATE) and tpe==TYPE_QUICKPLAY+TYPE_SPELL and e:GetHandler():GetFlagEffect(1)>0
end
function c80100003.chop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) and c:IsFaceup() then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(800)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        c:RegisterEffect(e1)
        local e2=Effect.CreateEffect(e:GetHandler())
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
        e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e2:SetCountLimit(1)
        e2:SetValue(c80100003.valcon)
        e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        c:RegisterEffect(e2)
    end
end
function c80100003.valcon(e,re,r,rp)
    return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c80100003.rlcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckLPCost(tp,300) end
    Duel.PayLPCost(tp,300)
end
function c80100003.tgfilter(c)
    return c:IsSetCard(0x3400) and c:IsType(TYPE_SPELL) and c:IsAbleToGrave()
end
function c80100003.rltg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c80100003.tgfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c80100003.rlop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c80100003.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoGrave(g,REASON_EFFECT)
    end
end
