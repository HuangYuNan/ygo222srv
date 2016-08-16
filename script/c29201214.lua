--幽邃教主教 莎缇拉·嫉妒
function c29201214.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x63e1),aux.NonTuner(Card.IsSetCard,0x63e1),1)
    c:EnableReviveLimit()
    --atk
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29201214,0))
    e10:SetCategory(CATEGORY_DESTROY)
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_DELAY)
    e10:SetCode(EVENT_SPSUMMON_SUCCESS)
    e10:SetCondition(c29201214.atkcon)
    e10:SetTarget(c29201214.damtg)
    e10:SetOperation(c29201214.atkop)
    c:RegisterEffect(e10)
    --
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_HAND_LIMIT)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTargetRange(0,1)
    e1:SetValue(3)
    c:RegisterEffect(e1)
    --
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCode(EFFECT_HAND_LIMIT)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e3:SetRange(LOCATION_MZONE)
    e3:SetTargetRange(1,0)
    e3:SetValue(9)
    c:RegisterEffect(e3)
    --draw
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29201214,1))
    e2:SetCategory(CATEGORY_DRAW)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetProperty(EFFECT_FLAG_DELAY)
    e2:SetCode(EVENT_TO_GRAVE)
    e2:SetCountLimit(1,29201214)
    e2:SetCondition(c29201214.drcon)
    e2:SetTarget(c29201214.drtg)
    e2:SetOperation(c29201214.drop)
    c:RegisterEffect(e2)
end
function c29201214.atkcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c29201214.sfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201214.filter(c)
    return c:IsDestructable() 
end
function c29201214.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    local ct=Duel.GetMatchingGroupCount(c29201214.sfilter,tp,LOCATION_HAND,0,nil)
    if chk==0 then return ct>0
        and Duel.IsExistingMatchingCard(c29201214.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
    local g=Duel.GetMatchingGroup(c29201214.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c29201214.atkop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local ct=Duel.GetMatchingGroupCount(c29201214.sfilter,tp,LOCATION_HAND,0,nil)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectMatchingCard(tp,c29201214.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,ct,nil)
    local val=Duel.Destroy(g,REASON_EFFECT)
    if c:IsFaceup() and c:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(val*400)
        e1:SetReset(RESET_EVENT+0x1ff0000)
        c:RegisterEffect(e1)
    end
end
function c29201214.drcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsPreviousLocation(LOCATION_MZONE) and c:GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c29201214.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c29201214.drop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
end
