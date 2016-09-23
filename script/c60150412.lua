--奥丁·永恒之枪
function c60150412.initial_effect(c)
    c:EnableCounterPermit(0x1b)
	--Activate
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_EQUIP+CATEGORY_COUNTER)
	e11:SetType(EFFECT_TYPE_ACTIVATE)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetTarget(c60150412.target)
	e11:SetOperation(c60150412.operation)
	c:RegisterEffect(e11)
	--Equip limit
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_EQUIP_LIMIT)
	e12:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e12:SetValue(c60150412.eqlimit)
	c:RegisterEffect(e12)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1000)
	e2:SetCondition(c60150412.con)
	c:RegisterEffect(e2)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_DISABLE)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCondition(c60150412.descon)
	e4:SetOperation(c60150412.desop)
	c:RegisterEffect(e4)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCost(c60150412.thcost)
	e5:SetTarget(c60150412.thtg)
	e5:SetOperation(c60150412.thop)
	c:RegisterEffect(e5)
end
function c60150412.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6b21) and c:GetEquipGroup():FilterCount(c60150412.filter2,nil)<3
end
function c60150412.filter2(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150412.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c60150412.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150412.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c60150412.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c60150412.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		e:GetHandler():AddCounter(0x1b,3)
	end
end
function c60150412.eqlimit(e,c)
	return c:IsSetCard(0x6b21)
end
function c60150412.con(e)
	return e:GetHandler():GetCounter(0x1b)>0
end
function c60150412.descon(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetHandler():GetEquipTarget()
	return tg and (Duel.GetAttacker()==tg or Duel.GetAttackTarget()==tg) and tg:GetBattleTarget()~=nil
		and e:GetHandler():GetCounter(0x1b)>0
end
function c60150412.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=e:GetHandler():GetEquipTarget():GetBattleTarget()
	local tc2=e:GetHandler():GetEquipTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e2)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_ATTACK_FINAL)
	e3:SetValue(tc:GetBaseAttack())
	e3:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e3)
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e4:SetValue(tc:GetBaseDefence())
	e4:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e4)
	
	local e11=Effect.CreateEffect(e:GetHandler())
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_SET_ATTACK_FINAL)
	e11:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
	e11:SetValue(tc2:GetAttack())
	tc2:RegisterEffect(e11)
	e:GetHandler():RemoveCounter(tp,0x1b,1,REASON_EFFECT)
end
function c60150412.rctcon(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetHandler():GetEquipTarget()
	return tg:IsRelateToBattle() and e:GetHandler():GetCounter(0x1b)>0
end
function c60150412.rctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		c:RemoveCounter(tp,0x1b,1,REASON_EFFECT)
	end
end
function c60150412.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()~=Duel.GetTurnCount()
end
function c60150412.cfilter(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:IsAbleToRemoveAsCost()
end
function c60150412.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c60150412.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c60150412.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c60150412.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.SetChainLimit(aux.FALSE)
end
function c60150412.thfilter(c)
	return c:IsSetCard(0x6b21) and c:IsAbleToHand()
end
function c60150412.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60150412.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c60150412.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c60150412.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end