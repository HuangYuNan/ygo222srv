--包罗万象·妖精之弓希尔文
function c60150411.initial_effect(c)
	--Activate
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_EQUIP+CATEGORY_COUNTER)
	e11:SetType(EFFECT_TYPE_ACTIVATE)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetTarget(c60150411.target)
	e11:SetOperation(c60150411.operation)
	c:RegisterEffect(e11)
	--Equip limit
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_EQUIP_LIMIT)
	e12:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e12:SetValue(c60150411.eqlimit)
	c:RegisterEffect(e12)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCountLimit(1)
	e4:SetCondition(c60150411.descon)
	e4:SetOperation(c60150411.desop)
	c:RegisterEffect(e4)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1,60150411)
	e3:SetCost(c60150411.cost)
	e3:SetTarget(c60150411.target2)
	e3:SetOperation(c60150411.activate2)
	c:RegisterEffect(e3)
end
function c60150411.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6b21) and c:GetEquipGroup():FilterCount(c60150411.filter2,nil)<3
end
function c60150411.filter2(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150411.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c60150411.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150411.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c60150411.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c60150411.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c60150411.eqlimit(e,c)
	return c:IsSetCard(0x6b21)
end
function c60150411.descon(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetHandler():GetEquipTarget()
	return tg and (Duel.GetAttacker()==tg or Duel.GetAttackTarget()==tg)
		and Duel.GetTurnPlayer()==tp
end
function c60150411.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=e:GetHandler():GetEquipTarget()
	local c=e:GetHandler()
	local e11=Effect.CreateEffect(e:GetHandler())
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_EXTRA_ATTACK)
	e11:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e11:SetValue(1)
	tc:RegisterEffect(e11)
	
end
function c60150411.dircon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end
function c60150411.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c60150411.filter4(c)
	return c:IsSetCard(0x6b21) and c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c60150411.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c60150411.filter4,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c60150411.filter4,tp,LOCATION_MZONE,0,1,1,nil)
end
function c60150411.activate2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(c60150411.efilter)
		tc:RegisterEffect(e2)
	end
end
function c60150411.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end