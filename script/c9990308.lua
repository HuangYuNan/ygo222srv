--ミラー・バリア・ドラゴン
function c9990308.initial_effect(c)
	c:EnableCounterPermit(0x16)
	--Synchro
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Disable Attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c9990308.atkop)
	c:RegisterEffect(e1)
	--Multipied Effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e2:SetCondition(c9990308.condition)
	e2:SetTarget(c9990308.target)
	e2:SetOperation(c9990308.operation)
	c:RegisterEffect(e2)
	--Avoid Destruction
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c9990308.reptg)
	c:RegisterEffect(e3)
end
function c9990308.atkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then e:GetHandler():AddCounter(0x16+COUNTER_NEED_ENABLE,2) end
end
function c9990308.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2) and e:GetHandler():GetFlagEffect(9990308)==0
end
function c9990308.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local v1,v2,v3=
		e:GetHandler():IsCanRemoveCounter(tp,0x16,1,REASON_COST) and Duel.CheckRemoveOverlayCard(tp,1,1,1,REASON_EFFECT),
		e:GetHandler():IsCanRemoveCounter(tp,0x16,2,REASON_COST),
		e:GetHandler():IsCanRemoveCounter(tp,0x16,3,REASON_COST) and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,0xc,1,nil)
	local v12,v13,v23,v123=v1 and v2,v1 and v3,v2 and v3,v1 and v2 and v3
	if chk==0 then return v1 or v2 or v3 end
	local v12,v13,v23,v123=v1 and v2,v1 and v3,v2 and v3,v1 and v2 and v3
	local sel=0
	if v123 then sel=Duel.SelectOption(tp,aux.Stringid(9990308,0),aux.Stringid(9990308,1),aux.Stringid(9990308,2))+1
	elseif v12 and not v3 then sel=Duel.SelectOption(tp,aux.Stringid(9990308,0),aux.Stringid(9990308,1))+1
	elseif v13 and not v2 then sel=Duel.SelectOption(tp,aux.Stringid(9990308,0),aux.Stringid(9990308,2))+1 if sel==2 then sel=3 end
	elseif v23 and not v1 then sel=Duel.SelectOption(tp,aux.Stringid(9990308,1),aux.Stringid(9990308,2))+2
	elseif v1 and not (v2 or v3) then sel=Duel.SelectOption(tp,aux.Stringid(9990308,0))+1
	elseif v2 and not (v1 or v3) then sel=Duel.SelectOption(tp,aux.Stringid(9990308,1))+2
	elseif v3 and not (v1 or v2) then sel=Duel.SelectOption(tp,aux.Stringid(9990308,2))+3 end
	if sel==2 then
		e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e:SetCategory(CATEGORY_DAMAGE)
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(1000)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
	elseif sel==3 then
		e:SetCategory(CATEGORY_DESTROY)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetMatchingGroup(Card.IsDestructable,tp,0,0xc,nil),1,0,0)
	end
	e:GetHandler():RemoveCounter(tp,0x16,sel,REASON_COST)
	e:SetLabel(sel)
	e:GetHandler():RegisterFlagEffect(9990308,RESET_CHAIN,0,1)
end
function c9990308.operation(e,tp,eg,ep,ev,re,r,rp)
	local sel=e:GetLabel()
	if sel==1 then
		local sg=Duel.GetMatchingGroup(Card.CheckRemoveOverlayCard,tp,0x4,0x4,nil,tp,1,REASON_EFFECT)
		if sg:GetCount()==0 then return elseif sg:GetCount()==1 then rg=sg else
			Duel.Hint(HINT_SELECTMSG,tp,532)
			rg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(rg)
		end
		rg:GetFirst():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	elseif sel==2 then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	elseif sel==3 then
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,0xc,nil)
		if sg:GetCount()~=0 then Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local rg=sg:Select(tp,1,1,nil) Duel.HintSelection(rg) Duel.Destroy(rg,REASON_EFFECT)
		end
	end
end
function c9990308.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x16,1,REASON_EFFECT) end
	e:GetHandler():RemoveCounter(tp,0x16,1,REASON_EFFECT)
	return true
end
