--Nanahira & 3L
local m=37564519
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function cm.initial_effect(c)
	senya.nnhr(c)
	senya.leff(c,m)
	senya.neg(c,1,m,senya.sermcost,senya.nncon(true),nil,LOCATION_GRAVE,false)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_ONFIELD+LOCATION_GRAVE)
	e5:SetCode(37564800)
	c:RegisterEffect(e5)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_HAND+LOCATION_ONFIELD)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCode(EVENT_BECOME_TARGET)
	e4:SetCountLimit(1,m)
	e4:SetCost(senya.serlcost)
	e4:SetCondition(cm.discon)
	e4:SetTarget(cm.distg)
	e4:SetOperation(cm.disop)
	c:RegisterEffect(e4)
end
function cm.effect_operation_3L(c,ec,chk)
	local e1=Effect.CreateEffect(ec)
	e1:SetDescription(aux.Stringid(m,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(cm.target1)
	e1:SetOperation(cm.operation1)
	e1:SetReset(senya.lres(chk))
	c:RegisterEffect(e1,true)
end
function cm.discon(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp then return end
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not tg then return false end
	return Duel.IsChainNegatable(ev) and tg:IsExists(cm.f,1,nil,tp)
end
function cm.f(c,tp)
	return (c:IsCode(37564765) or c:IsHasEffect(37564800)) and c:IsLocation(LOCATION_ONFIELD) and c:IsControler(tp) and c:IsFaceup()
end
function cm.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function cm.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
function cm.cfilter(c,e)
	local cd=c:GetOriginalCode()
	local mt=_G["c"..cd]
	return c:IsHasEffect(37564800) and c:IsType(TYPE_MONSTER) and mt and mt.effect_operation_3L and not c:IsPublic() and cd~=37564519 and e:GetHandler():GetFlagEffect(cd-4000)==0
end
function cm.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.cfilter,tp,LOCATION_HAND,0,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,cm.cfilter,tp,LOCATION_HAND,0,1,1,nil,e)
	Duel.ConfirmCards(1-tp,g)
	Duel.SetTargetParam(g:GetFirst():GetOriginalCode())
	Duel.ShuffleHand(tp)
end
function cm.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local cd=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local mt=_G["c"..cd]
	if not mt or c:GetFlagEffect(cd-4000)>0 or not mt.effect_operation_3L then return end
	mt.effect_operation_3L(c,c,true)
	c:RegisterFlagEffect(cd-4000,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,2,0,cd*16+1)
end