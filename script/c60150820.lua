--爱莎-赫尼尔时空
function c60150820.initial_effect(c)
    c:SetSPSummonOnce(60150820)
	--fusion material
    c:EnableReviveLimit()
    aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x3b23),aux.FilterBoolFunction(Card.IsFusionSetCard,0x3b23),true)
	--spsummon condition
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)
    --special summon rule
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetCondition(c60150820.sprcon)
    e2:SetOperation(c60150820.sprop)
    c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC_G)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c60150820.spCondition())
	e3:SetOperation(c60150820.spOperation())
	c:RegisterEffect(e3)
end

function c60150820.spfilter1(c,tp)
    return c:IsFusionSetCard(0x3b23) and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial()
        and Duel.IsExistingMatchingCard(c60150820.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c60150820.spfilter2(c)
    return c:IsFusionSetCard(0x3b23) and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial()
end
function c60150820.sprcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
        and Duel.IsExistingMatchingCard(c60150820.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c60150820.sprop(e,tp,eg,ep,ev,re,r,rp,c)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g1=Duel.SelectMatchingCard(tp,c60150820.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g2=Duel.SelectMatchingCard(tp,c60150820.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
    g1:Merge(g2)
    c:SetMaterial(g1)
    Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c60150820.spConditionFilter(c,e,tp,lscale,rscale)
	return (c:IsLocation(LOCATION_HAND) or (c:IsFaceup() and c:IsLocation(LOCATION_REMOVED)))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_PENDULUM,tp,false,false) and c:IsSetCard(0x3b23)
		and not c:IsForbidden()
end
function c60150820.spCondition()
	return  
	function(e,c,og)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<=0 then return false end
		local fr=Duel.GetFieldGroupCount(tp,LOCATION_REMOVED,0)
		local fr2=Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)
		if fr>fr2 then
			return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) 
				and Duel.IsExistingMatchingCard(c60150820.spConditionFilter,tp,LOCATION_HAND+LOCATION_REMOVED,0,1,nil,e,tp)
		else
			return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) 
				and Duel.IsExistingMatchingCard(c60150820.spConditionFilter,tp,LOCATION_HAND,0,1,nil,e,tp)
		end
	end
end
function c60150820.spOperation()
	return	
	function(e,tp,eg,ep,ev,re,r,rp,c,sg,og)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<=0 then return false end
		Duel.Hint(HINT_CARD,0,60150820)
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(60150820,1))
		local fr=Duel.GetFieldGroupCount(tp,LOCATION_REMOVED,0)
		local fr2=Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)
		if fr>fr2 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c60150820.spConditionFilter,tp,LOCATION_HAND+LOCATION_REMOVED,0,1,ft,nil,e,tp)
			sg:Merge(g)
			local tc=sg:GetFirst()
			if tc then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_SPSUMMON_SUCCESS)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetOperation(c60150820.skipop)
				tc:RegisterEffect(e1)
			end
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c60150820.spConditionFilter,tp,LOCATION_HAND,0,1,ft,nil,e,tp)
			sg:Merge(g)
			local tc=sg:GetFirst()
			if tc then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_SPSUMMON_SUCCESS)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetOperation(c60150820.skipop)
				tc:RegisterEffect(e1)
			end
		end
	end
end
function c60150820.skipop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,nil)
    if g:GetCount()>0 then
        Duel.BreakEffect()
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(60150820,0))
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
        local tc=g:Select(tp,1,1,nil)	
		Duel.HintSelection(tc)
        Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
    end
	e:Reset()
end