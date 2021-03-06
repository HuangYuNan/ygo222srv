--帰って来た将軍－楊再興（ヤンザイシン）
function c9990317.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	--Synchro from Extra
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCountLimit(1,19990317)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetHintTiming(0,0x102e)
	e1:SetCondition(function(e,tp)
		return Duel.GetTurnPlayer()~=tp
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local c=e:GetHandler()
		if chk==0 then return c:IsSynchroSummonable(nil) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) then return end
		Duel.SynchroSummon(tp,c,nil)
	end)
	c:RegisterEffect(e1)
	--Synchro from Graveyard
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCountLimit(1,29990317)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp,chk)
		return eg:FilterCount(function(c,tp)
			return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
		end,nil,tp)==1 and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,true) and
			Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,SUMMON_TYPE_SYNCHRO,tp,tp,true,true,POS_FACEUP)~=0 then
			c:CompleteProcedure()
		end
	end)
	c:RegisterEffect(e2)
end
