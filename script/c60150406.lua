--绝对武装 琪亚娜 卡斯兰娜
function c60150406.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c60150406.xyzfilter,4,2)
	c:EnableReviveLimit()
	--act limit
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_FIELD)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_CANNOT_ACTIVATE)
	e14:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e14:SetTargetRange(1,1)
	e14:SetCondition(c60150406.descon)
	e14:SetValue(c60150406.aclimit)
	c:RegisterEffect(e14)
	--tohand
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e15:SetCode(EVENT_ATTACK_ANNOUNCE)
	e15:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e15:SetCondition(c60150406.descon)
	e15:SetTarget(c60150406.target2)
	e15:SetOperation(c60150406.thop)
	c:RegisterEffect(e15)
	local e16=e15:Clone()
	e16:SetCode(EVENT_BE_BATTLE_TARGET)
	c:RegisterEffect(e16)
	--特招免疫
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c60150406.hspcon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCondition(c60150406.hspcon)
	e2:SetOperation(c60150406.sumsuc)
	c:RegisterEffect(e2)
	--eq
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCondition(c60150406.descon2)
	e3:SetTarget(c60150406.destg2)
	e3:SetOperation(c60150406.desop2)
	c:RegisterEffect(e3)
	--atk def
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SET_BASE_ATTACK)
	e4:SetCondition(c60150406.descon)
	e4:SetValue(c60150406.value)
	c:RegisterEffect(e4)
	--eq
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_EQUIP)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e5:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
	e5:SetCountLimit(1)
	e5:SetCost(c60150406.descost3)
	e5:SetTarget(c60150406.destg3)
	e5:SetOperation(c60150406.desop3)
	c:RegisterEffect(e5)
end
function c60150406.xyzfilter(c)
	return c:IsSetCard(0x6b21)
end
function c60150406.filter4(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150406.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipGroup():FilterCount(c60150406.filter4,nil)>0
end
function c60150406.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_EQUIP) and re:GetHandler():IsOnField()
		and re:GetHandler():IsSetCard(0x6b21) and re:GetHandler():GetEquipTarget()==e:GetHandler()
		and not re:GetHandler():IsImmuneToEffect(e)
end
function c60150406.spfilter(c,e,tp,ec)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:GetEquipTarget()==ec
end
function c60150406.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c60150406.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60150401,1))
	local g=Duel.SelectTarget(tp,c60150406.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,g,1,0,0)
end
function c60150406.thop(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c60150406.efilter)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end
function c60150406.efilter(e,re)
	return e:GetHandler()~=re:GetOwner()
end
function c60150406.cfilter(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150406.chainlm(e,rp,tp)
	return tp==rp
end
function c60150406.hspcon(c,e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c60150406.cfilter,tp,LOCATION_GRAVE,0,3,nil)
end 
function c60150406.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetSummonType()~=SUMMON_TYPE_XYZ then return end
	if Duel.GetCurrentChain()==0 then
		Duel.SetChainLimitTillChainEnd(c60150406.chainlm)
	else
		e:GetHandler():RegisterFlagEffect(60150406,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c60150406.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c60150406.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60150406.filter,tp,LOCATION_DECK,0,1,nil,e,tp,e:GetHandler()) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	local g=Duel.GetMatchingGroup(c60150406.filter,tp,LOCATION_DECK,0,nil,e,tp,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c60150406.rmfilter(c)
	return c:IsAbleToRemove()
end
function c60150406.desop3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60150406,0))
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c60150406.filter,tp,LOCATION_DECK,0,1,1,nil)
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local tc=g:GetFirst()
	if Duel.Equip(tp,tc,c,true,true)~=0 then
		if tc:IsCode(60150418) then
			tc:AddCounter(0x1b,5)
		end
		if tc:IsCode(60150412) then
			tc:AddCounter(0x1b,3)
		end
		if tc:IsCode(60150413) or tc:IsCode(60150417) or tc:IsCode(60150420) then
			tc:AddCounter(0x1b,2)
		end
		if tc:IsCode(60150414) or tc:IsCode(60150415) or tc:IsCode(60150419) or tc:IsCode(60150421) then
			tc:AddCounter(0x1b,1)
		end
		Duel.EquipComplete()
		if Duel.SelectYesNo(tp,aux.Stringid(60150406,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local g2=Duel.SelectMatchingCard(tp,c60150406.rmfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
			if g2:GetCount()>0 then
				Duel.HintSelection(g2)
				Duel.Remove(g2,POS_FACEUP,REASON_EFFECT)
			end
		end
	end
end
function c60150406.value(e,c)
	return c:GetEquipGroup():FilterCount(c60150406.filter4,nil)*300
end
function c60150406.filter(c,e,tp,ec)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150406.pfilter(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150406.filter2(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:IsAbleToGraveAsCost()
end
function c60150406.descost3(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetEquipGroup():IsExists(c60150406.filter2,1,nil) 
		and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=c:GetEquipGroup():FilterSelect(tp,c60150406.filter2,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c60150406.destg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60150406.filter,tp,LOCATION_DECK,0,1,nil,e,tp,e:GetHandler()) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	local g=Duel.GetMatchingGroup(c60150406.filter,tp,LOCATION_DECK,0,nil,e,tp,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c60150406.desop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60150406,0))
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c60150406.filter,tp,LOCATION_DECK,0,1,3,nil)
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local tc=g:GetFirst()
	while tc do
		Duel.Equip(tp,tc,c,true,true)
		if tc:IsCode(60150418) then
			tc:AddCounter(0x1b,5)
		end
		if tc:IsCode(60150412) then
			tc:AddCounter(0x1b,3)
		end
		if tc:IsCode(60150413) or tc:IsCode(60150417) or tc:IsCode(60150420) then
			tc:AddCounter(0x1b,2)
		end
		if tc:IsCode(60150414) or tc:IsCode(60150415) or tc:IsCode(60150419) or tc:IsCode(60150421) then
			tc:AddCounter(0x1b,1)
		end
		tc=g:GetNext()
	end
	Duel.EquipComplete()
end