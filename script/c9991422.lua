--イーフィックスの啓悟
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991422.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9991422.target)
	e1:SetOperation(c9991422.activate)
	c:RegisterEffect(e1)
end
c9991422.Dazz_name_Aephiex=true
function c9991422.filter(c)
	return c:IsAbleToDeck() and Dazz.IsAephiex(c)
end
function c9991422.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local v={
		Duel.IsExistingMatchingCard(c9991422.filter,tp,LOCATION_HAND,0,1,c),
		Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>3,
	}
	if chk==0 then return v[1] or v[2] end
	local selt={tp}
	local keyt={}
	for i=1,2 do
		if v[i] then
			table.insert(selt,aux.Stringid(9991422,i-1))
			table.insert(keyt,i)
		end
	end
	local sel=keyt[Duel.SelectOption(table.unpack(selt))+1]
	c:RegisterFlagEffect(1,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991422,sel-1))
	if sel==1 then
		e:SetCategory(CATEGORY_TODECK)
		local sg=Duel.GetMatchingGroup(c9991422.filter,tp,LOCATION_HAND,0,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,1,0,0)
	else
		e:SetCategory(0)
	end
	e:SetLabel(sel)
end
function c9991422.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	if e:GetLabel()==1 then
		local sg=Duel.GetMatchingGroup(c9991422.filter,tp,LOCATION_HAND,0,nil)
		if sg:GetCount()<0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,c9991422.filter,tp,LOCATION_HAND,0,1,1,nil)
		Duel.ConfirmCards(1-tp,g)
		Duel.SendtoDeck(g,tp,0,REASON_EFFECT)
		local val=Duel.GetTurnCount()
		if Duel.GetCurrentPhase()>=PHASE_STANDBY then
			val=val+1
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
			return Duel.GetTurnCount()==e:GetLabel()
		end)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			Duel.Hint(HINT_CARD,0,9991422)
			Duel.Draw(tp,2,REASON_EFFECT)
			e:Reset()
		end)
		e1:SetLabel(val)
		Duel.RegisterEffect(e1,tp)
	else
		Duel.Hint(HINT_SELECTMSG,tp,564)
		local code=Duel.AnnounceCard(tp)
		local g=Duel.GetDecktopGroup(tp,4)
		if g:GetCount()==0 then return end
		Duel.ConfirmCards(tp,g)
		local sg=g:Filter(function(c,code) return c:IsAbleToHand() and c:IsCode(code) end,nil,code)
		if sg:GetCount()~=0 and Duel.SelectYesNo(tp,aux.Stringid(9991422,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			sg=sg:Select(tp,1,1,nil)
			g:Sub(sg)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
		if g:GetCount()<=1 then return end
		Duel.SortDecktop(tp,tp,g:GetCount())
	end
end