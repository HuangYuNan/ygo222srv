--Prim-旋律教条 ~Miserables~
require "expansions/script/c37564765"
function c37564605.initial_effect(c)
	senya.prl4(c,37564605)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCost(c37564605.cost)
	e1:SetCondition(c37564605.thcon)
	e1:SetTarget(c37564605.distg)
	e1:SetOperation(c37564605.disop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,37564605)
	e2:SetCost(senya.serlcost)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chk==0 then return eg:IsExists(c37564605.tfilter,1,e:GetHandler(),tp) end
		local g=eg:Filter(c37564605.tfilter,nil,tp)
		Duel.SetTargetCard(eg)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	end)
	e2:SetOperation(c37564605.op)
	c:RegisterEffect(e2)
end
function c37564605.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c37564605.cfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemoveAsCost()
end
function c37564605.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564605.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c37564605.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c37564605.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,800)
end
function c37564605.disop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c37564605.filter2(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsAbleToDeck() and c:GetSummonPlayer()==1-tp
end
function c37564605.tfilter(c,tp)
	return c:IsAbleToDeck() and c:GetSummonPlayer()==1-tp
end
function c37564605.op(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c37564605.filter2,nil,e,tp)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end