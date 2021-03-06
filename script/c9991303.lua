--Arboreal Pneuma
require "expansions/script/c9990000"
function c9991303.initial_effect(c)
	Dazz.PneumaCommonEffect(c,9991303)
	--SP Success
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
		local sg=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,1,0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e1)
end
function c9991303.Pneuma_Bonus_Effect(oc,tc)
	local s1=Effect.CreateEffect(oc)
	s1:SetType(EFFECT_TYPE_FIELD)
	s1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	s1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	s1:SetRange(LOCATION_MZONE)
	s1:SetTargetRange(0,0xff)
	s1:SetValue(LOCATION_REMOVED)
	s1:SetTarget(function(e,c)
		return c:GetOwner()~=e:GetHandlerPlayer()
	end)
	if tc then
		s1:SetProperty(bit.bor(s1:GetProperty(),EFFECT_FLAG_UNCOPYABLE))
		s1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(s1)
		tc:RegisterFlagEffect(9991303,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991303,0))
	else
		oc:RegisterEffect(s1)
		oc:RegisterFlagEffect(9991303,0,0,1)
	end
end