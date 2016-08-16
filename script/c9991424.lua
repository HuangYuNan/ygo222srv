--イーフィックスの神殿
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991424.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if not e:GetHandler():IsRelateToEffect(e) then return end
		local g=Duel.GetMatchingGroup(Dazz.IsAephiex,tp,LOCATION_DECK,0,nil)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(9991424,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(9991424,4))
			local tc=g:Select(tp,1,1,nil):GetFirst()
			Duel.ShuffleDeck(tp)
			Duel.MoveSequence(tc,0)
			Duel.ConfirmDecktop(tp,1)
		end
	end)
	c:RegisterEffect(e1)
	--Scry 1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9991424,4))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c9991424.dpcon)
	e2:SetTarget(c9991424.dptg)
	e2:SetOperation(c9991424.dpop)
	c:RegisterEffect(e2)
end
c9991424.Dazz_name_Aephiex=true
function c9991424.dpcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(function(c,tp) return c:GetSummonPlayer()==tp end,1,nil,tp)
end
function c9991424.dptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c9991424.dpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,1)
	local pe,tc=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_DECK),g:GetFirst()
	local confirm=(pe and tc:IsFaceup()) or (not pe and tc:IsFacedown())
	if confirm then
		Duel.ConfirmCards(tp,g)
	end
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==1 then return end
	local sel=3
	if Duel.SelectYesNo(tp,aux.Stringid(9991424,1)) then
		sel=2
		Duel.MoveSequence(g:GetFirst(),1)
	end
	if confirm then
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(9991424,sel))
	end
end