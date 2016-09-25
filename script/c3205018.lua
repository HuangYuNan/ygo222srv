--¿âÂåË¹
function c3205018.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x340),aux.NonTuner(Card.IsSetCard,0x340),2)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,3205018)
	--spsummon limit
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.synlimit)
	c:RegisterEffect(e0)  
	--NTR
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_CONTROL)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e6:SetCountLimit(1)
	e6:SetTarget(c3205018.target1)
	e6:SetOperation(c3205018.operation1)
	c:RegisterEffect(e6)
	--negate
	local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetCode(EVENT_CHAINING)
	e7:SetCountLimit(1)
	e7:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c3205018.discon)
	e7:SetTarget(c3205018.distg)
	e7:SetOperation(c3205018.disop)
	c:RegisterEffect(e7) 
	--cannot select battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(c3205018.atlimit)
	c:RegisterEffect(e1)
end
  function c3205018.filter1(c)
	return c:IsControlerCanBeChanged()
end
function c3205018.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c3205018.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c3205018.filter1,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c3205018.filter1,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c3205018.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_CONTROL)
		e1:SetValue(tp)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		tc:RegisterEffect(e1)
	end
end
function c3205018.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c3205018.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c3205018.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c3205018.atlimit(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsSetCard(0x340) and not c:IsCode(3205018)
end
