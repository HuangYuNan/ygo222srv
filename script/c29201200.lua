--幽邃教教徒 娇拉汀
function c29201200.initial_effect(c)
    --to hand
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29201200,0))
    e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetCountLimit(1,29201200)
    e1:SetTarget(c29201200.thtg)
    e1:SetOperation(c29201200.thop)
    c:RegisterEffect(e1)
    local e8=e1:Clone()
    e8:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e8)
    --synchro effect
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29201200,2))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_MZONE)
    e2:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
    e2:SetCountLimit(1)
    e2:SetCondition(c29201200.sccon)
    e2:SetTarget(c29201200.sctg)
    e2:SetOperation(c29201200.scop)
    c:RegisterEffect(e2)
    --recover
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29201200,1))
    e10:SetCategory(CATEGORY_RECOVER)
    e10:SetType(EFFECT_TYPE_QUICK_O)
    e10:SetCode(EVENT_FREE_CHAIN)
    e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e10:SetRange(LOCATION_HAND)
    e10:SetCountLimit(1)
    e10:SetCost(c29201200.reccost)
    e10:SetTarget(c29201200.rectg)
    e10:SetOperation(c29201200.recop)
    c:RegisterEffect(e10)
end
function c29201200.reccost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return not e:GetHandler():IsPublic() end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_PUBLIC)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e:GetHandler():RegisterEffect(e1)
end
function c29201200.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(500)
    Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c29201200.recop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Recover(p,d,REASON_EFFECT)
end
function c29201200.sfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201200.thfilter(c,lv)
    return c:IsLevelBelow(lv) and c:IsSetCard(0x63e1) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c29201200.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local count=Duel.GetMatchingGroupCount(c29201200.sfilter,tp,LOCATION_HAND,0,nil)
        return Duel.IsExistingMatchingCard(c29201200.thfilter,tp,LOCATION_DECK,0,1,nil,count)
    end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29201200.thop(e,tp,eg,ep,ev,re,r,rp)
    local count=Duel.GetMatchingGroupCount(c29201200.sfilter,tp,LOCATION_HAND,0,nil)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c29201200.thfilter,tp,LOCATION_DECK,0,1,1,nil,count)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end
function c29201200.sccon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetTurnPlayer()==tp then return false end
    local ph=Duel.GetCurrentPhase()
    return ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2
end
function c29201200.mfilter(c)
    return c:IsSetCard(0x63e1)
end
function c29201200.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local mg=Duel.GetMatchingGroup(c29201200.mfilter,tp,LOCATION_MZONE,0,nil)
        return Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,nil,mg)
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29201200.scop(e,tp,eg,ep,ev,re,r,rp)
    local mg=Duel.GetMatchingGroup(c29201200.mfilter,tp,LOCATION_MZONE,0,nil)
    local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,nil,mg)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local sg=g:Select(tp,1,1,nil)
        Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
    end
end
