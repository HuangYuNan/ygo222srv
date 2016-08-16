--幽邃教主教 莉蒂亚·暴食
function c29201213.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x63e1),aux.NonTuner(Card.IsSetCard,0x63e1),1)
    c:EnableReviveLimit()
    --atk
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29201213,1))
    e10:SetCategory(CATEGORY_EQUIP)
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
    e10:SetCode(EVENT_SPSUMMON_SUCCESS)
    e10:SetCondition(c29201213.atkcon)
    e10:SetTarget(c29201213.damtg)
    e10:SetOperation(c29201213.atkop)
    c:RegisterEffect(e10)
    --atk limit
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTargetRange(0,LOCATION_MZONE)
    e2:SetValue(c29201213.atlimit)
    c:RegisterEffect(e2)
    --cannot be target
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetCode(EFFECT_CANNOT_SELECT_EFFECT_TARGET)
    e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
    e4:SetRange(LOCATION_MZONE)
    e4:SetTargetRange(0,0xff)
    e4:SetValue(c29201213.tgtg)
    c:RegisterEffect(e4)
    --negate
    local e3=Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
    e3:SetType(EFFECT_TYPE_QUICK_O)
    e3:SetCode(EVENT_CHAINING)
    e3:SetCountLimit(1)
    e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCondition(c29201213.discon)
    e3:SetCost(c29201213.discost)
    e3:SetTarget(c29201213.distg)
    e3:SetOperation(c29201213.disop)
    c:RegisterEffect(e3)
end
function c29201213.atkcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c29201213.sfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201213.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    local ct=Duel.GetMatchingGroupCount(c29201213.sfilter,tp,LOCATION_HAND,0,nil)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsType(TYPE_MONSTER) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
	    and Duel.IsExistingMatchingCard(c29201213.sfilter,tp,LOCATION_HAND,0,1,nil)
        and Duel.IsExistingTarget(Card.IsType,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,TYPE_MONSTER) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
    local g=Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,ct,nil,TYPE_MONSTER)
    Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c29201213.tgfilter(c,e)
    return c:IsFaceup() and c:IsRelateToEffect(e)
end
function c29201213.atkop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
    local sg=g:Filter(Card.IsRelateToEffect,nil,e)
    if Duel.GetLocationCount(tp,LOCATION_SZONE)<sg:GetCount() then return end
    local c=e:GetHandler()
    if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
    local tc=sg:GetFirst()
    while tc do
        Duel.Equip(tp,tc,c,false)
        tc:RegisterFlagEffect(29201213,RESET_EVENT+0x1fe0000,0,0)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
        e1:SetCode(EFFECT_EQUIP_LIMIT)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e1:SetValue(c29201213.eqlimit)
        tc:RegisterEffect(e1)
        tc=sg:GetNext()
    end
    --atk
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetValue(c29201213.atkval)
    c:RegisterEffect(e1)
end
function c29201213.atkval(e,c)
    local atk=0
    local g=c:GetEquipGroup()
    local tc=g:GetFirst()
    while tc do
        if tc:GetFlagEffect(29201213)~=0 and tc:GetAttack()>=0 then
            atk=atk+tc:GetAttack()
        end
        tc=g:GetNext()
    end
    return atk
end
function c29201213.eqlimit(e,c)
    return e:GetOwner()==c
end
function c29201213.atlimit(e,c)
    return c~=e:GetHandler()
end
function c29201213.tgtg(e,re,c)
    return c~=e:GetHandler() and c:IsControler(e:GetHandlerPlayer()) and c:IsLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c29201213.discon(e,tp,eg,ep,ev,re,r,rp)
    return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c29201213.discost(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return c:GetEquipGroup():IsExists(Card.IsAbleToGraveAsCost,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=c:GetEquipGroup():FilterSelect(tp,Card.IsAbleToGraveAsCost,1,1,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c29201213.distg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
    if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
        Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
    end
end
function c29201213.disop(e,tp,eg,ep,ev,re,r,rp)
    Duel.NegateActivation(ev)
    if re:GetHandler():IsRelateToEffect(re) then
        Duel.Destroy(eg,REASON_EFFECT)
    end
end
