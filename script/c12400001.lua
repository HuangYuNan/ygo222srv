--帝国卫队 卫军步兵班
function c12400001.initial_effect(c)
    --damage
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DAMAGE)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetTarget(c12400001.damtg)
    e2:SetOperation(c12400001.damop)
    c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e3)
    --summon
    local e8=Effect.CreateEffect(c)
    e8:SetDescription(aux.Stringid(12400001,1))
    e8:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e8:SetType(EFFECT_TYPE_IGNITION)
    e8:SetRange(LOCATION_GRAVE+LOCATION_HAND)
    e8:SetCountLimit(1,12400001)
    e8:SetCondition(c12400001.spcon)
    e8:SetTarget(c12400001.sptg)
    e8:SetOperation(c12400001.spop)
    c:RegisterEffect(e8)
    --reg
    local ea=Effect.CreateEffect(c)
    ea:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    ea:SetCode(EVENT_TO_GRAVE)
    ea:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ea:SetOperation(c12400001.regop)
    c:RegisterEffect(ea)
    --search
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(12400001,1))
    e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e4:SetCode(EVENT_PHASE+PHASE_END)
    e4:SetRange(LOCATION_GRAVE)
    e4:SetCountLimit(1,12410001)
    e4:SetCondition(c12400001.thcon)
    e4:SetCost(c12400001.cost)
    e4:SetTarget(c12400001.thtg)
    e4:SetOperation(c12400001.thop)
    c:RegisterEffect(e4)
end
function c12400001.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(1-tp)
    Duel.SetTargetParam(500)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c12400001.damop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Damage(p,d,REASON_EFFECT)
end
function c12400001.hsfilter(c)
    return c:IsFaceup() and c:IsCode(12400002)
end
function c12400001.spcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(c12400001.hsfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c12400001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c12400001.splimit(e,c,sump,sumtype,sumpos,targetp,se)
    return not c:IsAttribute(ATTRIBUTE_WIND)
end
function c12400001.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c12400001.regop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    c:RegisterFlagEffect(12400001,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c12400001.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(12400001)>0
end
function c12400001.cfilter(c)
    return c:IsCode(12400002) and c:IsAbleToGraveAsCost()
end
function c12400001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c12400001.cfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c12400001.cfilter,tp,LOCATION_DECK,0,1,1,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c12400001.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c12400001.thop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end


