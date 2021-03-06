--Celestial Pneuma
require "expansions/script/c9990000"
function c9991301.initial_effect(c)
	Dazz.PneumaCommonEffect(c,9991301)
	--SP Success
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
		local sg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,1,0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.SendtoHand(g,nil,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e1)
end
function c9991301.Pneuma_Bonus_Effect(oc,tc)
	local s1=Effect.CreateEffect(oc)
	s1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	s1:SetCode(EVENT_DAMAGE_CALCULATING)
	s1:SetRange(LOCATION_MZONE)
	s1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local c,tc,a,d=e:GetHandler(),nil,Duel.GetAttacker(),Duel.GetAttackTarget()
		if not d or not c:IsRelateToBattle() then return end
		if c==a then tc=d else tc=a end
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_SET_ATTACK_FINAL)
		e5:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e5:SetValue(1000)
		tc:RegisterEffect(e5,true)
		local e2=e5:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		tc:RegisterEffect(e2,true)
	end)
	if tc then
		s1:SetProperty(bit.bor(s1:GetProperty(),EFFECT_FLAG_UNCOPYABLE))
		s1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(s1)
		tc:RegisterFlagEffect(9991301,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991301,0))
	else
		oc:RegisterEffect(s1)
		oc:RegisterFlagEffect(9991301,0,0,1)
	end
end