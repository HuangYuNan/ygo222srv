--扑克魔术的狂欢节
function c66612311.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,66612311)
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsSetCard,0x660),c66612311.ffilter,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c66612311.sprcon)
	e1:SetOperation(c66612311.sprop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66612311,2))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c66612311.starget)
	e2:SetOperation(c66612311.activate)
	c:RegisterEffect(e2)
	--limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(c66612311.splimit)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetValue(c66612311.efilter)
	c:RegisterEffect(e4)
end
function c66612311.ffilter(c)
	return c:IsLevelAbove(9)
end
function c66612311.splimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0xe660)
end
function c66612311.spfilter1(c,tp,fc)
	return c:IsSetCard(0x660)  and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c66612311.spfilter2,tp,LOCATION_MZONE,0,1,c,fc)
end
function c66612311.spfilter2(c,fc)
	return c:IsLevelAbove(9)   and  c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function c66612311.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c66612311.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp,c)
end
function c66612311.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612311,0))
	local g1=Duel.SelectMatchingCard(tp,c66612311.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612311,1))
	local g2=Duel.SelectMatchingCard(tp,c66612311.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c66612311.filter(c)
	return c:IsFaceup() and not (c:GetAttack()==0 and c:IsDisabled())
end
function c66612311.starget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c66612311.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66612311.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c66612311.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c66612311.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetValue(RESET_TURN_SET)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e4)
		end
	end
end
function c66612311.efilter(e,re,tp)
	return tp~=e:GetHandlerPlayer() and re:IsActiveType(TYPE_MONSTER)
end