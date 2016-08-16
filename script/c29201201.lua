--幽邃教教徒 潘朵拉
function c29201201.initial_effect(c)
    --to hand
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29201201,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetCountLimit(1,29201201)
    e1:SetTarget(c29201201.thtg)
    e1:SetOperation(c29201201.thop)
    c:RegisterEffect(e1)
    local e8=e1:Clone()
    e8:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e8)
    --synchro effect
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29201201,2))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_MZONE)
    e2:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
    e2:SetCountLimit(1)
    e2:SetCondition(c29201201.sccon)
    e2:SetTarget(c29201201.sctg)
    e2:SetOperation(c29201201.scop)
    c:RegisterEffect(e2)
    --recover
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29201201,1))
    e10:SetCategory(CATEGORY_ATKCHANGE)
    e10:SetType(EFFECT_TYPE_QUICK_O)
    e10:SetCode(EVENT_FREE_CHAIN)
    e10:SetHintTiming(TIMING_DAMAGE_STEP)
    e10:SetRange(LOCATION_HAND)
    e10:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
    e10:SetCountLimit(1)
    e10:SetCondition(c29201201.condition)
    e10:SetCost(c29201201.reccost)
    e10:SetTarget(c29201201.rectg)
    e10:SetOperation(c29201201.recop)
    c:RegisterEffect(e10)
end
function c29201201.condition(e,tp,eg,ep,ev,re,r,rp)
    local phase=Duel.GetCurrentPhase()
    return phase~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c29201201.reccost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return not e:GetHandler():IsPublic() end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_PUBLIC)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e:GetHandler():RegisterEffect(e1)
end
function c29201201.filter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201201.rectg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c29201201.filter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c29201201.filter,tp,LOCATION_MZONE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    Duel.SelectTarget(tp,c29201201.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c29201201.recop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsFaceup() then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(800)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e1)
    end
end
function c29201201.sfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201201.thfilter(c,e,tp,lv)
    return c:IsLevelBelow(lv) and c:IsSetCard(0x63e1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29201201.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local count=Duel.GetMatchingGroupCount(c29201201.sfilter,tp,LOCATION_HAND,0,nil)
        return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c29201201.thfilter,tp,LOCATION_DECK,0,1,nil,e,tp,count)
	end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c29201201.thop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    local count=Duel.GetMatchingGroupCount(c29201201.sfilter,tp,LOCATION_HAND,0,nil)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c29201201.thfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,count)
    if g:GetCount()>0 then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c29201201.sccon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetTurnPlayer()==tp then return false end
    local ph=Duel.GetCurrentPhase()
    return ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2
end
function c29201201.mfilter(c)
    return c:IsSetCard(0x63e1)
end
function c29201201.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local mg=Duel.GetMatchingGroup(c29201201.mfilter,tp,LOCATION_MZONE,0,nil)
        return Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,nil,mg)
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29201201.scop(e,tp,eg,ep,ev,re,r,rp)
    local mg=Duel.GetMatchingGroup(c29201201.mfilter,tp,LOCATION_MZONE,0,nil)
    local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,nil,mg)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local sg=g:Select(tp,1,1,nil)
        Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
    end
end
