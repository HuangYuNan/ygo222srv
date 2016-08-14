--帝国卫队 老兵班
function c12400014.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3390),aux.NonTuner(Card.IsSetCard,0x3390),1)
    c:EnableReviveLimit()
    --damage
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DAMAGE)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetCountLimit(1,12400014)
    e2:SetTarget(c12400014.damtg)
    e2:SetOperation(c12400014.damop)
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
    ea:SetCondition(c12400014.descon)
    ea:SetOperation(c12400014.regop)
    c:RegisterEffect(ea)
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(12400014,2))
    e4:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e4:SetCode(EVENT_PHASE+PHASE_END)
    e4:SetRange(LOCATION_GRAVE)
    e4:SetCondition(c12400014.thcon)
    e4:SetCost(c12400014.cost2)
    e4:SetTarget(c12400014.thtg)
    e4:SetOperation(c12400014.thop)
    c:RegisterEffect(e4)
end
function c12400014.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(1-tp)
    Duel.SetTargetParam(500)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c12400014.damop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Damage(p,d,REASON_EFFECT)
    local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
    if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(12400014,0)) then
        Duel.BreakEffect()
        local sg=g:Select(tp,1,1,nil)
        Duel.Destroy(sg,REASON_EFFECT)
    end
end
function c12400014.descon(e,tp,eg,ep,ev,re,r,rp)
    return re and re:GetHandler():IsSetCard(0x3390)
end
function c12400014.regop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    c:RegisterFlagEffect(12400014,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c12400014.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(12400014)>0
end
function c12400014.costfilter(c)
    return c:IsAbleToGraveAsCost()
end
function c12400014.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c12400014.costfilter,tp,LOCATION_ONFIELD,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c12400014.costfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c12400014.spfilter(c,e,tp)
    return c:IsSetCard(0x3390) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12400014.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c12400014.spfilter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c12400014.spfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,c12400014.spfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c12400014.thop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc and tc:IsRelateToEffect(e) then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    end
end


