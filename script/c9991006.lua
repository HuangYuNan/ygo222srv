--ヴォイド・ハイパー ホムラ
require "expansions/script/c9990000"
function c9991006.initial_effect(c)
	Dazz.VoidSynchroCommonEffect(c,9991002)
	--Tachyon Spiral
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991006,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetHintTiming(0,0x1c0)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c9991006.tscon)
	e1:SetTarget(c9991006.tstg)
	e1:SetOperation(c9991006.tsop)
	c:RegisterEffect(e1)
	--Power Up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(function(e,c)
		return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_EXTRA,0)*50
	end)
	c:RegisterEffect(e2)
end
c9991006.Dazz_name_void=2
function c9991006.tscon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==1-tp then
		return bit.band(Duel.GetCurrentPhase(),0xf8)~=0
	else
		return true
	end
end
function c9991006.tstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
end
function c9991006.tsop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	g:ForEach(function(tc)
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=e1:Clone()
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			tc:RegisterEffect(e3)
		end
	end)
end