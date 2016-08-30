--仙境的蒸汽城堡
function c66619918.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetTarget(c66619918.target)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetLabelObject(e1)
	e2:SetCondition(c66619918.tgcon)
	e2:SetOperation(c66619918.tgop)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c66619918.tg)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetValue(aux.imval1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetValue(c66619918.val)
	c:RegisterEffect(e4)
	--code
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_CHANGE_CODE)
	e5:SetRange(LOCATION_ONFIELD+LOCATION_GRAVE)
	e5:SetValue(66619916)
	c:RegisterEffect(e5)
	--act in hand
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e6:SetCondition(c66619918.handcon)
	c:RegisterEffect(e6)
	--cannot tirgger
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_TRIGGER)
	e7:SetRange(LOCATION_SZONE)
	e7:SetTargetRange(LOCATION_MZONE,0)
	e7:SetTarget(c66619918.trtg)
	c:RegisterEffect(e7)
	--act in hand
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e8:SetCondition(c66619918.handcon1)
	c:RegisterEffect(e8)
end
function c66619918.cfilter(c)
	return c:IsCode(66619909) and c:IsFaceup()
end
function c66619918.handcon(e)
	local tp=e:GetHandlerPlayer()
	return  Duel.IsExistingMatchingCard(c66619918.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c66619918.handcon1(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer() and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c66619918.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x666)
end
function c66619918.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c66619918.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66619918.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c66619918.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c66619918.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return re==e:GetLabelObject()
end
function c66619918.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS):GetFirst()
	if c:IsRelateToEffect(re) and tc:IsFaceup() and tc:IsRelateToEffect(re) then
		c:SetCardTarget(tc)
	end
end
function c66619918.tg(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c66619918.val(e,re,rp)
	return aux.tgoval(e,re,rp) and re:IsActiveType(TYPE_MONSTER) 
end
function c66619918.trtg(e,c)
	return c:IsStatus(STATUS_SPSUMMON_TURN) and c:IsSetCard(0x666)
end