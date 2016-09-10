--骑士不死于徒手
function c60150431.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,60150431+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c60150431.condition)
	e1:SetTarget(c60150431.target)
	e1:SetOperation(c60150431.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c60150431.handcon)
	c:RegisterEffect(e2)
end
function c60150431.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6b21) and c:GetEquipGroup():FilterCount(c60150431.filter2,nil)==0
end
function c60150431.filter2(c)
	return c:IsType(TYPE_EQUIP)
end
function c60150431.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE
end
function c60150431.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c60150431.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150431.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c60150431.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c60150431.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		e1:SetValue(2450)
		e1:SetCondition(c60150431.handcon2)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		e2:SetCondition(c60150431.handcon2)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetValue(RESET_TURN_SET)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		e3:SetCondition(c60150431.handcon2)
		tc:RegisterEffect(e3)
	end
end
function c60150431.handcon(e)
	return Duel.GetMatchingGroupCount(c60150431.cfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,nil)==0
end
function c60150431.handcon2(e)
	local c=e:GetHandler()
	return c:GetEquipCount()==0
end
function c60150431.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EQUIP)
end