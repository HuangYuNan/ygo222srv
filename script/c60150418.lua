--耶梦加得之毒
function c60150418.initial_effect(c)
	--Activate
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_EQUIP+CATEGORY_COUNTER)
	e11:SetType(EFFECT_TYPE_ACTIVATE)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetTarget(c60150418.target)
	e11:SetOperation(c60150418.operation)
	c:RegisterEffect(e11)
	--Equip limit
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_EQUIP_LIMIT)
	e12:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e12:SetValue(c60150418.eqlimit)
	c:RegisterEffect(e12)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(500)
	e2:SetCondition(c60150418.con)
	c:RegisterEffect(e2)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCost(c60150418.thcost)
	e5:SetTarget(c60150418.thtg2)
	e5:SetOperation(c60150418.thop)
	c:RegisterEffect(e5)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCondition(c60150418.descon)
	e4:SetTarget(c60150418.destg)
	e4:SetOperation(c60150418.desop)
	c:RegisterEffect(e4)
end
function c60150418.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6b21) and c:GetEquipGroup():FilterCount(c60150418.filter2,nil)<3
end
function c60150418.filter2(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150418.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c60150418.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150418.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c60150418.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c60150418.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		e:GetHandler():AddCounter(0x1b,5)
	end
end
function c60150418.eqlimit(e,c)
	return c:IsSetCard(0x6b21)
end
function c60150418.con(e)
	return e:GetHandler():GetCounter(0x1b)>0
end
function c60150418.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()~=Duel.GetTurnCount()
end
function c60150418.cfilter(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:IsAbleToRemoveAsCost()
end
function c60150418.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c60150418.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c60150418.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c60150418.thfilter(c)
	return c:IsSetCard(0x6b21) and c:IsAbleToHand()
end
function c60150418.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60150418.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c60150418.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c60150418.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c60150418.descon(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetHandler():GetEquipTarget()
	return tg and (Duel.GetAttacker()==tg or Duel.GetAttackTarget()==tg) and tg:GetBattleTarget()~=nil
		and e:GetHandler():GetCounter(0x1b)>0
end
function c60150418.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=e:GetHandler():GetEquipTarget()
	local tc=e:GetHandler():GetEquipTarget():GetBattleTarget()
	if chk==0 then return tc and tc:IsFaceup() and (tc:GetDefence()<tg:GetAttack() or tc:GetAttack()<tg:GetAttack()) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c60150418.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND+LOCATION_DECK+LOCATION_EXTRA+LOCATION_MZONE)
	Duel.ConfirmCards(tp,g2)
	local code=e:GetHandler():GetEquipTarget():GetBattleTarget():GetCode()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_HAND+LOCATION_DECK+LOCATION_EXTRA+LOCATION_ONFIELD,nil,code)
	local dm=Duel.Destroy(g,REASON_EFFECT)
		  Duel.ShuffleHand(1-tp)  
		  Duel.ShuffleDeck(1-tp)
		if dm>0 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,dm*500,REASON_EFFECT)
		end
	local c=e:GetHandler()
	local tc=e:GetHandler():GetEquipTarget()
	
	local e11=Effect.CreateEffect(e:GetHandler())
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_SET_ATTACK_FINAL)
	e11:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
	e11:SetValue(tc:GetAttack())
	tc:RegisterEffect(e11)
	c:RemoveCounter(tp,0x1b,1,REASON_EFFECT)
end
