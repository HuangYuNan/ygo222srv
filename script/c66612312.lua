--扑克魔术的诅咒游戏
function c66612312.initial_effect(c)
    c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,66612312)
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsSetCard,0x660),c66612312.ffilter,true)
	--rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c66612312.sprcon)
	e1:SetOperation(c66612312.sprop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66612312,2))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c66612312.tg)
	e2:SetOperation(c66612312.op)
	c:RegisterEffect(e2)
	--limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(c66612312.splimit)
	c:RegisterEffect(e3)
	--cannot trigger
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_TRIGGER)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_ONFIELD)
	e4:SetTarget(c66612312.trtg)
	c:RegisterEffect(e4)
end
function c66612312.ffilter(c)
	return (c:IsType(TYPE_XYZ) and c:IsType(TYPE_MONSTER)) or c:IsCode(66612306)
end
function c66612312.splimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0xe660)
end
function c66612312.spfilter1(c,tp,fc)
	return c:IsSetCard(0x660)  and  c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial(fc)
		and Duel.IsExistingMatchingCard(c66612312.spfilter2,tp,LOCATION_MZONE,0,1,c,fc)
end
function c66612312.spfilter2(c,fc)
	return ((c:IsType(TYPE_XYZ) and c:IsType(TYPE_MONSTER)) or c:IsCode(66612306)) and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function c66612312.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c66612312.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp,c)
end
function c66612312.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612312,0))
	local g1=Duel.SelectMatchingCard(tp,c66612312.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612312,1))
	local g2=Duel.SelectMatchingCard(tp,c66612312.spfilter2,tp,LOCATION_ONFIELD,0,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c66612312.refilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemove()
end
function c66612312.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) and c66612312.refilter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c66612312.refilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c66612312.refilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c66612312.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c66612312.trtg(e,c)
	return c:IsFacedown()
end