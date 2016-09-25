function c73201010.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.synlimit)
	c:RegisterEffect(e1)
	--cannot release
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2SetCode(EFFECT_UNRELEASABLE_EFFECT)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(aux.tgval)
	c:RegisterEffect(e3)
	--actlimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,1)
	e4:SetValue(c73201010.aclimit)
	e4:SetCondition(c73201010.actcon)
	c:RegisterEffect(e4)
	--negate
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DISABLE+CATEGORY_REMOVE)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_CHAINING)
	e5:SetCountLimit(1)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c73201010.discon)
	e5:SetCost(c73201010.discost)
	e5:SetTarget(c73201010.distg)
	e5:SetOperation(c73201010.disop)
	c:RegisterEffect(e5)
end
function c73201010.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c73201010.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c73201010.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainDisablable(ev)
end
function c73201010.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost() end
	Duel.Remove(c,POS_FACEUP,REASON_COST)
	c:RegisterFlagEffect(73201010,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c73201010.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c73201010.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		local g1=g:Filter(Card.IsLocation,nil,LOCATION_HAND)
		local g2=g:Filter(Card.IsLocation,nil,LOCATION_GRAVE+LOCATION_ONFIELD)
		local rg=nil
		if g1:GetCount()~=0 and (g2:GetCount()==0 or Duel.SelectYesNo(tp,aux.Stringid(73201010,0))) then
			rg=g1:RandomSelect(tp,1)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			rg=g2:Select(tp,1,1,nil)
			Duel.HintSelection(rg)
		end
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if c:GetFlagEffect(73201010)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_REMOVED)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetCondition(c73201010.spcon)
		e1:SetOperation(c73201010.spop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1,true)
	end
end
function c73201010.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffect(73201010)~=0 and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
end
function c73201010.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,73201010)
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)
end
