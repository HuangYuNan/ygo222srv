--ＳＷ（ステラライズ・ウォリアー）・イラスター
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991003.initial_effect(c)
	Dazz.StellarisPendulumEffect(c)
	--Search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(c9991003.thfilter,tp,LOCATION_DECK,0,1,nil)
			and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>3 end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
		Duel.ConfirmDecktop(tp,4)
		local g=Duel.GetDecktopGroup(tp,4):Filter(c9991003.thfilter,nil)
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			g=g:Select(tp,1,1,nil)
			if Duel.SendtoHand(g,nil,REASON_EFFECT)==0 then
				Duel.SendtoGrave(g,nil,REASON_RULE)
			else
				 Duel.ConfirmCards(1-tp,g)
			end
		end
	end)
	c:RegisterEffect(e1)
end
c9991003.Dazz_name_stellaris="Warrior"
function c9991003.thfilter(c)
	return Dazz.IsStellaris(c,nil,"Warrior") and c:IsAbleToHand()
end
