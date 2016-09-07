--ＳＷ（ステラライズ・ウォリアー）・レクター
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991001.initial_effect(c)
	Dazz.StellarisPendulumEffect(c)
	--Grave
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>3
			and Duel.IsPlayerCanDiscardDeck(tp,1) end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
		Duel.ConfirmDecktop(tp,4)
		if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
		local g=Duel.GetDecktopGroup(tp,4):Filter(c9991001.tgfilter,nil)
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			g=g:Select(tp,1,2,nil)
			Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
		end
	end)
	c:RegisterEffect(e1)
end
c9991001.Dazz_name_stellaris="Warrior"
function c9991001.tgfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToGrave()
end
