--Conduit of Ruin
require "expansions/script/c9990000"
function c9991137.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,4,function(e,tp)
		local g=Duel.GetMatchingGroup(function(c)
			return c:IsLevelBelow(6) and c:IsRace(RACE_REPTILE) and c:IsAbleToHand()
		end,tp,LOCATION_DECK,0,nil)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(9991137,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_RULE)
			Duel.ConfirmCards(1-tp,sg)
		end
	end)
	--Special Effect
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ex:SetRange(LOCATION_MZONE)
	ex:SetCode(9991137)
	c:RegisterEffect(ex)
end
