--Prim-爱如不死鸟
local m=37564601
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564601.initial_effect(c)
	senya.setreg(c,m,37564600)
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(senya.prsyfilter),2)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.synlimit)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c37564601.thcon)
	e1:SetTarget(c37564601.distg)
	e1:SetOperation(c37564601.disop)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCondition(c37564601.atkcon)
	e3:SetOperation(c37564601.atkop)
	c:RegisterEffect(e3)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34834619,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1,313131313)
	e3:SetCost(senya.discost(1))
	e3:SetCondition(c37564601.thcon1)
	e3:SetTarget(c37564601.sptg)
	e3:SetOperation(c37564601.spop)
	c:RegisterEffect(e3)
end
function c37564601.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c37564601.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c37564601.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
function c37564601.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget() and e:GetHandler():GetFlagEffect(37564601)==0
end
function c37564601.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(37564601,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
	local bc=c:GetBattleTarget()
	local val=bc:GetAttack()
	if val>0 and c:IsRelateToBattle() and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(val)
		c:RegisterEffect(e1)
	end
end
function c37564601.thcon1(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c37564601.mtfilter(c,e)
	return c:GetLevel()>0 and c:IsHasEffect(37564600) and c:IsAbleToDeckAsCost() and not c:IsImmuneToEffect(e) and not c:IsCode(37564601)
end
function c37564601.spfilter(c,e,tp,m)
	return c:IsCode(37564601) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and m:CheckWithSumEqual(Card.GetRitualLevel,12,1,99,c)
end
function c37564601.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local mg=Duel.GetMatchingGroup(c37564601.mtfilter,tp,LOCATION_GRAVE,0,e:GetHandler(),e)
		return c37564601.spfilter(e:GetHandler(),e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c37564601.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c37564601.mtfilter,tp,LOCATION_GRAVE,0,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564601.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,mg)
	local tc=g:GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,12,1,99,tc)
		tc:SetMaterial(mat)
		Duel.SendtoDeck(mat,nil,2,REASON_COST)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end