--Archangel Avacyn
require "expansions/script/c9990000"
function c9990325.initial_effect(c)
	Dazz.DFCFrontsideCommonEffect(c)
	--Synchro
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	--Synchro from Extra
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCountLimit(1,9990325)
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
	--Indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local ex1=Effect.CreateEffect(e:GetHandler())
		ex1:SetType(EFFECT_TYPE_FIELD)
		ex1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		ex1:SetTargetRange(LOCATION_MZONE,0)
		ex1:SetValue(1)
		ex1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(ex1,tp)
		local ex2=ex1:Clone()
		ex2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		Duel.RegisterEffect(ex2,tp)
	end)
	c:RegisterEffect(e2)
	--Non-Angel To Grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(9990325,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg:IsExists(function(c,tp)
			return bit.band(c:GetPreviousRaceOnField(),RACE_FAIRY)==0
				and c:GetReasonPlayer()~=tp and c:GetPreviousControler()==tp
				and c:IsPreviousLocation(LOCATION_MZONE)
		end,1,nil,tp)
	end)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if c:GetOriginalCode()~=9990325 then return end
		if not c:IsRelateToEffect(e) or c:GetFlagEffect(9990325)>0 then return end
		c:RegisterFlagEffect(9990325,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,
			EFFECT_FLAG_CLIENT_HINT,2,0,aux.Stringid(9990325,1))
		if Duel.GetCurrentPhase()==PHASE_STANDBY then
			c:RegisterFlagEffect(9990325,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY,0,1)
		end
		local ex1=Effect.CreateEffect(c)
		ex1:SetDescription(aux.Stringid(9990325,1))
		ex1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ex1:SetCode(EVENT_PHASE_START+PHASE_STANDBY)
		ex1:SetRange(LOCATION_MZONE)
		ex1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
		ex1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local c=e:GetHandler()
			if c:GetFlagEffect(9990325)~=1 then return end
			Duel.Hint(HINT_CARD,0,9990325)
			if Dazz.DFCTransformable(c,tp) then
				local token=Dazz.DFCTransformExecute(c,true)
				Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
			end
		end)
		c:RegisterEffect(ex1)
	end)
	c:RegisterEffect(e3)
end