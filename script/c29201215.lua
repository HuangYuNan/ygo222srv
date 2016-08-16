--幽邃教主教 坎蒂丝·怠惰
function c29201215.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x63e1),aux.NonTuner(Card.IsSetCard,0x63e1),1)
    c:EnableReviveLimit()
    --synchro summon
    local e11=Effect.CreateEffect(c)
    e11:SetDescription(aux.Stringid(29201215,1))
    e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e11:SetType(EFFECT_TYPE_QUICK_O)
    e11:SetCode(EVENT_FREE_CHAIN)
    e11:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
    e11:SetRange(LOCATION_MZONE)
    e11:SetCondition(c29201215.sccon)
    e11:SetTarget(c29201215.sctg)
    e11:SetOperation(c29201215.scop)
    c:RegisterEffect(e11)
    --atk
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29201215,0))
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_DELAY)
    e10:SetCode(EVENT_SPSUMMON_SUCCESS)
    e10:SetCondition(c29201215.atkcon)
    e10:SetTarget(c29201215.damtg)
    e10:SetOperation(c29201215.atkop)
    c:RegisterEffect(e10)
    --tohand
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCondition(c29201215.spcon)
    e1:SetTarget(c29201215.sptg)
    e1:SetOperation(c29201215.spop)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e2)
end
function c29201215.sccon(e,tp,eg,ep,ev,re,r,rp)
    local ph=Duel.GetCurrentPhase()
    return not e:GetHandler():IsStatus(STATUS_CHAINING) and Duel.GetTurnPlayer()~=tp
        and (ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2)
end
function c29201215.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler()) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29201215.scop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:GetControler()~=tp or not c:IsRelateToEffect(e) then return end
    local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,c)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local sg=g:Select(tp,1,1,nil)
        Duel.SynchroSummon(tp,sg:GetFirst(),c)
    end
end
function c29201215.atkcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c29201215.sfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201215.filter(c)
    return c:IsFaceup() and c:IsCanTurnSet()
end
function c29201215.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    local ct=Duel.GetMatchingGroupCount(c29201215.sfilter,tp,LOCATION_HAND,0,nil)
    if chk==0 then return ct>0
        and Duel.IsExistingMatchingCard(c29201215.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    local g=Duel.GetMatchingGroup(c29201215.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
    Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c29201215.atkop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local ct=Duel.GetMatchingGroupCount(c29201215.sfilter,tp,LOCATION_HAND,0,nil)
    local g=Duel.SelectMatchingCard(tp,c29201215.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,ct,nil)
    if g:GetCount()>0 then
        Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
    end
end
function c29201215.cfilter(c,tp)
    return c:IsFaceup() and c:IsSetCard(0x63e1) and c:IsControler(tp)
end
function c29201215.spcon(e,tp,eg,ep,ev,re,r,rp)
    return not eg:IsContains(e:GetHandler()) and eg:IsExists(c29201215.cfilter,1,nil,tp)
end
function c29201215.spfilter(c,e,tp)
    return c:IsLevelBelow(4) and c:IsSetCard(0x63e1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29201215.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c29201215.spfilter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c29201215.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,c29201215.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c29201215.spop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    end
end

