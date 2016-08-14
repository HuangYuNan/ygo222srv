--帝王毒刃战车
function c12400008.initial_effect(c)
    c:EnableReviveLimit()
    --special summon condition
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)
    --special summon
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e2:SetRange(LOCATION_HAND)
    e2:SetCondition(c12400008.sprcon)
    e2:SetOperation(c12400008.sprop)
    c:RegisterEffect(e2)
    --damage
    local e12=Effect.CreateEffect(c)
    e12:SetCategory(CATEGORY_DAMAGE)
    e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e12:SetCode(EVENT_SPSUMMON_SUCCESS)
    e12:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e12:SetTarget(c12400008.damtg)
    e12:SetOperation(c12400008.damop)
    c:RegisterEffect(e12)
    --destroy
    local e7=Effect.CreateEffect(c)
    e7:SetDescription(aux.Stringid(12400008,1))
    e7:SetCategory(CATEGORY_DESTROY)
    e7:SetType(EFFECT_TYPE_IGNITION)
    e7:SetRange(LOCATION_MZONE)
    e7:SetCountLimit(1,12400008)
    e7:SetCost(c12400008.descost)
    e7:SetTarget(c12400008.destg)
    e7:SetOperation(c12400008.desop)
    c:RegisterEffect(e7)
    --atk
    local e10=Effect.CreateEffect(c)
    e10:SetType(EFFECT_TYPE_FIELD)
    e10:SetRange(LOCATION_MZONE)
    e10:SetTargetRange(LOCATION_MZONE,0)
    e10:SetCode(EFFECT_UPDATE_ATTACK)
    e10:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x3390))
    e10:SetValue(500)
    c:RegisterEffect(e10)
    --spsummon
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(12400008,2))
    e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e4:SetCode(EVENT_TO_GRAVE)
    e4:SetProperty(EFFECT_FLAG_DELAY)
    e4:SetCost(c12400008.spcost)
    e4:SetTarget(c12400008.sptg)
    e4:SetOperation(c12400008.spop)
    c:RegisterEffect(e4)
end
function c12400008.descost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 and Duel.IsExistingMatchingCard(c12400008.costfilter,tp,LOCATION_ONFIELD,0,2,nil) end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_OATH)
    e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e:GetHandler():RegisterEffect(e1)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c12400008.costfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c12400008.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
    local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
    Duel.SetChainLimit(c12400008.chlimit)
end
function c12400008.chlimit(e,ep,tp)
    return tp==ep
end
function c12400008.desop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
    Duel.Destroy(g,REASON_EFFECT)
end
function c12400008.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(1-tp)
    Duel.SetTargetParam(1000)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c12400008.filter8(c)
    return c:IsSetCard(0x3390) and c:IsAbleToGrave()
end
function c12400008.damop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Damage(p,d,REASON_EFFECT)
    local g=Duel.GetMatchingGroup(c12400008.filter8,tp,LOCATION_DECK,0,nil)
    if g:GetCount()>2 and Duel.SelectYesNo(tp,aux.Stringid(12400008,0)) then
        Duel.BreakEffect()
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
        local sg=g:Select(tp,3,3,nil)
        Duel.SendtoGrave(sg,REASON_EFFECT)
    end
end
function c12400008.spcfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x3390) and c:IsAbleToGraveAsCost()
end
function c12400008.sprcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3
        and Duel.IsExistingMatchingCard(c12400008.spcfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,3,nil)
end
function c12400008.sprop(e,tp,eg,ep,ev,re,r,rp,c)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c12400008.spcfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,3,3,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c12400008.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and e:GetHandler():IsLocation(LOCATION_GRAVE) end
    Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c12400008.filter(c)
    return c:IsRace(RACE_MACHINE) and c:IsAbleToHand()
end
function c12400008.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c12400008.filter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c12400008.spop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c12400008.filter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end

