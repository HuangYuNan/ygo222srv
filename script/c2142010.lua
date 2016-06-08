--月见的灾祸之源 怨红灯
function c2142010.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x212),aux.NonTuner(Card.IsType,TYPE_SYNCHRO),1)
	c:EnableReviveLimit()
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--synchro summon to extra
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2142010,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c2142010.descost)
	e2:SetTarget(c2142010.sumtg)
	e2:SetOperation(c2142010.sumop)
	c:RegisterEffect(e2)
end
function c2142010.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,c2142010.desfilter,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroupEx(tp,c2142010.desfilter,1,1,e:GetHandler())
	e:SetLabel(g:GetFirst():GetLevel())
	Duel.Release(g,REASON_COST)
end
function c2142010.desfilter(c)
	return c:IsSetCard(0x212) and c:IsType(TYPE_MONSTER) 
end
function c2142010.filter(c,e,tp,ct)
	local ct=e:GetLabel()
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false) and c:GetLevel()==ct
end
function c2142010.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c2142010.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c2142010.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local ct=e:GetLabel()
	local g=Duel.GetMatchingGroup(c2142010.filter,tp,LOCATION_EXTRA,0,nil,e,tp,ct)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
	end
end
