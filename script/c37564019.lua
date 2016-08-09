--Black Rose Apostle
function c37564019.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564019,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,37564019+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c37564019.cost)
	e1:SetTarget(c37564019.target)
	e1:SetOperation(c37564019.activate)
	c:RegisterEffect(e1)
end
function c37564019.ofilter(c)
	return c:GetOverlayCount()~=0 and c:IsSetCard(0x770) and c:IsType(TYPE_XYZ) and c:IsFaceup() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c37564019.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564019.ofilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,532)
	local g=Duel.SelectMatchingCard(tp,c37564019.ofilter,tp,LOCATION_MZONE,0,1,1,nil)
	g:GetFirst():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c37564019.defilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsDestructable()
end
function c37564019.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and c37564019.defilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c37564019.defilter,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c37564019.defilter,tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c37564019.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
