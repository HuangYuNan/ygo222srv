--暗影魔战姬 影之蝶
function c73203108.initial_effect(c)
    c:SetUniqueOnField(1,0,73203108)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x732),5,3,c73203108.ovfilter,aux.Stringid(73203108,0))
	c:EnableReviveLimit()
	--effect target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(73203108,1))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c73203108.discon)
	e3:SetCost(c73203108.discost)
	e3:SetTarget(c73203108.distg)
	e3:SetOperation(c73203108.disop)
	c:RegisterEffect(e3)
end
function c73203108.ovfilter(c)
    local rk=c:GetRank()
	return c:IsFaceup() and c:IsSetCard(0x732) and c:IsType(TYPE_XYZ) and rk==4
end	
function c73203108.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and tp~=ep 
	    and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,73203107)
end
function c73203108.cfilter(c)
	return c:IsSetCard(0x732) and c:IsAbleToDeckAsCost()
end
function c73203108.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) and Duel.IsExistingMatchingCard(c73203108.cfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TPDECK)
	local g=Duel.SelectMatchingCard(tp,c73203108.cfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c73203108.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c73203108.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end