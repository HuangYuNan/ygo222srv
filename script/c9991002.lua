--ＳＷ（ステラライズ・ウォリアー）・ディーメン
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991002.initial_effect(c)
	Dazz.StellarisPendulumEffect(c)
	--Remove
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local fil=function(c) return c:IsDiscardable() and Dazz.IsStellaris(c,nil,"Warrior") end
		if chk==0 then return e:GetHandler():IsDiscardable()
			and Duel.IsExistingMatchingCard(fil,tp,LOCATION_HAND,0,1,e:GetHandler()) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local g=Duel.SelectMatchingCard(tp,fil,tp,LOCATION_HAND,0,1,1,e:GetHandler())
		g:AddCard(e:GetHandler())
		Duel.SendtoGrave(g,REASON_DISCARD+REASON_COST)
	end)
	e1:SetDescription(aux.Stringid(9991002,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetHintTiming(0,0x200043e)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(c9991002.rmfilter,tp,0,LOCATION_ONFIELD,1,nil) end
		local g=Duel.GetMatchingGroup(c9991002.rmfilter,tp,0,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetMatchingGroup(c9991002.rmfilter,tp,0,LOCATION_ONFIELD,nil)
		if g:GetCount()==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=g:Select(tp,1,2,nil)
		Duel.HintSelection(g)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end)
	c:RegisterEffect(e1)
end
c9991002.Dazz_name_stellaris="Warrior"
function c9991002.rmfilter(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
