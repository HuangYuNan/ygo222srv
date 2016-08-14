--帝国卫队 预备队
function c12400015.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,c12400015.mfilter,4,2)
    c:EnableReviveLimit()
    --damage
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DAMAGE)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetCountLimit(1,12400015)
    e2:SetTarget(c12400015.damtg)
    e2:SetOperation(c12400015.damop)
    c:RegisterEffect(e2)
    --draw
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DRAW)
    e1:SetDescription(aux.Stringid(12400015,0))
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1,12410015)
    e1:SetCost(c12400015.cost)
    e1:SetTarget(c12400015.target)
    e1:SetOperation(c12400015.operation)
    c:RegisterEffect(e1)
    --reg
    local ea=Effect.CreateEffect(c)
    ea:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    ea:SetCode(EVENT_TO_GRAVE)
    ea:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ea:SetCondition(c12400015.descon)
    ea:SetOperation(c12400015.regop)
    c:RegisterEffect(ea)
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(12400015,2))
    e4:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e4:SetCode(EVENT_PHASE+PHASE_END)
    e4:SetRange(LOCATION_GRAVE)
    e4:SetCondition(c12400015.thcon)
    e4:SetTarget(c12400015.thtg)
    e4:SetOperation(c12400015.thop)
    c:RegisterEffect(e4)
end
function c12400015.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c12400015.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c12400015.operation(e,tp,eg,ep,ev,re,r,rp,chk)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
end
function c12400015.mfilter(c)
    return c:IsRace(0x1) and c:IsAttribute(0x20)
end
function c12400015.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(1-tp)
    Duel.SetTargetParam(500)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c12400015.desfilter(c)
    return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c12400015.damop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Damage(p,d,REASON_EFFECT)
    if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 then
        if Duel.SelectYesNo(tp,aux.Stringid(12400015,0)) then
            local sg=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1)
    		if sg:GetCount()>0 then
                Duel.BreakEffect()
                Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
    		end
        end
	end
end
function c12400015.descon(e,tp,eg,ep,ev,re,r,rp)
    return re and re:GetHandler():IsSetCard(0x3390)
end
function c12400015.regop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    c:RegisterFlagEffect(12400015,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c12400015.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(12400015)>0
end
function c12400015.setfilter(c)
    return c:IsSetCard(0x3390) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck()
end
function c12400015.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c12400015.setfilter(chkc) end
    if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
        and Duel.IsExistingTarget(c12400015.setfilter,tp,LOCATION_GRAVE,0,2,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
    local g=Duel.SelectTarget(tp,c12400015.setfilter,tp,LOCATION_GRAVE,0,2,2,e:GetHandler())
    Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c12400015.thop(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) then return end
    local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
    if tg:GetCount()<=0 then return end
    Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
    Duel.ShuffleDeck(tp)
    Duel.BreakEffect()
    Duel.Draw(tp,1,REASON_EFFECT)
end



