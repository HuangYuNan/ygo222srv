--镜世录 备用伞
function c29201018.initial_effect(c)
    --search
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29201018,0))
    e1:SetCategory(CATEGORY_ATKCHANGE)
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetHintTiming(TIMING_DAMAGE_STEP)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(c29201018.condition)
    e1:SetCost(c29201018.cost)
    e1:SetTarget(c29201018.target)
    e1:SetOperation(c29201018.operation)
    c:RegisterEffect(e1)
    --special summon
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29201018,1))
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e10:SetCode(EVENT_TO_GRAVE)
    e10:SetCondition(c29201018.condtion5)
    e10:SetTarget(c29201018.target5)
    e10:SetOperation(c29201018.operation5)
    c:RegisterEffect(e10)
    --splimit
    local e12=Effect.CreateEffect(c)
    e12:SetType(EFFECT_TYPE_FIELD)
    e12:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e12:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e12:SetRange(LOCATION_SZONE)
    e12:SetTargetRange(1,0)
    e12:SetTarget(c29201018.splimit)
    c:RegisterEffect(e12)
    local e13=Effect.CreateEffect(c)
    e13:SetType(EFFECT_TYPE_FIELD)
    e13:SetCode(EFFECT_CANNOT_SUMMON)
    e13:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e13:SetRange(LOCATION_SZONE)
    e13:SetTargetRange(1,0)
    e13:SetTarget(c29201018.splimit)
    c:RegisterEffect(e13)
    --spsummon
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29201018,2))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCountLimit(1,29201018)
    e2:SetCost(c29201018.spcost)
    e2:SetTarget(c29201018.sptg)
    e2:SetOperation(c29201018.spop)
    c:RegisterEffect(e2)
end
function c29201018.cfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e0) and c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS and not c:IsCode(29201018) and c:IsAbleToGraveAsCost()
end
function c29201018.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29201018.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c29201018.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c29201018.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29201018.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not c:IsRelateToEffect(e) then return end
    if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
        and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
        Duel.SendtoGrave(c,REASON_RULE)
    end
end
function c29201018.splimit(e,c)
    return not c:IsSetCard(0x63e0)
end
function c29201018.condition(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local ph=Duel.GetCurrentPhase()
    return ph==PHASE_DAMAGE and (c==Duel.GetAttacker() or c==Duel.GetAttackTarget())
        and not Duel.IsDamageCalculated()
end
function c29201018.filter3(c)
    return c:IsSetCard(0x63e0) and c:GetBaseAttack()>0 and c:IsAbleToGrave()
end
function c29201018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():GetFlagEffect(29201018)==0 end
    e:GetHandler():RegisterFlagEffect(29201018,RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c29201018.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29201018.filter3,tp,LOCATION_HAND,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c29201018.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
    local g=Duel.SelectMatchingCard(tp,c29201018.filter3,tp,LOCATION_HAND,0,1,1,nil)
    if c:IsFaceup() and g:GetCount()>0 then
        Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(g:GetFirst():GetBaseAttack())
        e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
        c:RegisterEffect(e1)
    end
end
function c29201018.condtion5(e,tp,eg,ep,ev,re,r,rp)
    return bit.band(r,REASON_EFFECT)~=0 and re:GetOwner():IsSetCard(0x63e0) 
        and e:GetHandler():IsPreviousLocation(LOCATION_MZONE+LOCATION_HAND)
end
function c29201018.target5(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c29201018.operation5(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then
        Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
        local e1=Effect.CreateEffect(c)
        e1:SetCode(EFFECT_CHANGE_TYPE)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e1:SetReset(RESET_EVENT+0x1fc0000)
        e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
        c:RegisterEffect(e1)
        Duel.RaiseEvent(c,EVENT_CUSTOM+29201000,e,0,tp,0,0)
    end
end
