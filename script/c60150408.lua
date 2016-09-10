--绝对防御 布洛妮娅 扎伊切克
function c60150408.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c60150408.xyzfilter,4,2)
	c:EnableReviveLimit()
	--act limit
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_FIELD)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_CANNOT_ACTIVATE)
	e14:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e14:SetTargetRange(1,1)
	e14:SetCondition(c60150408.descon)
	e14:SetValue(c60150408.aclimit)
	c:RegisterEffect(e14)
	--tohand
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e15:SetCode(EVENT_ATTACK_ANNOUNCE)
	e15:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e15:SetCondition(c60150408.descon)
	e15:SetTarget(c60150408.target2)
	e15:SetOperation(c60150408.thop)
	c:RegisterEffect(e15)
	local e16=e15:Clone()
	e16:SetCode(EVENT_BE_BATTLE_TARGET)
	c:RegisterEffect(e16)
	--特招免疫
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c60150408.hspcon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCondition(c60150408.hspcon)
	e2:SetOperation(c60150408.sumsuc)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c60150408.thcon2)
	e3:SetTarget(c60150408.thtg2)
	e3:SetOperation(c60150408.thop2)
	c:RegisterEffect(e3)
	--cannot target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetValue(c60150408.tgvalue)
	c:RegisterEffect(e4)
	--免疫破坏
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	--cannot be target
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTargetRange(LOCATION_ONFIELD,0)
	e6:SetTarget(c60150408.target)
	e6:SetValue(c60150408.tgvalue)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e7:SetRange(LOCATION_MZONE)
	e7:SetTargetRange(LOCATION_ONFIELD,0)
	e7:SetTarget(c60150408.target)
	e7:SetValue(1)
	c:RegisterEffect(e7)
	--destroy replace
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_DESTROY_REPLACE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetTarget(c60150408.reptg)
	c:RegisterEffect(e8)
end
function c60150408.xyzfilter(c)
	return c:IsSetCard(0x6b21)
end
function c60150408.filter4(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150408.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipGroup():FilterCount(c60150408.filter4,nil)>0
end
function c60150408.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_EQUIP) and re:GetHandler():IsOnField()
		and re:GetHandler():IsSetCard(0x6b21) and re:GetHandler():GetEquipTarget()==e:GetHandler()
		and not re:GetHandler():IsImmuneToEffect(e)
end
function c60150408.spfilter(c,e,tp,ec)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:GetEquipTarget()==ec
end
function c60150408.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c60150408.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60150401,1))
	local g=Duel.SelectTarget(tp,c60150408.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,g,1,0,0)
end
function c60150408.thop(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c60150408.efilter)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end
function c60150408.efilter(e,re)
	return e:GetHandler()~=re:GetOwner()
end
function c60150408.cfilter(c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150408.chainlm(e,rp,tp)
	return tp==rp
end
function c60150408.hspcon(c,e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c60150408.cfilter,tp,LOCATION_GRAVE,0,3,nil)
end 
function c60150408.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetSummonType()~=SUMMON_TYPE_XYZ then return end
	if Duel.GetCurrentChain()==0 then
		Duel.SetChainLimitTillChainEnd(c60150408.chainlm)
	else
		e:GetHandler():RegisterFlagEffect(60150408,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c60150408.thcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c60150408.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_REMOVED+LOCATION_EXTRA,LOCATION_REMOVED+LOCATION_EXTRA,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_REMOVED+LOCATION_EXTRA,LOCATION_REMOVED+LOCATION_EXTRA,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c60150408.thop2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_REMOVED+LOCATION_EXTRA,LOCATION_REMOVED+LOCATION_EXTRA,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end
function c60150408.tgvalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c60150408.target(e,c)
	return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150408.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE) and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(60150408,1)) then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
