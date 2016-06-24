--AIW·皇后的仆从
function c66619905.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c66619905.spcon)
	c:RegisterEffect(e1)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(66619904,0))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BE_MATERIAL)
	e4:SetCondition(c66619905.con)
	e4:SetOperation(c66619905.thop)
	c:RegisterEffect(e4)
	--effect gain
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_BE_MATERIAL)
	e5:SetCondition(c66619905.effcon)
	e5:SetOperation(c66619905.effop)
	c:RegisterEffect(e5)
	--tohand
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DRAW)
	e6:SetDescription(aux.Stringid(66619903,0))
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_GRAVE)
	e6:SetCost(c66619905.cost)
	e6:SetTarget(c66619905.tg)
	e6:SetOperation(c66619905.op)
	c:RegisterEffect(e6)
end
function c66619905.filter(c)
	return c:IsFaceup() and c:IsCode(66619916)
end
function c66619905.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c66619905.filter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
function c66619905.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO 
end
function c66619905.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	if not rc:IsSetCard(0x666) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	rc:RegisterEffect(e1)
end
function c66619905.effcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ and re:GetHandler():IsSetCard(0x666)
end
function c66619905.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_TYPE)
		e2:SetValue(TYPE_MONSTER+TYPE_EFFECT+TYPE_XYZ)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		rc:RegisterEffect(e2)
	end
end
function c66619905.filter1(c)
	return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER) and c:IsRace(RACE_BEASTWARRIOR) and c:IsAbleToDeckAsCost()
end
function c66619905.filter2(c)
	return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER) and c:IsRace(RACE_FAIRY) and c:IsAbleToDeckAsCost()
end
function c66619905.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost()
		and Duel.IsExistingMatchingCard(c66619905.filter1,tp,LOCATION_GRAVE,0,1,e:GetHandler()) and Duel.IsExistingMatchingCard(c66619905.filter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,c66619905.filter1,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	local g2=Duel.SelectMatchingCard(tp,c66619905.filter2,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g1:Merge(g2)
	g1:AddCard(e:GetHandler())
	Duel.SendtoDeck(g1,nil,2,REASON_COST)
end
function c66619905.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c66619905.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end