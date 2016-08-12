--洁癖的班长·此花露西娅
function c1100805.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c1100805.target)
	e1:SetValue(1)
	e1:SetOperation(c1100805.operation)
	c:RegisterEffect(e1) 
	--nontuner
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_NONTUNER)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1100805,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,1100805)
	e2:SetCost(c1100805.spcost)
	e2:SetTarget(c1100805.sptg)
	e2:SetOperation(c1100805.spop)
	c:RegisterEffect(e2)
end
c1100805.tuner_filter=aux.FALSE
function c1100805.synfilter(c,syncard,tuner,f,lv)
	return c:IsSetCard(0x1243) and c:IsCanBeSynchroMaterial(syncard,tuner) and (f==nil or f(c)) and c:GetLevel()==lv
end
function c1100805.target(e,syncard,f,minc)
	local c=e:GetHandler()
	if minc>1 then return false end
	local lv=syncard:GetLevel()-c:GetLevel()
	if lv<=0 then return false end
	return Duel.IsExistingMatchingCard(c1100805.synfilter,syncard:GetControler(),LOCATION_HAND,0,1,nil,syncard,c,f,lv)
end
function c1100805.operation(e,tp,eg,ep,ev,re,r,rp,syncard,f,minc)
	local c=e:GetHandler()
	local lv=syncard:GetLevel()-c:GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c1100805.synfilter,tp,LOCATION_HAND,0,1,1,nil,syncard,c,f,lv)
	Duel.SetSynchroMaterial(g)
end
function c1100805.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c1100805.spfilter(c,e,tp)
	return c:IsSetCard(0x1243) and c:IsType(TYPE_MONSTER) and not c:IsCode(1100805) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1100805.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1100805.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c1100805.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1100805.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
	end
end
