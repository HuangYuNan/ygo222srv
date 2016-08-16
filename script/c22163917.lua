--傲娇魔法少女远坂凛
function c22163917.initial_effect(c)
	--xyz summon
    aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x370),8,2,c22163917.ovfilter,aux.Stringid(22163917,0))
    c:EnableReviveLimit()
    --indes
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_IMMUNE_EFFECT)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTargetRange(LOCATION_ONFIELD,0)
    e1:SetTarget(c22163917.indtg)
    e1:SetValue(c22163917.efilter)
    c:RegisterEffect(e1)
	--remove
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_REMOVE)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetHintTiming(0,0x1e0)
    e2:SetCost(c22163917.thcost)
    e2:SetTarget(c22163917.thtg)
    e2:SetOperation(c22163917.thop)
    c:RegisterEffect(e2)
end
function c22163917.ovfilter(c)
    return c:IsFaceup() and c:IsCode(22163916)
end
function c22163917.indtg(e,c)
    return c:GetSequence()==6 or c:GetSequence()==7
end
function c22163917.efilter(e,re)
    return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c22163917.cfilter(c)
    return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDiscardable()
end
function c22163917.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) 
		and Duel.IsExistingMatchingCard(c22163917.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
    Duel.DiscardHand(tp,c22163917.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c22163917.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
    Duel.SetChainLimit(aux.FALSE)
end
function c22163917.thop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT) then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
    end
end