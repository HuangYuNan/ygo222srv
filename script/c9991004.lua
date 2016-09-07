--ＳＷ（ステラライズ・ウォリアー）・オラクル
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991004.initial_effect(c)
	Dazz.StellarisPendulumEffect(c)
	--Draw
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
	e1:SetDescription(aux.Stringid(9991004,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetHintTiming(0,0x200043e)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(2)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Draw(p,d,REASON_EFFECT)
	end)
	c:RegisterEffect(e1)
end
c9991004.Dazz_name_stellaris="Warrior"
