--幽邃教主教 多洛莉丝·贪婪
function c29201212.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x63e1),aux.NonTuner(Card.IsSetCard,0x63e1),1)
    c:EnableReviveLimit()
    --indes
    local e2=Effect.CreateEffect(c)
    e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTargetRange(LOCATION_MZONE,0)
    e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x63e1))
    e2:SetValue(1)
    c:RegisterEffect(e2)
    --cannot be target
    local e3=e2:Clone()
    e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e3:SetValue(aux.tgoval)
    c:RegisterEffect(e3)
    --to hand
    local e5=Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(29201212,0))
    e5:SetCategory(CATEGORY_DRAW)
    e5:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
    e5:SetRange(LOCATION_MZONE)
    e5:SetCode(EVENT_PHASE+PHASE_END)
    e5:SetCountLimit(1)
    e5:SetCondition(c29201212.thcon)
    e5:SetTarget(c29201212.thtg)
    e5:SetOperation(c29201212.thop)
    c:RegisterEffect(e5)
    --atk
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29201212,1))
    e10:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_DELAY)
    e10:SetCode(EVENT_SPSUMMON_SUCCESS)
    e10:SetCondition(c29201212.atkcon)
    e10:SetTarget(c29201212.damtg)
    e10:SetOperation(c29201212.atkop)
    c:RegisterEffect(e10)
end
function c29201212.atkcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c29201212.sfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201212.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local ct=Duel.GetMatchingGroupCount(c29201212.sfilter,tp,LOCATION_HAND,0,nil)
    if chk==0 then return Duel.IsExistingMatchingCard(c29201212.sfilter,tp,LOCATION_HAND,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_DECK)
end
function c29201212.atkop(e,tp,eg,ep,ev,re,r,rp)
    local ct1=Duel.GetMatchingGroupCount(c29201212.sfilter,tp,LOCATION_HAND,0,nil)
    --local ct1=Duel.GetMatchingGroupCount(c29201212.sfilter,tp,LOCATION_MZONE,0,nil)
    local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
    if ct1>ct2 then ct1=ct2 end
    if ct1==0 then return end
    local t={}
    for i=1,ct1 do t[i]=i end
    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(29201212,2))
    local ac=Duel.AnnounceNumber(tp,table.unpack(t))
    local g=Duel.GetDecktopGroup(1-tp,ac)
    Duel.DisableShuffleCheck()
    local val=Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
    local c=e:GetHandler()
    if c:IsFaceup() and c:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(val*400)
        e1:SetReset(RESET_EVENT+0x1ff0000)
        c:RegisterEffect(e1)
    end
end
function c29201212.thcon(e,tp,eg,ep,ev,re,r,rp)
    local ct1=Duel.GetFieldGroupCount(tp,LOCATION_HAND+LOCATION_ONFIELD,0)
    local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND+LOCATION_ONFIELD)
    return ct2>ct1 and Duel.GetTurnPlayer()==tp
end
function c29201212.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local ct1=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND+LOCATION_ONFIELD)-Duel.GetFieldGroupCount(tp,LOCATION_HAND+LOCATION_ONFIELD,0)
    if chk==0 then return ct1>0 and Duel.IsPlayerCanDraw(tp,ct1) end
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct1)
end
function c29201212.thop(e,tp,eg,ep,ev,re,r,rp)
    local ct1=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND+LOCATION_ONFIELD)-Duel.GetFieldGroupCount(tp,LOCATION_HAND+LOCATION_ONFIELD,0)
    if ct1>0 then
        Duel.Draw(tp,ct1,REASON_EFFECT)
    end
end
