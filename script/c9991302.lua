--Terrestrial Pneuma
require "expansions/script/c9990000"
function c9991302.initial_effect(c)
	Dazz.PneumaCommonEffect(c,9991302)
	--SP Success
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
		local sg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,1,0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e1)
end
function c9991302.Pneuma_Bonus_Effect(oc,tc)
	local s1=Effect.CreateEffect(oc)
	s1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	s1:SetCode(EVENT_CHAINING)
	s1:SetRange(LOCATION_MZONE)
	s1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return ep~=tp
	end)
	s1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if re:IsActiveType(TYPE_MONSTER) then c:RegisterFlagEffect(19991302,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,
			EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991302,1)) end
		if re:IsActiveType(TYPE_SPELL) then c:RegisterFlagEffect(29991302,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,
			EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991302,2)) end
		if re:IsActiveType(TYPE_TRAP) then c:RegisterFlagEffect(39991302,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,
			EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991302,3)) end
	end)
	local s2=s1:Clone()
	s2:SetCode(EVENT_CHAIN_NEGATED)
	s2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if ep==tp then return end
		local c=e:GetHandler()
		if re:IsActiveType(TYPE_MONSTER) then c:ResetFlagEffect(19991302) end
		if re:IsActiveType(TYPE_SPELL) then c:ResetFlagEffect(29991302) end
		if re:IsActiveType(TYPE_TRAP) then c:ResetFlagEffect(39991302) end
	end)
	local s3=Effect.CreateEffect(oc)
	s3:SetType(EFFECT_TYPE_FIELD)
	s3:SetCode(EFFECT_CANNOT_ACTIVATE)
	s3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	s3:SetRange(LOCATION_MZONE)
	s3:SetTargetRange(0,1)
	s3:SetValue(function(e,re,tp)
		local c=e:GetHandler()
		if re:IsActiveType(TYPE_MONSTER) and c:GetFlagEffect(19991302)~=0 then return true end
		if re:IsActiveType(TYPE_SPELL) and c:GetFlagEffect(29991302)~=0 then return true end
		if re:IsActiveType(TYPE_TRAP) and c:GetFlagEffect(39991302)~=0 then return true end
		return false
	end)
	local t={s1,s2,s3}
	if tc then
		for i,effect in pairs(t) do
			effect:SetProperty(bit.bor(effect:GetProperty(),EFFECT_FLAG_UNCOPYABLE))
			effect:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(effect)
		end
		tc:RegisterFlagEffect(9991302,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991302,0))
	else
		for i,effect in pairs(t) do
			oc:RegisterEffect(effect)
		end
		oc:RegisterFlagEffect(9991302,0,0,1)
	end
end