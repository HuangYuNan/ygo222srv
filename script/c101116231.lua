--require("script.1011set")
function isFletcher(c)
	return c:GetCode()>101116230 and c:GetCode()<101116237
end
--弗莱彻

function c101116231.initial_effect(c)
	--xyz summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c101116231.XyzCondition)
	e1:SetOperation(c101116231.XyzOperation)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101116231,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c101116231.mttg)
	e1:SetOperation(c101116231.mtop)
	c:RegisterEffect(e1)
	---atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c101116231.effcon)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENCE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c101116231.effcon)
	c:RegisterEffect(e1)
	--to defence
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c101116231.poscon)
	e1:SetCost(c101116231.discost)
	e1:SetOperation(c101116231.posop)
	c:RegisterEffect(e1)
	--Inactivate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c101116231.discon)
	e2:SetCost(c101116231.discost)
	e2:SetTarget(c101116231.distg)
	e2:SetOperation(c101116231.disop)
	c:RegisterEffect(e2)
end
function c101116231.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and e:GetHandler():IsRelateToBattle()
end
function c101116231.posop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
--------------
function c101116231.mtfilter(c,e)
	return isFletcher(c) and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,c:GetCode())
end
function c101116231.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101116231.mtfilter,tp,LOCATION_HAND,0,1,nil,e) end
end
function c101116231.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c101116231.mtfilter,tp,LOCATION_HAND,0,1,1,nil,e)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
----
function c101116231.effcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()*700
end
----
function c101116231.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsContains(c) and Duel.IsChainNegatable(ev)
end
function c101116231.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c101116231.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c101116231.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
----------------
function c101116231.cfilter(c)
	return c:IsFaceup() and c:GetLevel()==2 and isFletcher(c) and Duel.IsExistingMatchingCard(c101116231.filter,0,LOCATION_MZONE,0,1,c,c:GetCode(),c:GetSequence())
end
function c101116231.filter(c,code,seq)
	return c:IsFaceup() and c:GetLevel()==2 and isFletcher(c) and c:IsCode(code) and c:GetSequence()>seq
end
function c101116231.lfilter(c)
	return c:IsFaceup() and c:GetLevel()==2 and isFletcher(c)
end
function c101116231.efilter(c,code1,code2,code3)
	return c:IsFaceup() and c:GetLevel()==2 and isFletcher(c) and not c:IsCode(code1) and not c:IsCode(code2) and not c:IsCode(code3)
end
function c101116231.XyzCondition(e,c)
		if c==nil then return true end
		local tp=c:GetControler()
		local mg1=Duel.GetMatchingGroup(c101116231.cfilter,tp,LOCATION_MZONE,0,nil)--满足2重复的(baoliuzuiyoubian)
		local mg2=Duel.GetMatchingGroup(c101116231.lfilter,tp,LOCATION_MZONE,0,nil)
		return mg2:GetCount()-mg1:GetCount()>=4
end
function c101116231.XyzOperation(e,tp,eg,ep,ev,re,r,rp,c)
		local g=Group.CreateGroup()
		local mg=Duel.GetMatchingGroup(c101116231.lfilter,tp,LOCATION_MZONE,0,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local t1=mg:FilterSelect(tp,c101116231.lfilter,1,1,nil)
		g:Merge(t1)
		local t2=mg:FilterSelect(tp,c101116231.efilter,1,1,nil,t1:GetFirst():GetCode(),-1,-1)
		g:Merge(t2)
		local t3=mg:FilterSelect(tp,c101116231.efilter,1,1,nil,t1:GetFirst():GetCode(),t2:GetFirst():GetCode(),-1)
		g:Merge(t3)
		local t4=mg:FilterSelect(tp,c101116231.efilter,1,1,nil,t1:GetFirst():GetCode(),t2:GetFirst():GetCode(),t3:GetFirst():GetCode())
		g:Merge(t4)
		c:SetMaterial(g)
		Duel.Overlay(c,g)
end