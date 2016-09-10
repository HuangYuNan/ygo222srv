--索尔之锤
function c60150417.initial_effect(c)
	--Activate
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_EQUIP+CATEGORY_COUNTER)
	e11:SetType(EFFECT_TYPE_ACTIVATE)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetTarget(c60150417.target)
	e11:SetOperation(c60150417.operation)
	c:RegisterEffect(e11)
	--Equip limit
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_EQUIP_LIMIT)
	e12:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e12:SetValue(c60150417.eqlimit)
	c:RegisterEffect(e12)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1000)
	e2:SetCondition(c60150417.con)
	c:RegisterEffect(e2)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCost(c60150417.thcost)
	e5:SetTarget(c60150417.thtg)
	e5:SetOperation(c60150417.thop)
	c:RegisterEffect(e5)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCondition(c60150417.descon)
	e4:SetOperation(c60150417.desop)
	c:RegisterEffect(e4)
end
function c60150417.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6b21) and c:GetEquipGroup():FilterCount(c60150417.filter2,nil)<3
end
function c60150417.filter2(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150417.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c60150417.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150417.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c60150417.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c60150417.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		e:GetHandler():AddCounter(0x1b,2)
	end
end
function c60150417.eqlimit(e,c)
	return c:IsSetCard(0x6b21)
end
function c60150417.con(e)
	return e:GetHandler():GetCounter(0x1b)>0
end
function c60150417.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()~=Duel.GetTurnCount()
end
function c60150417.cfilter(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:IsAbleToRemoveAsCost()
end
function c60150417.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c60150417.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c60150417.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c60150417.thfilter(c)
	return c:IsSetCard(0x6b21) and c:IsAbleToHand()
end
function c60150417.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60150417.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c60150417.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c60150417.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c60150417.descon(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetHandler():GetEquipTarget()
	return tg and (Duel.GetAttacker()==tg or Duel.GetAttackTarget()==tg)
		and e:GetHandler():GetCounter(0x1b)>0
end
function c60150417.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=e:GetHandler():GetEquipTarget()
	local c=e:GetHandler()
	local e11=Effect.CreateEffect(e:GetHandler())
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_SET_ATTACK_FINAL)
	e11:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
	e11:SetValue(tc:GetAttack())
	tc:RegisterEffect(e11)
	local res=Duel.TossCoin(tp,1)
	if res==1 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(tc:GetAttack())
		tc:RegisterEffect(e1)
	end
		c:RemoveCounter(tp,0x1b,1,REASON_EFFECT)
end
function c60150417.thcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst()==e:GetHandler():GetEquipTarget() and ep~=tp 
		and eg:GetFirst():GetBattleTarget()==nil
end
function c60150417.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.BreakEffect()
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)/2)
end
function c60150417.rctcon(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetHandler():GetEquipTarget()
	return tg:IsRelateToBattle() and e:GetHandler():GetCounter(0x1b)>0
end
function c60150417.rctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		c:RemoveCounter(tp,0x1b,1,REASON_EFFECT)
	end
end