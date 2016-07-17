--Glitter -Starving Trancer Remix-
function c37564039.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c37564039.cost)
	e1:SetTarget(c37564039.target)
	e1:SetOperation(c37564039.activate)
	c:RegisterEffect(e1)
	if not c37564039.chk then
		c37564039.chk=true
		local ex=Effect.GlobalEffect()
		ex:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ex:SetCode(EVENT_ADJUST)
		ex:SetOperation(c37564039.reg)
		Duel.RegisterEffect(ex,0)
	end
end
function c37564039.reg(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,0xff,0xff,nil,TYPE_XYZ)
	g:ForEach(function(c)
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(37564039,0))
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e3:SetCode(EVENT_PHASE+PHASE_END)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCountLimit(1)
		e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
			return Duel.GetTurnPlayer()==tp and e:GetHandler():GetOverlayGroup():IsExists(aux.FilterEqualFunction(Card.GetOriginalCode,37564039),1,nil)
		end)
		e3:SetTarget(c37564039.mttg)
		e3:SetOperation(c37564039.mtop)
		c:RegisterEffect(e3)
	end)
	e:Reset()
end
function c37564039.mtfilter(c)
	return c:IsSetCard(0x770)
end
function c37564039.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564039.mtfilter,tp,LOCATION_EXTRA,0,1,nil) end
end
function c37564039.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c37564039.mtfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function c37564039.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c37564039.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x770)
end
function c37564039.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c37564039.filter(chkc) end
	if chk==0 then
		if e:GetLabel()==0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingTarget(c37564039.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c37564039.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c37564039.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) and c:IsRelateToEffect(e) then
		c:CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(c))
	end
end

