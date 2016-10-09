--盒子镇
function c101169292.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c101169292.target)
	e1:SetOperation(c101169292.activate)
	c:RegisterEffect(e1)
end
function c101169292.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local v=math.floor(Duel.GetFieldGroup(e:GetOwnerPlayer(),LOCATION_HAND,0):GetCount()/3)*2
	if v<=0 then return end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,v) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,v)
end
function c101169292.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=math.floor(Duel.GetFieldGroup(e:GetOwnerPlayer(),LOCATION_HAND,0):GetCount()/3)*2
	if ct>0 then
		Duel.Draw(p,ct,REASON_EFFECT)
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetValue(c101169292.aclimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,p)
		--cannot set
		local e12=Effect.CreateEffect(e:GetHandler())
		e12:SetType(EFFECT_TYPE_FIELD)
		e12:SetCode(EFFECT_CANNOT_SSET)
		e12:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e12:SetTargetRange(1,0)
		e12:SetTarget(aux.TRUE)
		e12:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e12,p)
		local e13=Effect.CreateEffect(e:GetHandler())
		e13:SetType(EFFECT_TYPE_FIELD)
		e13:SetCode(EFFECT_CANNOT_MSET)
		e13:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e13:SetTargetRange(1,0)
		e13:SetTarget(aux.TRUE)
		e13:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e13,p)
	end
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetReset(RESET_PHASE+PHASE_END)
	e3:SetOperation(c101169292.tgop)
	Duel.RegisterEffect(e3,p)
end
function c101169292.aclimit(e,re,tp)
	return ((re:IsActiveType(TYPE_MONSTER) and not re:GetHandler():IsImmuneToEffect(e)) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and re:GetHandler():IsLocation(LOCATION_HAND)
end
function c101169292.tgop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetFieldGroup(e:GetOwnerPlayer(),LOCATION_HAND,0)
	if sg:GetCount()>0 then
		Duel.SendtoDeck(sg,nil,0,REASON_EFFECT)
		local og=Duel.GetOperatedGroup()
		local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_DECK)
		if ct==0 then return end
		Duel.SortDecktop(tp,tp,ct)
		for i=1,ct do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),1)
		end
	end
	Duel.SendtoDeck(sg,nil,1,REASON_EFFECT)
end