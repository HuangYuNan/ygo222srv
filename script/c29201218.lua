--幽邃教主教 达芙妮·虚饰
function c29201218.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(c29201218.ssfilter),1)
	c:EnableReviveLimit()
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetDescription(aux.Stringid(29201218,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(c29201218.drcon)
	e3:SetTarget(c29201218.drtg)
	e3:SetOperation(c29201218.drop)
	c:RegisterEffect(e3)
	--change effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29201218,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c29201218.chcon)
	e1:SetCost(c29201218.cost)
	e1:SetOperation(c29201218.chop)
	c:RegisterEffect(e1)
	--remove
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e5:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c29201218.rmcon)
	e5:SetTarget(c29201218.rmtarget)
	e5:SetTargetRange(0xff,0xff)
	e5:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e5)
end
function c29201218.ssfilter(c)
	return c:IsSetCard(0x63e1) and c:IsType(TYPE_SYNCHRO)
end
function c29201218.drcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttacker()==e:GetHandler()
end
function c29201218.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x63e1)
end
function c29201218.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c29201218.sfilter,tp,LOCATION_HAND,0,nil)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c29201218.drop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetMatchingGroupCount(c29201218.sfilter,tp,LOCATION_HAND,0,nil)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c29201218.chcon(e,tp,eg,ep,ev,re,r,rp)
	return not re:GetHandler():IsCode(29201218) and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
end
function c29201218.costfilter(c)
	return c:IsSetCard(0x63e1) and not c:IsPublic()
end
function c29201218.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29201218.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c29201218.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PUBLIC)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e2)
	Duel.ShuffleHand(tp)
end
function c29201218.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c29201218.repop)
end
function c29201218.repop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Recover(1-tp,800,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Damage(tp,800,REASON_EFFECT)
	end
end
function c29201218.rmcon(e)
	return Duel.IsExistingMatchingCard(c29201218.sfilter,e:GetHandlerPlayer(),LOCATION_HAND,0,1,nil)
end
function c29201218.rmtarget(e,c)
	return not c:IsSetCard(0x63e1)
end
