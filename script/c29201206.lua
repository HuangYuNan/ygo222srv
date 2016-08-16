--幽邃教教徒 贝蕾尔
function c29201206.initial_effect(c)
    --special summon
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(29201206,0))
    e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e4:SetType(EFFECT_TYPE_IGNITION)
    e4:SetRange(LOCATION_HAND)
    e4:SetCountLimit(1,29201206)
    e4:SetCost(c29201206.spcost)
    e4:SetTarget(c29201206.sptg)
    e4:SetOperation(c29201206.spop)
    c:RegisterEffect(e4)
    --synchro effect
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29201206,2))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_MZONE)
    e2:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
    e2:SetCountLimit(1)
    e2:SetCondition(c29201206.sccon)
    e2:SetTarget(c29201206.sctg)
    e2:SetOperation(c29201206.scop)
    c:RegisterEffect(e2)
    --lv up
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29201206,1))
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
    e1:SetCountLimit(1,29201206)
    e1:SetTarget(c29201206.target)
    e1:SetOperation(c29201206.operation)
    c:RegisterEffect(e1)
    local e8=e1:Clone()
    e8:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e8)
end
function c29201206.filter(c)
    return c:IsFaceup() and c:GetLevel()>0 and c:IsSetCard(0x63e1)
end
function c29201206.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and c29201206.filter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c29201206.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    local g=Duel.SelectTarget(tp,c29201206.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
    local op=0
    Duel.Hint(HINT_SELECTMSG,tp,550)
    if g:GetFirst():GetLevel()==1 then
        op=Duel.SelectOption(tp,aux.Stringid(29201206,3))
    else
        op=Duel.SelectOption(tp,aux.Stringid(29201206,3),aux.Stringid(29201206,4))
    end
    e:SetLabel(op)
end
function c29201206.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if tc:IsFaceup() and tc:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(c)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_LEVEL)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        if e:GetLabel()==0 then
            e1:SetValue(1)
        else
            e1:SetValue(-1)
        end
        tc:RegisterEffect(e1)
    end
end
function c29201206.costfilter(c)
    return c:IsSetCard(0x63e1) and not c:IsPublic()
end
function c29201206.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29201206.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) 
      and not e:GetHandler():IsPublic() end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
    local g=Duel.SelectMatchingCard(tp,c29201206.costfilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
    local tc=g:GetFirst()
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_PUBLIC)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e:GetHandler():RegisterEffect(e1)
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_PUBLIC)
    e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    tc:RegisterEffect(e2)
    Duel.ShuffleHand(tp)
end
function c29201206.spfilter(c,e,tp)
    return c:IsCode(29201205) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29201206.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c29201206.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c29201206.spop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c29201206.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
    if g:GetCount()>0 then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    end
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetTargetRange(1,0)
    e2:SetTarget(c29201206.splimit)
    e2:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e2,tp)
end
function c29201206.splimit(e,c)
    return not c:IsSetCard(0x63e1)
end
function c29201206.sccon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetTurnPlayer()==tp then return false end
    local ph=Duel.GetCurrentPhase()
    return ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2
end
function c29201206.mfilter(c)
    return c:IsSetCard(0x63e1)
end
function c29201206.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local mg=Duel.GetMatchingGroup(c29201206.mfilter,tp,LOCATION_MZONE,0,nil)
        return Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,nil,mg)
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29201206.scop(e,tp,eg,ep,ev,re,r,rp)
    local mg=Duel.GetMatchingGroup(c29201206.mfilter,tp,LOCATION_MZONE,0,nil)
    local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,nil,mg)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local sg=g:Select(tp,1,1,nil)
        Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
    end
end