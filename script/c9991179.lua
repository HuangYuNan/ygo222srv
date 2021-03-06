--Titan's Presence
function c9991179.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9991179.target)
	e1:SetOperation(c9991179.activate)
	c:RegisterEffect(e1)
end
function c9991179.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)>1
		and Duel.IsExistingMatchingCard(function(c)
			return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_REPTILE)
		end,tp,LOCATION_EXTRA,0,1,nil)
		and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c9991179.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)>1 then
		local cg=Duel.GetMatchingGroup(function(c)
			return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_REPTILE)
		end,tp,LOCATION_EXTRA,0,nil)
		if cg:GetCount()==0 then
			local exg=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
			Duel.ConfirmCards(1-tp,exg)
			return
		end
		Duel.Hint(HINT_SELECTMSG,tp,526)
		cg=cg:Select(tp,1,1,nil)
		Duel.ConfirmCards(1-tp,cg)
		local tc=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e):GetFirst()
		if not tc then return end
		local val=cg:GetFirst():GetAttack()
		if tc:IsFacedown() or tc:IsAttackBelow(val) or tc:IsDefenseBelow(val) then
			if tc:IsAbleToRemove() then
				Duel.Remove(tc,POS_FACEUP,REASON_RULE)
			else
				Duel.SendtoGrave(tc,REASON_RULE)
			end
		end
	end
end