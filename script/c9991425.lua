--アンセスチャル・リコール
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991425.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetCountLimit(1,9991425+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c9991425.target)
	e1:SetOperation(c9991425.activate)
	c:RegisterEffect(e1)
end
function c9991425.filter(c)
	return (c:IsFaceup() or c:IsPublic()) and Dazz.IsAephiex(c)
end
function c9991425.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3)
		and Duel.IsExistingMatchingCard(Dazz.IsAephiex,tp,LOCATION_HAND+LOCATION_ONFIELD,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c9991425.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Dazz.IsAephiex,tp,LOCATION_HAND+LOCATION_ONFIELD,0,nil)
	if g:GetCount()<3 then
		g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_ONFIELD,0,nil)
		local g2=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		g:Merge(g2)
		if g:GetCount()>0 then
			Duel.ConfirmCards(1-tp,g)
			if g:FilterCount(Card.IsLocation,nil,LOCATION_HAND)>0 then
				Duel.ShuffleHand(tp)
			end
		end
		return
	end
	local sg=Duel.GetMatchingGroup(c9991425.filter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,nil)
	g:Sub(sg)
	local v=math.max(3-sg:GetCount(),0)
	if g:GetCount()~=0 and (v~=0 or Duel.SelectYesNo(tp,aux.Stringid(9991425,0))) then
		Duel.Hint(HINT_SELECTMSG,tp,526)
		g=g:Select(tp,v,3,nil)
		sg:RandomSelect(tp,g:GetCount()-3)
		Duel.ConfirmCards(1-tp,g)
		if g:FilterCount(Card.IsLocation,nil,LOCATION_HAND)>0 then
			Duel.ShuffleHand(tp)
		end
	else
		sg:RandomSelect(tp,3)
	end
	Duel.Draw(tp,3,REASON_EFFECT)
end