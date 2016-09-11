--Prim-被爱拐走♥爱情好盲目
local m=37564606
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564606.initial_effect(c)
	senya.prl4(c,m)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,37560606)
	e2:SetCost(c37564606.thcost)
	e2:SetCondition(c37564606.thcon)
	e2:SetTarget(c37564606.sptg1)
	e2:SetOperation(c37564606.spop1)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564606,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,37562606)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetLabel(1)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg and eg:IsExists(c37564606.sfilter,1,nil,tp)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsAbleToExtra() and Duel.IsPlayerCanDraw(tp,1) end
		Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,tp,LOCATION_GRAVE)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if not (e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsAbleToExtra()) then return end
		if Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)>0 then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e1)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34834619,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1,313131313)
	e3:SetCost(senya.discost(1))
	e3:SetCondition(c37564606.thcon1)
	e3:SetTarget(c37564606.sptg)
	e3:SetOperation(c37564606.spop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e4:SetValue(c37564606.splimit)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e6)
end
function c37564606.splimit(e,c)
	if not c then return false end
	return not c:IsHasEffect(37564600)
end
function c37564606.thfilter(c)
	return c:IsHasEffect(37564600) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c37564606.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564606.thfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c37564606.thfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c37564606.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c37564606.filter(c,e,tp,mg)
	return mg and mg:IsContains(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37564606.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=e:GetHandler():GetMaterial()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c37564606.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,mg) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c37564606.spop1(e,tp,eg,ep,ev,re,r,rp)
	local mg=e:GetHandler():GetMaterial()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564606.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,mg)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_REMOVE_TYPE)
		e3:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetValue(TYPE_TUNER)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3,true)
		Duel.SpecialSummonComplete()
	end
end
function c37564606.sfilter(c,tp)
	local ty=c:GetSummonType()
	return ty==SUMMON_TYPE_SYNCHRO and c:IsHasEffect(37564600) and c:GetSummonPlayer()==tp
end
function c37564606.thcon1(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c37564606.mtfilter(c,e)
	return c:GetLevel()>0 and c:IsHasEffect(37564600) and c:IsAbleToDeckAsCost() and not c:IsImmuneToEffect(e) and not c:IsCode(37564606)
end
function c37564606.spfilter(c,e,tp,m)
	return c:IsCode(37564606) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and m:CheckWithSumEqual(Card.GetRitualLevel,4,1,99,c)
end
function c37564606.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local mg=Duel.GetMatchingGroup(c37564606.mtfilter,tp,LOCATION_GRAVE,0,e:GetHandler(),e)
		return c37564606.spfilter(e:GetHandler(),e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c37564606.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c37564606.mtfilter,tp,LOCATION_GRAVE,0,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564606.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,mg)
	local tc=g:GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,4,1,99,tc)
		tc:SetMaterial(mat)
		Duel.SendtoDeck(mat,nil,2,REASON_COST)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end