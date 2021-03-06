--Galerider Sliver
require "expansions/script/c9990000"
function c9991801.initial_effect(c)
	Dazz.SliverCommonEffect(c,3,9991801)
end
c9991801.Dazz_name_sliver=true
function c9991801.Sliver_General_Effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991801,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c9991801.condition)
	e1:SetTarget(c9991801.target)
	e1:SetOperation(c9991801.operation)
	c:RegisterEffect(e1)
end
function c9991801.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local loc,tg=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TARGET_CARDS)
	if not tg or not tg:IsContains(c) then return false end
	return loc~=LOCATION_DECK
end
function c9991801.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsHasEffect(9991801) and Duel.GetFlagEffect(tp,9991801)<2 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.RegisterFlagEffect(tp,9991801,RESET_PHASE+PHASE_END,0,1)
	Duel.RegisterFlagEffect(tp,9991801,RESET_CHAIN,0,1)
end
function c9991801.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(function(c) return c:IsFaceup() and Dazz.IsSliver(c) end,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		tc:ReleaseEffectRelation(re)
		tc=g:GetNext()
	end
end