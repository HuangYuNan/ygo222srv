--帝国卫队 传教士
function c12400010.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(12400010,0))
    e1:SetCategory(CATEGORY_DRAW)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCost(c12400010.cost)
    e1:SetTarget(c12400010.target)
    e1:SetOperation(c12400010.activate)
    c:RegisterEffect(e1)
    --reg
    local ea=Effect.CreateEffect(c)
    ea:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    ea:SetCode(EVENT_TO_GRAVE)
    ea:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ea:SetCondition(c12400010.descon)
    ea:SetOperation(c12400010.regop)
    c:RegisterEffect(ea)
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(12400010,2))
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e4:SetCode(EVENT_PHASE+PHASE_END)
    e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,12400010)
    e4:SetCondition(c12400010.thcon)
    e4:SetCost(c12400010.cost2)
    e4:SetTarget(c12400010.thtg)
    e4:SetOperation(c12400010.thop)
    c:RegisterEffect(e4)
end
function c12400010.cfilter(c)
    return c:IsSetCard(0x3390) and c:IsAbleToGraveAsCost()
end
function c12400010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c12400010.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
    Duel.DiscardHand(tp,c12400010.cfilter,1,1,REASON_COST,nil)
end
function c12400010.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(2)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c12400010.spfilter(c)
    return c:IsSetCard(0x3390) and c:IsAbleToGrave()
end
function c12400010.activate(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
    local g=Duel.GetMatchingGroup(c12400010.spfilter,tp,LOCATION_HAND,0,nil)
    if Duel.IsPlayerCanDraw(tp,1) and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(12400010,3)) then
        Duel.BreakEffect()
        local sg=g:Select(tp,1,1,nil)
        Duel.SendtoGrave(sg,REASON_EFFECT)
		Duel.Draw(tp,1,REASON_EFFECT)
    end
end
function c12400010.descon(e,tp,eg,ep,ev,re,r,rp)
    return re and re:GetHandler():IsSetCard(0x3390)
end
function c12400010.regop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    c:RegisterFlagEffect(12400010,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c12400010.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(12400010)>0
end
function c12400010.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
    Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c12400010.setfilter(c)
    return c:IsSetCard(0x3390) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c12400010.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c12400010.setfilter(chkc) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
        and Duel.IsExistingTarget(c12400010.setfilter,tp,LOCATION_GRAVE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
    local g=Duel.SelectTarget(tp,c12400010.setfilter,tp,LOCATION_GRAVE,0,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c12400010.thop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsSSetable() then
        Duel.SSet(tp,tc)
        Duel.ConfirmCards(1-tp,tc)
    end
end
