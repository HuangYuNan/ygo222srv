--萌王EX-照空之光·武则天
function c10981004.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10981004,1))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,10981004)
	e1:SetCost(c10981004.drcost)
	e1:SetTarget(c10981004.drtg)
	e1:SetOperation(c10981004.drop)
	c:RegisterEffect(e1)	  
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10981004,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,10981004)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c10981004.cost)
	e2:SetOperation(c10981004.operation)
	c:RegisterEffect(e2) 
end
function c10981004.cfilter(c)
	return c:IsSetCard(0x2236) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c10981004.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable()
		and Duel.IsExistingMatchingCard(c10981004.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c10981004.cfilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_DISCARD+REASON_COST)
end
function c10981004.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c10981004.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c10981004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,Card.IsSetCard,1,e:GetHandler(),0x2236) end
	local g=Duel.SelectReleaseGroupEx(tp,Card.IsSetCard,1,1,e:GetHandler(),0x2236)
	Duel.Release(g,REASON_COST)
end
function c10981004.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c10981004.atktg)
	e1:SetValue(1000)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c10981004.atktg(e,c)
	return c:IsSetCard(0x2236)
end
