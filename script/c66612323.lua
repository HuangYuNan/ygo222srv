--仙境国与魔术乡
function c66612323.initial_effect(c)
	c:SetUniqueOnField(1,0,66612323)
	---
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--copy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66612320,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c66612323.cpcost)
	e2:SetTarget(c66612323.cptg)
	e2:SetOperation(c66612323.cpop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(66612320,0))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TOGRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c66612323.thcon)
	e3:SetTarget(c66612323.thtg)
	e3:SetOperation(c66612323.thop)
	c:RegisterEffect(e3)
end
function c66612323.refilter(c)
  return c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x660)
end
function c66612323.cpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612323.refilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tg=Duel.SelectMatchingCard(tp,c66612323.refilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,1,nil)
	Duel.Remove(tg,POS_FACEUP,REASON_COST)
end
function c66612323.cpfilter(c)
  return c:IsAbleToDeck() and c:GetType()==TYPE_SPELL and  c:CheckActivateEffect(false,true,false)~=nil
end
function c66612323.cptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then local te=e:GetLabelObject()
		local tg=te:GetTarget()
		return tg and tg(e,tp,eg,ep,ev,re,r,rp,0,chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c66612323.cpfilter,tp,LOCATION_GRAVE,0,1,nil)  end
    e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e:SetCategory(0)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c66612323.cpfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local rtc=g:GetFirst()
    local te=rtc:CheckActivateEffect(false,true,true)
	--[[Duel.ClearTargetCard()
	rtc:CreateEffectRelation(e)
	e:SetLabel(rtc)
	local tg=te:GetTarget()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
	local cg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not cg then return end
	local tc=cg:GetFirst()
	while tc do
		tc:CreateEffectRelation(te)
		tc=cg:GetNext()
	end--]]
	Duel.ClearTargetCard()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	e:SetLabel(te:GetLabel())
	e:SetLabelObject(te:GetLabelObject())
	local tg=te:GetTarget()
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	te:SetLabel(e:GetLabel())
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
end
function c66612323.cpop(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if e:GetHandler():IsRelateToEffect(e) and Duel.SendtoDeck(te:GetHandler(),nil,2,REASON_EFFECT)>0 then
		--[[local op=te:GetOperation()
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
		local cg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		if not cg then return end
		local tc=cg:GetFirst()
		while tc do
			tc:ReleaseEffectRelation(te)
			tc=cg:GetNext()
		end
	end--]]
	    e:SetLabel(te:GetLabel())
		e:SetLabelObject(te:GetLabelObject())
		local op=te:GetOperation()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end
		te:SetLabel(e:GetLabel())
		te:SetLabelObject(e:GetLabelObject())
		end
end
function c66612323.tgfilter2(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetControler()==tp and c:IsSetCard(0x666)
end
function c66612323.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c66612323.tgfilter,1,nil,tp)
end
function c66612323.thfilter(c)
	return ((c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER)) or c:IsCode(66619916)) and c:IsAbleToHand()
end
function c66612323.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612323.thfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c66612323.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.SelectMatchingCard(tp,c66612323.thfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil)
	if tg:GetCount()>0 then
	Duel.SendtoHand(tg,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,tg)
	end
end