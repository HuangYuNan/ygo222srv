--Crimson Beat
require "expansions/script/c37564765"
function c37564232.initial_effect(c)
	c:EnableReviveLimit()
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(0)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c37564232.spcon)
	e2:SetOperation(c37564232.spop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(function(e,c)
		return c:GetSummonLocation()==LOCATION_EXTRA
	end)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_SET_ATTACK_FINAL)
	e4:SetValue(0)
	c:RegisterEffect(e4)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564232,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(2)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,0x1e0)
	e3:SetTarget(c37564232.tg)
	e3:SetOperation(c37564232.op)
	c:RegisterEffect(e3)
end
function c37564232.spfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x773) and c:IsAbleToGraveAsCost()
end
function c37564232.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c37564232.spfilter,c:GetControler(),LOCATION_HAND,0,3,c) and senya.swwblex(e,c:GetControler())
end
function c37564232.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c37564232.spfilter,tp,LOCATION_HAND,0,3,3,c)
	Duel.SendtoGrave(g,REASON_COST)
end
function c37564232.filter(c)
	return c:IsAbleToGrave()
end
function c37564232.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if e:GetHandler():GetFlagEffect(60151298)>0 then
		if chk==0 then return true end
		Duel.SetChainLimit(aux.FALSE)
	else
		if chk==0 then return Duel.IsExistingMatchingCard(c37564232.filter,tp,0,LOCATION_ONFIELD,1,nil) end
		local g=Duel.GetMatchingGroup(c37564232.filter,tp,0,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
		Duel.SetChainLimit(aux.FALSE)
	end
end
function c37564232.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c37564232.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		if e:GetHandler():GetFlagEffect(60151298)>0 then
			Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(37564232,2))
			Duel.Hint(HINT_CARD,0,37564232)
			Duel.SendtoGrave(g,REASON_RULE)
		else
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
	end
end