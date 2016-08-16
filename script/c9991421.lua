--イーフィックスの閃撃
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991421.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
	e1:SetTarget(c9991421.target)
	e1:SetOperation(c9991421.activate)
	c:RegisterEffect(e1)
end
c9991421.Dazz_name_Aephiex=true
function c9991421.filter(c)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c9991421.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and c9991421.filter(chkc) and chkc~=c end
	local v={
		Duel.IsExistingTarget(c9991421.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
			and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,c),
		Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>3,
	}
	if chk==0 then return v[1] or v[2] end
	local selt={tp}
	local keyt={}
	for i=1,2 do
		if v[i] then
			table.insert(selt,aux.Stringid(9991421,i-1))
			table.insert(keyt,i)
		end
	end
	local sel=keyt[Duel.SelectOption(table.unpack(selt))+1]
	c:RegisterFlagEffect(1,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991421,sel-1))
	if sel==1 then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,c9991421.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	else
		e:SetProperty(0)
	end
	e:SetLabel(sel)
end
function c9991421.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
			local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
			Duel.SendtoDeck(g,tp,0,REASON_EFFECT)
		end
	else
		local g=Duel.GetDecktopGroup(tp,4)
		if g:GetCount()==0 then return end
		Duel.ConfirmCards(tp,g)
		local sg=g:Filter(function(c) return Dazz.IsAephiex(c) and c:IsType(TYPE_SPELL+TYPE_TRAP) end,nil)
		local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		if sg:GetCount()~=0 and dg:GetCount()~=0 and Duel.SelectYesNo(tp,aux.Stringid(9991421,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,526)
			sg=sg:Select(tp,1,1,nil)
			Duel.ConfirmCards(1-tp,sg)
			g:Sub(sg)
			Duel.MoveSequence(sg:GetFirst(),1)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			dg=dg:Select(tp,1,1,nil)
			Duel.HintSelection(dg)
			if Duel.Destroy(dg,REASON_EFFECT)~=0 then
				Duel.Damage(1-tp,1000,REASON_EFFECT)
			end
		end
		if g:GetCount()<=1 then return end
		Duel.SortDecktop(tp,tp,g:GetCount())
	end
end