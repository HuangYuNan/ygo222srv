--Prim-旋律教条 ~Miserables~
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564605.initial_effect(c)
	senya.prl4(c,37564605)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
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
function c37564605.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemove()
end
function c37564605.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c37564605.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c37564605.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c37564605.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c37564605.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
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