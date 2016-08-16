--イーフィックスの統領 シャルム
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991410.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Dazz.IsAephiex),1)
	--Summon Success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9991410,2))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Dazz.IsAephiex,tp,LOCATION_DECK,0,1,nil)
			and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1 end
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(9991410,1))
		local g=Duel.SelectMatchingCard(tp,Dazz.IsAephiex,tp,LOCATION_DECK,0,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.ShuffleDeck(tp)
			Duel.MoveSequence(tc,0)
			Duel.ConfirmDecktop(tp,1)
		end
	end)
	c:RegisterEffect(e2)
	--Standby Phase
	local e3=e2:Clone()
	e3:SetDescription(aux.Stringid(9991410,3))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetTurnPlayer()==tp
	end)
	c:RegisterEffect(e3)
	--Infinity Counter
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCountLimit(1)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return ep~=tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
	end)
	e4:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	end)
	e4:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetDecktopGroup(tp,1)
		if g:GetCount()==0 then return end
		local pe,tc=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_DECK),g:GetFirst()
		local confirm=(pe and tc:IsFaceup()) or (not pe and tc:IsFacedown())
		if confirm then
			Duel.ConfirmCards(tp,g)
		end
		local typ=bit.band(tc:GetType(),TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
		if not Duel.IsChainNegatable(ev)
			or not Dazz.IsAephiex(tc) or not re:IsActiveType(typ)
			or not Duel.SelectYesNo(tp,aux.Stringid(9991410,0)) then
			return
		end
		if confirm then
			Duel.ConfirmCards(1-tp,g)
		end
		Duel.NegateActivation(ev)
		if re:GetHandler():IsRelateToEffect(re) then
			Duel.Destroy(eg,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e4)
end
c9991410.Dazz_name_Aephiex=true