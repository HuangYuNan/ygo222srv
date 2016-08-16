--元素爆发·冰雪
function c37564026.initial_effect(c)
	aux.AddXyzProcedure(c,nil,5,4,c37564026.ovfilter,aux.Stringid(37564026,0))
	c:EnableReviveLimit()
--ctxm
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--rm
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564026,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC_G)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c37564026.rmcon)
	e2:SetOperation(c37564026.rmop)
	c:RegisterEffect(e2)
--ret
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_ADJUST)
	e3:SetCondition(c37564026.adcon)
	e3:SetTarget(c37564026.rettg)
	e3:SetOperation(c37564026.retop)
	c:RegisterEffect(e3)
end
function c37564026.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x770) and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>=3
end
function c37564026.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) and c:GetOverlayCount()>1 and c:IsFaceup() and not c:IsDisabled()
end
function c37564026.rmop(e,tp,eg,ep,ev,re,r,rp,c,sg,og)  
	Duel.Hint(HINT_CARD,0,37564026)
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
function c37564026.adcon(e)
	return e:GetHandler():GetOverlayCount()==0 and not e:GetHandler():IsDisabled()
end
function c37564026.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtra() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c37564026.retop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsLocation(LOCATION_MZONE) or e:GetHandler():IsFacedown() then return end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end