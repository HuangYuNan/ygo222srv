--Synchronous Sliver
require "expansions/script/c9990000"
function c9991805.initial_effect(c)
	Dazz.SliverCommonEffect(c,4,9991805)
end
c9991805.Dazz_name_sliver=true
function c9991805.Sliver_General_Effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991805,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c9991805.target)
	e1:SetOperation(c9991805.operation)
	c:RegisterEffect(e1)
end
function c9991805.tgfilter(c)
	return Dazz.IsSliver(c) and c:IsFaceup() and not c:IsType(TYPE_TUNER)
end
function c9991805.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c9991805.tgfilter(chkc) and chkc~=c end
	if chk==0 then return c:IsHasEffect(9991805) and not c:IsType(TYPE_TUNER)
		and Duel.IsExistingTarget(c9991805.tgfilter,tp,LOCATION_MZONE,0,1,c) and Duel.GetFlagEffect(tp,9991805)<2 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c9991805.tgfilter,tp,LOCATION_MZONE,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.RegisterFlagEffect(tp,9991805,RESET_PHASE+PHASE_END,0,1)
end
function c9991805.operation(e,tp,eg,ep,ev,re,r,rp)
	local c,tc=e:GetHandler(),Duel.GetFirstTarget()
	local mg=Group.FromCards(c,tc)
	if not tc or not tc:IsRelateToEffect(e) or tc:IsFacedown() or tc:IsType(TYPE_TUNER) or tc:IsControler(1-tp) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetValue(TYPE_TUNER)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	if not c:IsRelateToEffect(e) or c:IsImmuneToEffect(e) or c:IsControler(1-tp) then return end
	local sg=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,tc,mg)
	if sg:GetCount()~=0 and Duel.SelectYesNo(tp,aux.Stringid(9991805,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		sc=sg:Select(tp,1,1,nil):GetFirst()
		Duel.SynchroSummon(tp,sc,tc,mg)
	end
end