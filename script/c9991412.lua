--イーフィックスの天使 ナターシャ
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991412.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Dazz.IsAephiex),1)
	--Summon Success
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_ONFIELD,0,nil)
		Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ct*1000)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_ONFIELD,0,nil)
		Duel.Recover(tp,ct*1000,REASON_EFFECT)
	end)
	c:RegisterEffect(e1)
	--Exile Card
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,0x1c0)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
		if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetDecktopGroup(tp,1)
		if g:GetCount()==0 then return end
		local pe,tc=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_DECK),g:GetFirst()
		local confirm=(pe and tc:IsFaceup()) or (not pe and tc:IsFacedown())
		if confirm then
			Duel.ConfirmCards(tp,g)
		end
		local tc1=Duel.GetFirstTarget()
		if not tc1:IsRelateToEffect(e) or not tc1:IsAbleToRemove()
			or not Dazz.IsAephiex(tc) or not Duel.SelectYesNo(tp,aux.Stringid(9991412,0)) then
			return
		end
		if confirm then
			Duel.ConfirmCards(1-tp,g)
		end
		Duel.Remove(tc1,POS_FACEUP,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
end
c9991412.Dazz_name_Aephiex=true