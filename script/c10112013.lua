--炼金生命体·混沌融合体
function c10112013.initial_effect(c)
	c:EnableReviveLimit()
	--Cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c10112013.spcon)
	e2:SetOperation(c10112013.spop)
	c:RegisterEffect(e2) 
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c10112013.condition)
	e3:SetValue(c10112013.efilter)
	c:RegisterEffect(e3) 
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SET_ATTACK_FINAL)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c10112013.adval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_SET_DEFENSE_FINAL)
	c:RegisterEffect(e5)  
end

function c10112013.condition(e)
	return not Duel.IsExistingMatchingCard(nil,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end

function c10112013.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end

function c10112013.adval(e,c)
	local g=Duel.GetMatchingGroup(c10112013.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then 
		return 100
	else
		local tg,val=g:GetMaxGroup(Card.GetBaseAttack)
		return val+100
	end
end

function c10112013.filter(c)
	return c:IsFaceup() and c:GetCode()~=10112013
end

function c10112013.spfilter1(c,tp)
	return c:IsType(TYPE_RITUAL) and c:IsAbleToRemoveAsCost() and Duel.IsExistingMatchingCard(c10112013.spfilter2,tp,LOCATION_MZONE,0,1,c,c,tp)
end

function c10112013.spfilter2(c,sc1,tp)
	return c:IsType(TYPE_FUSION) and c:IsAbleToRemoveAsCost() and Duel.IsExistingMatchingCard(c10112013.spfilter3,tp,LOCATION_MZONE,0,1,c,sc1,c,tp)
end

function c10112013.spfilter3(c,sc1,sc2,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemoveAsCost() and Duel.IsExistingMatchingCard(c10112013.spfilter4,tp,LOCATION_MZONE,0,1,c,sc1,sc2) and sc1~=c
end

function c10112013.spfilter4(c,sc1,sc2)
	return c:IsType(TYPE_XYZ) and c:IsAbleToRemoveAsCost() and sc1~=c and sc2~=c
end

function c10112013.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c10112013.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end

function c10112013.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sc1=Duel.SelectMatchingCard(tp,c10112013.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sc2=Duel.SelectMatchingCard(tp,c10112013.spfilter2,tp,LOCATION_MZONE,0,1,1,sc1,sc1,tp):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sc3=Duel.SelectMatchingCard(tp,c10112013.spfilter3,tp,LOCATION_MZONE,0,1,1,sc2,sc1,sc2,tp):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g4=Duel.SelectMatchingCard(tp,c10112013.spfilter4,tp,LOCATION_MZONE,0,1,1,sc3,sc1,sc2)
	g4:AddCard(sc1)
	g4:AddCard(sc2)
	g4:AddCard(sc3)
	c:SetMaterial(g4)
	Duel.Remove(g4,POS_FACEUP,REASON_COST)
end