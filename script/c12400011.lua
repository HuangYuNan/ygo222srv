--帝国卫队 部队召集
function c12400011.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c12400011.spcost)
    e1:SetTarget(c12400011.target)
    e1:SetOperation(c12400011.activate)
    c:RegisterEffect(e1)
    --reg
    local ea=Effect.CreateEffect(c)
    ea:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    ea:SetCode(EVENT_TO_GRAVE)
    ea:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ea:SetCondition(c12400011.descon)
    ea:SetOperation(c12400011.regop)
    c:RegisterEffect(ea)
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(12400011,2))
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e4:SetCode(EVENT_PHASE+PHASE_END)
    e4:SetRange(LOCATION_GRAVE)
    e4:SetCountLimit(1,12400011)
    e4:SetCondition(c12400011.thcon)
    e4:SetCost(c12400011.cost2)
    e4:SetTarget(c12400011.thtg)
    e4:SetOperation(c12400011.thop)
    c:RegisterEffect(e4)
    Duel.AddCustomActivityCounter(12400011,ACTIVITY_SPSUMMON,c12400011.counterfilter)
end
function c12400011.counterfilter(c)
    return c:IsSetCard(0x3390)
end
function c12400011.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetCustomActivityCount(12400011,tp,ACTIVITY_SPSUMMON)==0 end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
    e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e1:SetReset(RESET_PHASE+PHASE_END)
    e1:SetTargetRange(1,0)
    e1:SetTarget(c12400011.splimit)
    e1:SetLabelObject(e)
    Duel.RegisterEffect(e1,tp)
end
function c12400011.splimit(e,c,sump,sumtype,sumpos,targetp,se)
    return not c:IsSetCard(0x3390)
end
function c12400011.filter(c,e,tp)
    return c:IsCode(12400001) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12400011.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c12400011.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c12400011.activate(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c12400011.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
    if g:GetCount()>0 then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c12400011.descon(e,tp,eg,ep,ev,re,r,rp)
    return re and re:GetHandler():IsSetCard(0x3390)
end
function c12400011.regop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    c:RegisterFlagEffect(12400011,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c12400011.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(12400011)>0
end
function c12400011.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
    Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c12400011.filter8(c,e,tp)
    return c:IsSetCard(0x3390) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12400011.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsRelateToEffect(e)
        and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c12400011.filter8,tp,LOCATION_DECK,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c12400011.thop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c12400011.filter8,tp,LOCATION_DECK,0,1,1,nil,e,tp)
    if g:GetCount()>0 then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    end
end

