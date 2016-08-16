--イーフィックスの熄滅
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991430.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c9991430.condition)
	e1:SetTarget(c9991430.target)
	e1:SetOperation(c9991430.activate)
	c:RegisterEffect(e1)
end
c9991430.Dazz_name_Aephiex=true
function c9991430.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.IsChainNegatable(ev)
end
function c9991430.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local v={
		Duel.IsChainNegatable(ev)
			and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,c),
		Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1,
	}
	if chk==0 then return v[1] or v[2] end
	local selt={tp}
	local keyt={}
	for i=1,2 do
		if v[i] then
			table.insert(selt,aux.Stringid(9991430,i-1))
			table.insert(keyt,i)
		end
	end
	local sel=keyt[Duel.SelectOption(table.unpack(selt))+1]
	c:RegisterFlagEffect(1,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991430,sel-1))
	if sel==1 then
		Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	end
	e:SetLabel(sel)
end
function c9991430.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then
		Duel.NegateActivation(ev)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoDeck(g,tp,0,REASON_EFFECT)
	else
		local g=Duel.GetDecktopGroup(tp,2)
		if g:GetCount()==0 then return end
		Duel.ConfirmCards(tp,g)
		local sg=g:Filter(Dazz.IsAephiex,nil)
		if Duel.IsChainNegatable(ev) and sg:GetCount()~=0
			and Duel.SelectYesNo(tp,aux.Stringid(9991430,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,526)
			sg=sg:Select(tp,1,1,nil)
			Duel.ConfirmCards(1-tp,sg)
			g:Sub(sg)
			Duel.MoveSequence(sg:GetFirst(),1)
			Duel.NegateActivation(ev)
		end
		if g:GetCount()<=1 then return end
		Duel.SortDecktop(tp,tp,g:GetCount())
	end
end