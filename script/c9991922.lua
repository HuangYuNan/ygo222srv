--末承者（インへリドゥーム）―ランクラース
require "expansions/script/c9990000"
function c9991922.initial_effect(c)
	Dazz.InheritorCommonEffect(c,1)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Fuck Spell & Trap
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c9991922.descon)
	e1:SetTarget(c9991922.destg)
	e1:SetOperation(c9991922.desop)
	c:RegisterEffect(e1)
	--Ignition
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c9991922.descost)
	e2:SetTarget(c9991922.destg)
	e2:SetOperation(c9991922.desop)
	c:RegisterEffect(e2)
end
c9991922.Dazz_name_inheritor=2
function c9991922.costfilter(c)
	return c:IsDiscardable() and Dazz.IsInheritor(c)
end
function c9991922.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9991922.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c9991922.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c9991922.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_EXTRA)
end
function c9991922.desfilter(c)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c9991922.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c9991922.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c9991922.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c9991922.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c9991922.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:IsHasType(EFFECT_TYPE_IGNITION) then
		if not e:GetHandler():IsRelateToEffect(e) then return end
	end
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	Duel.Destroy(tc,REASON_EFFECT)
end