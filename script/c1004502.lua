--母亲
function c1004502.initial_effect(c)
	--fusion material
	c:SetUniqueOnField(1,0,1004502)
	c:EnableReviveLimit()
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c1004502.sprcon)
	e2:SetOperation(c1004502.sprop)
	c:RegisterEffect(e2)
end
function c1004502.spfilter1(c,tp)
	return c:IsCode(1004501) and c:IsDestructable()
end
function c1004502.sprcon(e,c)
	if c==nil then return true end
	if chk==0 then return Duel.IsExistingMatchingCard(c1004502.spfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c1004502.spfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,nil,tp)
end
function c1004502.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectMatchingCard(tp,c1004502.spfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,99,nil,tp)
	Duel.Destroy(g1,POS_FACEUP,REASON_COST)
end