--Aquatic Pneuma
require "expansions/script/c9990000"
function c9991304.initial_effect(c)
	Dazz.PneumaCommonEffect(c,9991304)
	--SP Success
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(1)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Draw(p,d,REASON_EFFECT)
	end)
	c:RegisterEffect(e1)
end
function c9991304.Pneuma_Bonus_Effect(oc,tc)
	local s1=Effect.CreateEffect(oc)
	s1:SetType(EFFECT_TYPE_SINGLE)
	s1:SetCode(EFFECT_ATTACK_ALL)
	s1:SetValue(1)
	if tc then
		s1:SetProperty(bit.bor(s1:GetProperty(),EFFECT_FLAG_UNCOPYABLE))
		s1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(s1)
		tc:RegisterFlagEffect(9991304,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991304,0))
	else
		oc:RegisterEffect(s1)
		oc:RegisterFlagEffect(9991304,0,0,1)
	end
end