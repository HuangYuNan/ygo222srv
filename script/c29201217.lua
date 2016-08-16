--幽邃教主教 布莱兹·忧郁
function c29201217.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x63e1),aux.NonTuner(Card.IsSetCard,0x63e1),1)
    c:EnableReviveLimit()
    --atk
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29201217,1))
    e10:SetCategory(CATEGORY_DISABLE)
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
    e10:SetCode(EVENT_SPSUMMON_SUCCESS)
    e10:SetCondition(c29201217.atkcon)
    e10:SetTarget(c29201217.damtg)
    e10:SetOperation(c29201217.atkop)
    c:RegisterEffect(e10)
    --disable
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_DISABLE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetTarget(c29201217.distg)
    c:RegisterEffect(e2)
    --cannot attack
    local e1=e2:Clone()
    e1:SetCode(EFFECT_CANNOT_ATTACK)
    c:RegisterEffect(e1)
    --cannnot activate
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e3:SetRange(LOCATION_MZONE)
    e3:SetTargetRange(1,1)
    e3:SetCode(EFFECT_CANNOT_ACTIVATE)
    e3:SetCondition(c29201217.actcon)
    e3:SetValue(c29201217.aclimit)
    c:RegisterEffect(e3)
    --cannot be target
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCondition(c29201217.tgcon)
    e4:SetValue(aux.imval1)
    c:RegisterEffect(e4)
    local e5=e4:Clone()
    e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e5:SetValue(1)
    c:RegisterEffect(e5)
end
function c29201217.atkcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c29201217.sfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201217.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    local ct=Duel.GetMatchingGroupCount(c29201217.sfilter,tp,LOCATION_HAND,0,nil)
    if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsFaceup() end
    if chk==0 then return Duel.IsExistingMatchingCard(c29201217.sfilter,tp,LOCATION_HAND,0,1,nil)
        and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
    local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,ct,nil)
    Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c29201217.tgfilter(c,e)
    return c:IsFaceup() and c:IsRelateToEffect(e)
end
function c29201217.atkop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
    local sg=g:Filter(Card.IsRelateToEffect,nil,e)
    local c=e:GetHandler()
    if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
    local tc=sg:GetFirst()
    while tc do
        if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
            c:SetCardTarget(tc)
        end
        tc=sg:GetNext()
    end
end
function c29201217.distg(e,c)
    return e:GetHandler():IsHasCardTarget(c)
end
function c29201217.actcon(e)
    return e:GetHandler():GetCardTargetCount()>0
end
function c29201217.aclimit(e,re,tp)
    local g=e:GetHandler():GetCardTarget()
    local cg={}
    local tc=g:GetFirst()
    while tc do
        table.insert(cg,tc:GetCode())
        tc=g:GetNext()
    end
    return re:GetHandler():IsCode(table.unpack(cg)) and not re:GetHandler():IsImmuneToEffect(e)
end
function c29201217.tgfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201217.tgcon(e)
    return Duel.IsExistingMatchingCard(c29201217.tgfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end

