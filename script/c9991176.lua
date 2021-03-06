--Grave Birthing
require "expansions/script/c9990000"
function c9991176.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9991176.target)
	e1:SetOperation(c9991176.activate)
	c:RegisterEffect(e1)
end
function c9991176.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsAbleToRemove() and chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_GRAVE) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Dazz.IsCanCreateEldraziScion(tp)
		and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c9991176.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e):GetFirst()
	if not tc then return end
	if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)==0
			or not Dazz.IsCanCreateEldraziScion(tp) then return end
		local token=Dazz.CreateEldraziScion(e,tp)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
	if Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)>3 then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end