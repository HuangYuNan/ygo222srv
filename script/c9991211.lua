--神天竜－ダースト
require "expansions/script/c9990000"
function c9991211.initial_effect(c)
	Dazz.GodraExtraCommonEffect(c,19991211)
	--Fusion
	aux.AddFusionProcFun2(c,function(c) return Dazz.IsGodra(c,Card.GetFusionCode) end,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_EARTH),true)
	c:EnableReviveLimit()
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991211,1))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,29991211)
	e1:SetCondition(c9991211.discon)
	e1:SetTarget(c9991211.distg)
	e1:SetOperation(c9991211.disop)
	c:RegisterEffect(e1)
end
c9991211.Dazz_name_godra=true
function c9991211.discon(e,tp,eg,ep,ev,re,r,rp)
	local loc,np=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TRIGGERING_CONTROLER)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and bit.band(loc,0x0c)~=0 and np~=tp
end
function c9991211.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c9991211.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end