--帝国卫队 武器班
function c12400016.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3390),aux.NonTuner(Card.IsSetCard,0x3390),1)
    c:EnableReviveLimit()
    --damage
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DAMAGE)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetCountLimit(1,12400016)
    e2:SetTarget(c12400016.damtg)
    e2:SetOperation(c12400016.damop)
    c:RegisterEffect(e2)
    --atk
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTargetRange(LOCATION_MZONE,0)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x3390))
    e1:SetValue(500)
    c:RegisterEffect(e1)
    --reg
    local ea=Effect.CreateEffect(c)
    ea:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    ea:SetCode(EVENT_TO_GRAVE)
    ea:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ea:SetCondition(c12400016.descon)
    ea:SetOperation(c12400016.regop)
    c:RegisterEffect(ea)
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(12400016,2))
    e4:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e4:SetCode(EVENT_PHASE+PHASE_END)
    e4:SetRange(LOCATION_GRAVE)
    e4:SetCondition(c12400016.thcon)
    e4:SetCost(c12400016.cost2)
    e4:SetTarget(c12400016.thtg)
    e4:SetOperation(c12400016.thop)
    c:RegisterEffect(e4)
end
function c12400016.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(1-tp)
    Duel.SetTargetParam(500)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c12400016.desfilter(c)
    return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c12400016.damop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Damage(p,d,REASON_EFFECT)
    local g=Duel.GetMatchingGroup(c12400016.desfilter,tp,0,LOCATION_ONFIELD,nil)
    if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(12400016,0)) then
        Duel.BreakEffect()
        local sg=g:Select(tp,1,1,nil)
        Duel.Destroy(sg,REASON_EFFECT)
    end
end
function c12400016.descon(e,tp,eg,ep,ev,re,r,rp)
    return re and re:GetHandler():IsSetCard(0x3390)
end
function c12400016.regop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    c:RegisterFlagEffect(12400016,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c12400016.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(12400016)>0
end
function c12400016.costfilter(c)
    return c:IsAbleToGraveAsCost()
end
function c12400016.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c12400016.costfilter,tp,LOCATION_ONFIELD,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c12400016.costfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c12400016.setfilter(c)
    return c:IsSetCard(0x3390) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c12400016.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c12400016.setfilter(chkc) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
        and Duel.IsExistingTarget(c12400016.setfilter,tp,LOCATION_GRAVE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
    local g=Duel.SelectTarget(tp,c12400016.setfilter,tp,LOCATION_GRAVE,0,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c12400016.thop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsSSetable() then
        Duel.SSet(tp,tc)
        Duel.ConfirmCards(1-tp,tc)
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CANNOT_TRIGGER)
        e1:SetReset(RESET_EVENT+0x17a0000+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(e:GetHandler())
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_CANNOT_USE_AS_COST)
        e2:SetReset(RESET_EVENT+0x17a0000+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e2)
    end
end


