--神天竜－クラウド
require "expansions/script/c9990000"
function c9991215.initial_effect(c)
	Dazz.GodraExtraCommonEffect(c,19991215)
	--Fusion
	aux.AddFusionProcFun2(c,function(c) return Dazz.IsGodra(c,Card.GetFusionCode) end,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WIND),true)
	c:EnableReviveLimit()
	--To Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991215,1))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,29991215)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c9991215.ccost)
	e1:SetTarget(c9991215.ctg)
	e1:SetOperation(c9991215.cop)
	c:RegisterEffect(e1)
end
c9991215.Dazz_name_godra=true
function c9991215.WyrmGraveCostFilter(c)
	return c:IsRace(RACE_WYRM) and c:IsAbleToGraveAsCost()
end
function c9991215.ccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9991215.WyrmGraveCostFilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c9991215.WyrmGraveCostFilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c9991215.ctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,1,0,0)
end
function c9991215.cop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
