--凋叶棕-rebellion 
function c29200142.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x53e0),aux.NonTuner(Card.IsSetCard,0x53e0),1)
    c:EnableReviveLimit()
    --destroy replace
    local e14=Effect.CreateEffect(c)
    e14:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e14:SetCode(EFFECT_DESTROY_REPLACE)
    e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e14:SetRange(LOCATION_MZONE)
    e14:SetTarget(c29200142.reptg)
    c:RegisterEffect(e14)
    --return
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1,29200142)
    e2:SetTarget(c29200142.rettg)
    e2:SetOperation(c29200142.retop)
    c:RegisterEffect(e2)
    --discard deck
    local e8=Effect.CreateEffect(c)
    e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e8:SetCategory(CATEGORY_DECKDES)
    e8:SetDescription(aux.Stringid(29200142,1))
    e8:SetCode(EVENT_PHASE+PHASE_END)
    e8:SetRange(LOCATION_MZONE)
    e8:SetCountLimit(1)
    e8:SetCondition(c29200142.discon)
    e8:SetTarget(c29200142.distg)
    e8:SetOperation(c29200142.disop)
    c:RegisterEffect(e8)
end
function c29200142.discon(e,tp,eg,ep,ev,re,r,rp)
    return tp==Duel.GetTurnPlayer()
end
function c29200142.distg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end
function c29200142.disop(e,tp,eg,ep,ev,re,r,rp)
    Duel.DiscardDeck(tp,3,REASON_EFFECT)
end
function c29200142.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return e:GetHandler():IsReason(REASON_EFFECT+REASON_BATTLE) and c:GetDefense()~=0 end
    if Duel.SelectYesNo(tp,aux.Stringid(29200142,0)) then
    local preatk=c:GetAttack()
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
    e1:SetReset(RESET_EVENT+0x1ff0000)
    e1:SetCode(EFFECT_UPDATE_DEFENSE)
    e1:SetValue(-500)
    c:RegisterEffect(e1)
    if predef~=0 and c:GetDefense()==0 then 
       Duel.Destroy(e:GetHandler(),REASON_EFFECT)
    end
        return true
    else return false end
end
function c29200142.retfilter1(c)
    return c:IsSetCard(0x53e0) and c:IsAbleToDeck()
end
function c29200142.retfilter2(c)
    return c:IsAbleToHand()
end
function c29200142.rettg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return false end
    if chk==0 then return Duel.IsExistingTarget(c29200142.retfilter1,tp,LOCATION_GRAVE,0,2,nil)
        and Duel.IsExistingTarget(c29200142.retfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
    local g1=Duel.SelectTarget(tp,c29200142.retfilter1,tp,LOCATION_GRAVE,0,2,2,nil)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
    local g2=Duel.SelectTarget(tp,c29200142.retfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,g1:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,g2,1,0,0)
end
function c29200142.retop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
    local g1=g:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
    if Duel.SendtoDeck(g1,nil,0,REASON_EFFECT)~=0 then
        local og=Duel.GetOperatedGroup()
        if og:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
        local g2=g:Filter(Card.IsLocation,nil,LOCATION_ONFIELD)
        Duel.SendtoHand(g2,nil,REASON_EFFECT)
    end
end

