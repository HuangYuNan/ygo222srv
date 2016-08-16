--神灭魔战姬 艾尔特·索菲亚
function c04103111.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure2(c,aux.FilterBoolFunction(Card.IsCode,3099),aux.FilterBoolFunction(Card.IsCode,3110))
    --cannot special summon
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetValue(aux.synlimit)
    c:RegisterEffect(e1)  
    --activate limit
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
    e2:SetCode(EVENT_CHAINING)
    e2:SetRange(LOCATION_MZONE)
    e2:SetOperation(c04103111.aclimit1)
    c:RegisterEffect(e2)
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
    e3:SetCode(EVENT_CHAIN_NEGATED)
    e3:SetRange(LOCATION_MZONE)
    e3:SetOperation(c04103111.aclimit2)
    c:RegisterEffect(e3)
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetCode(EFFECT_CANNOT_ACTIVATE)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e4:SetRange(LOCATION_MZONE)
    e4:SetTargetRange(0,1)
    e4:SetCondition(c04103111.accon)
    e4:SetValue(1)
    c:RegisterEffect(e4)
    --multi attack
    local e5=Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(04103111,0))
    e5:SetType(EFFECT_TYPE_IGNITION)
    e5:SetRange(LOCATION_MZONE)
    e5:SetCountLimit(1)
    e5:SetCondition(c04103111.macon)
    e5:SetCost(c04103111.macost)
    e5:SetOperation(c04103111.maop)
    c:RegisterEffect(e5)
    --spsummon
    local e6=Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e6:SetCode(EVENT_LEAVE_FIELD)
    e6:SetOperation(c04103111.spop0)
    c:RegisterEffect(e6)
    --spsummon
    local e7=Effect.CreateEffect(c)
    e7:SetDescription(aux.Stringid(04103111,1))
    e7:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
    e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e7:SetCode(EVENT_PHASE+PHASE_END)
    e7:SetCountLimit(1)
    e7:SetRange(LOCATION_EXTRA+LOCATION_REMOVED+LOCATION_GRAVE)
    e7:SetTarget(c04103111.sptg)
    e7:SetOperation(c04103111.spop)
    c:RegisterEffect(e7)
end

function c04103111.aclimit1(e,tp,eg,ep,ev,re,r,rp)
    if ep==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
    e:GetHandler():RegisterFlagEffect(04103111,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,0,1)
end

function c04103111.aclimit2(e,tp,eg,ep,ev,re,r,rp)
    if ep~=tp then 
      e:GetHandler():ResetFlagEffect(04103111)
    end
end

function c04103111.accon(e)
    return e:GetHandler():GetFlagEffect(04103111)~=0
end

function c04103111.macon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()~=1 and Duel.GetCurrentPhase()==PHASE_MAIN1
        and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_CANNOT_BP)
end

function c04103111.macost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckReleaseGroup(tp,c04103111.mafilter,1,e:GetHandler()) end
    local g=Duel.SelectReleaseGroup(tp,c04103111.mafilter,1,2,e:GetHandler())
    local ct=Duel.Release(g,REASON_COST)
    e:SetLabel(ct)
end

function c04103111.mafilter(c)
    return c:IsRace(RACE_WARRIOR) and c:IsAttribute(ATTRIBUTE_LIGHT)
end

function c04103111.maop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_EXTRA_ATTACK)
        e1:SetValue(e:GetLabel())
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        c:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_IMMUNE_EFFECT)
        e2:SetValue(c04103111.efilter)
        e2:SetOwnerPlayer(tp)
        e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        c:RegisterEffect(e2)
    end
end

function c04103111.efilter(e,re)
    return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end

function c04103111.spop0(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if bit.band(c:GetSummonType(),SUMMON_TYPE_SYNCHRO)==SUMMON_TYPE_SYNCHRO then
        c:RegisterFlagEffect(3112,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
    end
end

function c04103111.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return c:GetFlagEffect(3112)~=0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.IsExistingMatchingCard(c04103111.rfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,c) end
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,LOCATION_GRAVE)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
    Duel.SetChainLimit(aux.FALSE)
end

function c04103111.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectMatchingCard(tp,c04103111.rfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,c)
    if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) then
        Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
    end
end

function c04103111.rfilter(c)
    return c:IsCode(3110) and c:IsAbleToRemove()
end

