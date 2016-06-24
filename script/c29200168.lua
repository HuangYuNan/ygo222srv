--凋叶棕-改-胎儿之梦
function c29200168.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,29200109,aux.FilterBoolFunction(Card.IsFusionSetCard,0x53e0),1,true,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c29200168.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c29200168.spcon)
	e2:SetOperation(c29200168.spop)
	c:RegisterEffect(e2)
	--cannot be target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c29200168.tgcon)
	e4:SetValue(aux.imval1)
	c:RegisterEffect(e4)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c29200168.con)
	e3:SetOperation(c29200168.op)
	c:RegisterEffect(e3)
end
function c29200168.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_FUSION 
end
function c29200168.op(e,tp,eg,ep,ev,re,r,rp)
	--cannot target
	local e11=Effect.CreateEffect(e:GetHandler())
	e11:SetDescription(aux.Stringid(29200168,1))
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e11:SetReset(RESET_EVENT+0x1fe0000)
	e11:SetValue(aux.tgoval)
	e:GetHandler():RegisterEffect(e11)
	--activate limit
	local e10=Effect.CreateEffect(e:GetHandler())
	e10:SetDescription(aux.Stringid(29200168,1))
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCountLimit(1,29200168)
	e10:SetReset(RESET_EVENT+0x1fe0000)
	e10:SetCost(c29200168.cost)
	e10:SetOperation(c29200168.operation)
	e:GetHandler():RegisterEffect(e10)
end
function c29200168.tgfilter(c)
	return c:IsFaceup() and  c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER) 
end
function c29200168.tgcon(e)
	return Duel.IsExistingMatchingCard(c29200168.tgfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c29200168.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c29200168.spfilter1(c,tp,fc)
	return c:IsFusionCode(29200109) and c:IsCanBeFusionMaterial(fc)
		and Duel.CheckReleaseGroup(tp,c29200168.spfilter2,1,c,fc)
end
function c29200168.spfilter2(c,fc)
	return c:IsFusionSetCard(0x53e0) and c:IsCanBeFusionMaterial(fc)
end
function c29200168.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.CheckReleaseGroup(tp,c29200168.spfilter1,1,nil,tp,c)
end
function c29200168.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroup(tp,c29200168.spfilter1,1,1,nil,tp,c)
	local g2=Duel.SelectReleaseGroup(tp,c29200168.spfilter2,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.Release(g1,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
function c29200168.cfilter(c)
	return c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c29200168.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29200168.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c29200168.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	e:SetLabel(g:GetFirst():GetLevel())
	Duel.ShuffleHand(tp)
end
function c29200168.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetLabel(e:GetLabel()+1)
	e1:SetReset(RESET_PHASE+PHASE_MAIN1+RESET_OPPO_TURN)
	e1:SetValue(c29200168.val)
	Duel.RegisterEffect(e1,tp)
end
function c29200168.val(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsLevelAbove(e:GetLabel()) and not re:GetHandler():IsImmuneToEffect(e)
end
