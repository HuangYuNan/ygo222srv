--镜世录 二重结界
function c29201068.initial_effect(c)
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
    e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
    e2:SetCondition(c29201068.spcon)
    e2:SetOperation(c29201068.spop)
    c:RegisterEffect(e2)
    --cannot attack
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EFFECT_CANNOT_ATTACK)
    e3:SetTargetRange(LOCATION_MZONE,0)
    e3:SetTarget(c29201068.antarget)
    c:RegisterEffect(e3)
    --immune
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE)
    e5:SetRange(LOCATION_MZONE)
    e5:SetCode(EFFECT_IMMUNE_EFFECT)
    e5:SetValue(c29201068.efilter)
    c:RegisterEffect(e5)
    --Eraser
    local e6=Effect.CreateEffect(c)
    e6:SetDescription(aux.Stringid(29201068,0))
    e6:SetCategory(CATEGORY_DESTROY)
    e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e6:SetCode(EVENT_TO_GRAVE)
    e6:SetCondition(c29201068.erascon)
    e6:SetTarget(c29201068.erastg)
    e6:SetOperation(c29201068.erasop)
    c:RegisterEffect(e6)
    --suicide
    local e7=Effect.CreateEffect(c)
    e7:SetDescription(aux.Stringid(29201068,1))
    e7:SetType(EFFECT_TYPE_IGNITION)
    e7:SetCategory(CATEGORY_DESTROY)
    e7:SetRange(LOCATION_MZONE)
    e7:SetTarget(c29201068.destg)
    e7:SetOperation(c29201068.desop)
    c:RegisterEffect(e7)
end
function c29201068.antarget(e,c)
    return c~=e:GetHandler()
end
function c29201068.efilter(e,te)
    if te:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return true
    else return aux.qlifilter(e,te) end
end
function c29201068.spcfilter(c)
    return c:IsSetCard(0x63e0) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c29201068.spcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.IsExistingMatchingCard(c29201068.spcfilter,tp,LOCATION_MZONE,0,3,nil)
        and Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
end
function c29201068.spop(e,tp,eg,ep,ev,re,r,rp,c)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c29201068.spcfilter,tp,LOCATION_MZONE,0,3,3,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c29201068.erascon(e)
    return e:GetHandler():IsReason(REASON_DESTROY)
end
function c29201068.erastg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c29201068.erasop(e,tp,eg,ep,ev,re,r,rp)
    local dg=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
    Duel.Destroy(dg,REASON_EFFECT)
end
function c29201068.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsDestructable() end
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c29201068.desop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
