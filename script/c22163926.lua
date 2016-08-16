--傲娇次元女神诺瓦露
function c22163926.initial_effect(c)
    c:SetUniqueOnField(1,0,22163926)
    --xyz summon
    aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x370),8,2)
    c:EnableReviveLimit()
	--atkup
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(c22163926.val)
    c:RegisterEffect(e1)
	--disable
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_CONTROL+CATEGORY_DISABLE)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_CHAINING)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c22163926.discon)
    e2:SetTarget(c22163926.distg)
    e2:SetOperation(c22163926.disop)
    c:RegisterEffect(e2)
	--sp
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(22163926,1))
    e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetCode(EVENT_TO_GRAVE)
    e3:SetCondition(c22163926.reccon)
    e3:SetTarget(c22163926.rectg)
    e3:SetOperation(c22163926.recop)
    c:RegisterEffect(e3)
end
function c22163926.val(e,c)
    return Duel.GetMatchingGroupCount(Card.IsFaceup,0,LOCATION_MZONE,LOCATION_MZONE,c)*500
end
function c22163926.discon(e,tp,eg,ep,ev,re,r,rp)
    return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and rp~=tp 
		and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
end
function c22163926.distg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
    if re:GetHandler():IsAbleToChangeControler() and re:GetHandler():IsRelateToEffect(re) then
        Duel.SetOperationInfo(0,CATEGORY_CONTROL,eg,1,0,0)
    end
end
function c22163926.disop(e,tp,eg,ep,ev,re,r,rp)
    Duel.NegateActivation(ev)
    local c=e:GetHandler()
    if re:GetHandler():IsRelateToEffect(re) and not re:GetHandler():IsImmuneToEffect(e) then
        local og=re:GetHandler():GetOverlayGroup()
        if og:GetCount()>0 then
            Duel.SendtoGrave(og,REASON_RULE)
        end
        Duel.Overlay(c,Group.FromCards(re:GetHandler()))
    end
end
function c22163926.reccon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c22163926.recfilter(c,e,tp)
    return c:IsFaceup() and c:IsCode(22163925) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22163926.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c22163926.recfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
end
function c22163926.recop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c22163926.recfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
    if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    end
end
