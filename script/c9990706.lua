--ラクドスの祭り用品
function c9990706.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,9990706+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c9990706.cost)
	e1:SetTarget(c9990706.target)
	e1:SetOperation(c9990706.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(9990706,ACTIVITY_SPSUMMON,c9990706.counterfilter)
end
function c9990706.counterfilter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_PENDULUM)~=SUMMON_TYPE_PENDULUM
end
function c9990706.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(9990706,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(function(e,c,sump,sumtype,sumpos,targetp,se)
		return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
	end)
	Duel.RegisterEffect(e1,tp)
end
function c9990706.filter(c)
	return c:IsFacedown() and c:IsAbleToRemove() or c:IsFaceup() and aux.disfilter1(c)
end
function c9990706.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c9990706.filter,tp,LOCATION_ONFIELD,0,1,c)
		and Duel.IsExistingMatchingCard(c9990706.filter,tp,0,LOCATION_ONFIELD,1,c) end
end
function c9990706.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not (Duel.IsExistingMatchingCard(c9990706.filter,tp,LOCATION_ONFIELD,0,1,c)
		and Duel.IsExistingMatchingCard(c9990706.filter,tp,0,LOCATION_ONFIELD,1,c)) then return end
	local tc1=Duel.SelectMatchingCard(tp,c9990706.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c):GetFirst()
	local param1,param2=LOCATION_ONFIELD,0
	if tc1:IsControler(tp) then param1,param2=0,LOCATION_ONFIELD end
	local tc2=Duel.SelectMatchingCard(tp,c9990706.filter,tp,param1,param2,1,1,c):GetFirst()
	Duel.HintSelection(Group.FromCards(tc1,tc2))
	local dg,rg=Group.CreateGroup(),Group.CreateGroup()
	if tc1:IsFaceup() then dg:AddCard(tc1) else rg:AddCard(tc1) end
	if tc2:IsFaceup() then dg:AddCard(tc2) else rg:AddCard(tc2) end
	local tc=dg:GetFirst()
	while tc do
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
		tc=dg:GetNext()
	end
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
end