--帝国卫队 防守反击
function c12400012.initial_effect(c)
    --Activate(summon)
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_SUMMON)
    e1:SetCondition(c12400012.condition1)
    e1:SetCost(c12400012.cost1)
    e1:SetTarget(c12400012.target1)
    e1:SetOperation(c12400012.activate1)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EVENT_FLIP_SUMMON)
    c:RegisterEffect(e2)
    local e3=e1:Clone()
    e3:SetCode(EVENT_SPSUMMON)
    c:RegisterEffect(e3)
    --reg
    local ea=Effect.CreateEffect(c)
    ea:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    ea:SetCode(EVENT_TO_GRAVE)
    ea:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ea:SetCondition(c12400012.descon)
    ea:SetOperation(c12400012.regop)
    c:RegisterEffect(ea)
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(12400012,2))
    e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e4:SetCode(EVENT_PHASE+PHASE_END)
    e4:SetRange(LOCATION_GRAVE)
    e4:SetCondition(c12400012.thcon)
    e4:SetCost(c12400012.cost2)
    e4:SetTarget(c12400012.thtg)
    e4:SetOperation(c12400012.thop)
    c:RegisterEffect(e4)
end
function c12400012.condition1(e,tp,eg,ep,ev,re,r,rp)
    return tp~=ep and Duel.GetCurrentChain()==0
end
function c12400012.cfilter(c)
    return c:IsSetCard(0x3390) and c:IsAbleToGraveAsCost()
end
function c12400012.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
    local loc=LOCATION_MZONE
    if chk==0 then return Duel.IsExistingMatchingCard(c12400012.cfilter,tp,loc,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c12400012.cfilter,tp,loc,0,1,1,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c12400012.filter1(c)
    return c:IsAbleToRemove()
end
function c12400012.target1(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local g=eg:Filter(c12400012.filter1,nil)
    Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c12400012.activate1(e,tp,eg,ep,ev,re,r,rp)
    local g=eg:Filter(c12400012.filter1,nil)
    Duel.NegateSummon(eg)
    --Duel.Destroy(eg,REASON_EFFECT)
    Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
end
function c12400012.descon(e,tp,eg,ep,ev,re,r,rp)
    return re and re:GetHandler():IsSetCard(0x3390)
end
function c12400012.regop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    c:RegisterFlagEffect(12400012,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c12400012.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(12400012)>0
end
function c12400012.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
    Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c12400012.filter(c,e,tp)
    return c:IsSetCard(0x3390) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12400012.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c12400012.filter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c12400012.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,c12400012.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c12400012.thop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    end
end

