require 'expansions.script.c2150000'
function c2150009.initial_effect(c)
	aux.EnablePendulumAttribute(c)	
	
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_SINGLE)
	a:SetCode(EFFECT_UPDATE_LSCALE)
	a:SetRange(LOCATION_PZONE)
	a:SetValue(c2150009.va)
	c:RegisterEffect(a)

	a=a:Clone()
	a:SetCode(EFFECT_UPDATE_RSCALE)
	c:RegisterEffect(a)

	a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD)
	a:SetCode(EFFECT_SPSUMMON_PROC)
	a:SetRange(LOCATION_PZONE)
	a:SetCondition(c2150009.cnc)
	a:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	a:SetTargetRange(POS_FACEUP_DEFENSE,0)
	c:RegisterEffect(a)

	a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_QUICK_O)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetRange(LOCATION_PZONE)
	a:SetProperty(EFFECT_FLAG_CARD_TARGET)
	a:SetCategory(CATEGORY_DESTROY)
	a:SetCost(c2150009.cod)
	a:SetTarget(c2150009.tgd)
	a:SetOperation(c2150009.opd)
	c:RegisterEffect(a)

	a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_QUICK_O)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetCountLimit(1,2150009)
	a:SetCategory(CATEGORY_SPECIAL_SUMMON)
	a:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	a:SetCost(c2150009.coe)
	a:SetDescription(1109)
	a:SetOperation(BiDiuOpb)
	c:RegisterEffect(a)
end
function c2150009.coe(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return not(Duel.GetFieldCard(tp,LOCATION_SZONE,7) and Duel.GetFieldCard(tp,LOCATION_SZONE,6))and Duel.IsExistingMatchingCard(BiDiuF,tp,LOCATION_MZONE,0,1,nil)and Duel.IsExistingMatchingCard(BiDiuSs,tp,LOCATION_DECK,0,1,nil,e,tp)end
        Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
        Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c2150009.va(e)return Duel.GetMatchingGroupCount(BiDiuUp,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,nil)end
function c2150009.cnc(e)return e:GetHandler():GetLeftScale()>3 end
function c2150009.cod(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetLeftScale()>3 end
	local c=e:GetHandler()
	local a=Effect.CreateEffect(c)
	a:SetCode(EFFECT_UPDATE_LSCALE)
	a:SetType(EFFECT_TYPE_SINGLE)
	a:SetRange(LOCATION_PZONE)
	a:SetReset(RESET_EVENT+RESET_LEAVE)
	a:SetValue(-3)
	c:RegisterEffect(a)

	a=a:Clone()
	a:SetCode(EFFECT_UPDATE_RSCALE)
	c:RegisterEffect(a)
end
function c2150009.tgd(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD)end
	if chk==0 then return Duel.IsExistingTarget(nil,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)end
	local t=Duel.SelectTarget(tp,nil,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,t,1,0,0)
end
function c2150009.opd(e)
	local t=Duel.GetFirstTarget()
	if not t:IsRelateToEffect(e)or not e:GetHandler():IsRelateToEffect(e)then return end
	Duel.Destroy(t,REASON_EFFECT)
end
