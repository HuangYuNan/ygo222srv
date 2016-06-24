--凋叶棕-改-然后终有一日能再次相逢
function c29200166.initial_effect(c)
    --fusion material
    c:EnableReviveLimit()
    aux.AddFusionProcFunRep(c,c29200166.ffilter,2,false)
    --spsummon condition
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetValue(c29200166.splimit)
    c:RegisterEffect(e1)
    --special summon rule
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetCondition(c29200166.spcon)
    e2:SetOperation(c29200166.spop)
    c:RegisterEffect(e2)
    --negate
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    e3:SetCondition(c29200166.con)
    e3:SetOperation(c29200166.op)
    c:RegisterEffect(e3)
    local e12=Effect.CreateEffect(c)
    e12:SetType(EFFECT_TYPE_SINGLE)
    e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e12:SetRange(LOCATION_MZONE)
    e12:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e12:SetValue(1)
    c:RegisterEffect(e12)
    --attack all
    local ea=Effect.CreateEffect(c)
    ea:SetType(EFFECT_TYPE_SINGLE)
    ea:SetCode(EFFECT_ATTACK_ALL)
    ea:SetValue(1)
    c:RegisterEffect(ea)
end
function c29200166.ffilter(c)
    return c:IsFusionSetCard(0x53e0) and c:IsType(TYPE_FUSION)
end
function c29200166.splimit(e,se,sp,st)
    return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c29200166.spfilter1(c,tp,fc)
    return c:IsFusionSetCard(0x53e0) and c:IsType(TYPE_FUSION) and c:IsCanBeFusionMaterial(fc)
        and Duel.CheckReleaseGroup(tp,c29200166.spfilter2,1,c,fc)
end
function c29200166.spfilter2(c,fc)
    return c:IsFusionSetCard(0x53e0) and c:IsType(TYPE_FUSION) and c:IsCanBeFusionMaterial(fc)
end
function c29200166.spcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
        and Duel.CheckReleaseGroup(tp,c29200166.spfilter1,1,nil,tp,c)
end
function c29200166.spop(e,tp,eg,ep,ev,re,r,rp,c)
    local g1=Duel.SelectReleaseGroup(tp,c29200166.spfilter1,1,1,nil,tp,c)
    local g2=Duel.SelectReleaseGroup(tp,c29200166.spfilter2,1,1,g1:GetFirst(),c)
    g1:Merge(g2)
    c:SetMaterial(g1)
    Duel.Release(g1,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
function c29200166.con(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:GetSummonType()==SUMMON_TYPE_FUSION 
end
function c29200166.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
    --disable spsummon
    local e13=Effect.CreateEffect(c)
    e13:SetDescription(aux.Stringid(29200166,2))
    e13:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
    e13:SetType(EFFECT_TYPE_QUICK_O)
    e13:SetRange(LOCATION_MZONE)
    e13:SetCode(EVENT_SPSUMMON)
    e13:SetCountLimit(1)
    e13:SetReset(RESET_EVENT+0x1fe0000)
    e13:SetCondition(c29200166.condition)
    e13:SetTarget(c29200166.target)
    e13:SetOperation(c29200166.operation)
    c:RegisterEffect(e13)
    --lp rec
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200166,0))
    e1:SetCategory(CATEGORY_RECOVER)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EVENT_DESTROY)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetCondition(c29200166.reccon)
    e1:SetTarget(c29200166.rectg)
    e1:SetOperation(c29200166.recop)
    c:RegisterEffect(e1)
end
function c29200166.filter4(c,tp)
    return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER) 
end
function c29200166.reccon(e,tp,eg,ep,ev,re,r,rp)
    return eg:IsExists(c29200166.filter4,1,nil,tp)
end
function c29200166.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1000)
    Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c29200166.recop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Recover(p,d,REASON_EFFECT)
end
function c29200166.condition(e,tp,eg,ep,ev,re,r,rp)
    return tp~=ep and Duel.GetCurrentChain()==0
end
function c29200166.filter(c)
    return c:IsSetCard(0x53e0)
end
function c29200166.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29200166.filter,tp,LOCATION_HAND,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c29200166.operation(e,tp,eg,ep,ev,re,r,rp,chk)
    Duel.NegateSummon(eg)
    Duel.SendtoHand(eg,nil,REASON_EFFECT)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c29200166.filter,tp,LOCATION_HAND,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.BreakEffect()
        Duel.SendtoGrave(g,REASON_EFFECT)
    end
end
function c29200166.efilter(e,te)
    return te:GetOwner()~=e:GetOwner()
end
