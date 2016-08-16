--凋叶棕-改-随后终有一日能再次相遇
function c29200166.initial_effect(c)
    --xyz summon
    c:EnableReviveLimit()
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetRange(LOCATION_EXTRA)
    e1:SetCondition(c29200166.xyzcon)
    e1:SetOperation(c29200166.xyzop)
    e1:SetValue(SUMMON_TYPE_XYZ)
    c:RegisterEffect(e1)
    --atkup
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29200166,0))
    e2:SetCategory(CATEGORY_TODECK+CATEGORY_ATKCHANGE)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetProperty(EFFECT_FLAG_DELAY)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetCondition(c29200166.atkcon)
    e2:SetTarget(c29200166.tdtg)
    e2:SetOperation(c29200166.tdop)
    c:RegisterEffect(e2)
    --tohand
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(29200166,1))
    e3:SetCategory(CATEGORY_TOGRAVE)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1,29200166)
    e3:SetCost(c29200166.cost)
    e3:SetTarget(c29200166.target)
    e3:SetOperation(c29200166.operation)
    c:RegisterEffect(e3)
    --spsummon
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(29200166,2))
    e4:SetCategory(CATEGORY_REMOVE+CATEGORY_RECOVER)
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
    e4:SetCode(EVENT_LEAVE_FIELD)
    e4:SetCondition(c29200166.spcon)
    e4:SetTarget(c29200166.sptg)
    e4:SetOperation(c29200166.spop)
    c:RegisterEffect(e4)
end
function c29200166.mfilter(c,xyzc)
    return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x53e0) and c:GetOverlayCount()>0 and c:IsCanBeXyzMaterial(xyzc)
end
function c29200166.xyzfilter1(c,g)
    return g:IsExists(c29200166.xyzfilter2,1,c)
end
function c29200166.xyzfilter2(c,rk)
    return c:GetOverlayCount()>0 and c:IsType(TYPE_XYZ) and c:IsSetCard(0x53e0) 
end
function c29200166.xyzcon(e,c,og,min,max)
    if c==nil then return true end
    local tp=c:GetControler()
    local mg=nil
    if og then
        mg=og:Filter(c29200166.mfilter,nil,c)
    else
        mg=Duel.GetMatchingGroup(c29200166.mfilter,tp,LOCATION_MZONE,0,nil,c)
    end
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
        and (not min or min<=2 and max>=2)
        and mg:IsExists(c29200166.xyzfilter1,1,nil,mg)
end
function c29200166.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
    local g=nil
    local sg=Group.CreateGroup()
    if og and not min then
        g=og
        local tc=og:GetFirst()
        while tc do
            sg:Merge(tc:GetOverlayGroup())
            tc=og:GetNext()
        end
    else
        local mg=nil
        if og then
            mg=og:Filter(c29200166.mfilter,nil,c)
        else
            mg=Duel.GetMatchingGroup(c29200166.mfilter,tp,LOCATION_MZONE,0,nil,c)
        end
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
        g=mg:FilterSelect(tp,c29200166.xyzfilter1,1,1,nil,mg)
        local tc1=g:GetFirst()
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
        local g2=mg:FilterSelect(tp,c29200166.xyzfilter2,1,1,tc1,tc1:GetRank())
        local tc2=g2:GetFirst()
        g:Merge(g2)
        sg:Merge(tc1:GetOverlayGroup())
        sg:Merge(tc2:GetOverlayGroup())
    end
    Duel.SendtoGrave(sg,REASON_RULE)
    c:SetMaterial(g)
    Duel.Overlay(c,g)
end
function c29200166.atkcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c29200166.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,PLAYER_ALL,LOCATION_REMOVED)
end
function c29200166.tdop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local g=Duel.GetFieldGroup(tp,LOCATION_REMOVED,LOCATION_REMOVED)
    Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
    if c:IsFaceup() and c:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetReset(RESET_EVENT+0x1ff0000)
        e1:SetValue(g:GetCount()*100)
        c:RegisterEffect(e1)
    end
end
function c29200166.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29200166.desfilter(c,att)
    return c:IsFaceup() and c:IsAttribute(att)
end
function c29200166.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.Hint(HINT_SELECTMSG,tp,563)
    local rc=Duel.AnnounceAttribute(tp,1,0xff)
    Duel.SetTargetParam(rc)
    e:GetHandler():SetHint(CHINT_ATTRIBUTE,rc)
    local g=Duel.GetMatchingGroup(c29200166.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,rc)
    Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c29200166.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local rc=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
    local g=Duel.GetMatchingGroup(c29200166.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,rc)
    --Duel.Destroy(g,REASON_EFFECT)
    Duel.SendtoGrave(g,REASON_EFFECT)
    if c:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_FIELD)
        e1:SetRange(LOCATION_MZONE)
        e1:SetCode(EFFECT_CANNOT_SUMMON)
        e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
        e1:SetTargetRange(1,1)
        e1:SetTarget(c29200166.sumlimit)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e1:SetLabel(rc)
        c:RegisterEffect(e1)
        local e2=e1:Clone()
        e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
        c:RegisterEffect(e2)
    end
end
function c29200166.sumlimit(e,c)
    return c:IsAttribute(e:GetLabel())
end
function c29200166.spcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsPreviousPosition(POS_FACEUP) and c:GetLocation()~=LOCATION_DECK
end
function c29200166.filter(c)
    return c:IsSetCard(0x53e0) and c:IsAbleToRemove()
end
function c29200166.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c29200166.filter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c29200166.filter,tp,LOCATION_GRAVE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectTarget(tp,c29200166.filter,tp,LOCATION_GRAVE,0,1,99,nil)
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetCount()*300)
end
function c29200166.spop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
    --local ct=Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
    local ct=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
    if ct>0 then
        Duel.Recover(tp,ct*300,REASON_EFFECT)
    end
end
