--二人的恋人
function c5200044.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(5200044,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,5200044)
	e2:SetCondition(c5200044.drcon)
	e2:SetTarget(c5200044.drtg)
	e2:SetOperation(c5200044.drop)
	c:RegisterEffect(e2)
end
function c5200044.cfilter(c)
	return c:IsSetCard(0x361) and c:IsType(TYPE_MONSTER) and c:IsReason(REASON_EFFECT)
end
function c5200044.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c5200044.cfilter,1,nil)
end
function c5200044.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c5200044.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end