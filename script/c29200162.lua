--凋叶棕-改-光芒
function c29200162.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,29200127,aux.FilterBoolFunction(Card.IsFusionSetCard,0x53e0),1,true,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c29200162.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c29200162.spcon)
	e2:SetOperation(c29200162.spop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c29200162.con)
	e3:SetOperation(c29200162.op)
	c:RegisterEffect(e3)
	--indes
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCondition(c29200162.immcon)
	e12:SetValue(c29200162.indes)
	c:RegisterEffect(e12)
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e13:SetCondition(c29200162.immcon)
	e13:SetValue(c29200162.indes2)
	c:RegisterEffect(e13)
end
function c29200162.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c29200162.spfilter1(c,tp,fc)
	return c:IsFusionCode(29200127) and c:IsCanBeFusionMaterial(fc)
		and Duel.CheckReleaseGroup(tp,c29200162.spfilter2,1,c,fc)
end
function c29200162.spfilter2(c,fc)
	return c:IsFusionSetCard(0x53e0) and c:IsCanBeFusionMaterial(fc)
end
function c29200162.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.CheckReleaseGroup(tp,c29200162.spfilter1,1,nil,tp,c)
end
function c29200162.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroup(tp,c29200162.spfilter1,1,1,nil,tp,c)
	local g2=Duel.SelectReleaseGroup(tp,c29200162.spfilter2,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.Release(g1,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
function c29200162.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_FUSION 
end
function c29200162.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	e3:SetTarget(c29200162.thtg)
	e3:SetOperation(c29200162.thop)
	c:RegisterEffect(e3)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x225))
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetCondition(c29200162.adcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c29200162.adcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetLP(tp)>Duel.GetLP(1-tp)
end
function c29200162.immcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c29200162.indes(e,c)
	local lv=e:GetHandler():GetLevel()
	if c:IsType(TYPE_XYZ) then 
		return c:GetRank()<lv
	else 
		return c:GetLevel()<lv
	end
end
function c29200162.indes2(e,te)
	if te:GetHandler():IsType(TYPE_SPELL+TYPE_TRAP) or  te:GetOwnerPlayer()~=e:GetHandlerPlayer() then return end
	local lv=e:GetHandler():GetLevel()
	if te:GetHandler():IsType(TYPE_XYZ) then 
		return te:GetHandler():GetRank()<lv
	else 
		return te:GetHandler():GetLevel()<lv
	end
end
function c29200162.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c29200162.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29200162.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c29200162.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c29200162.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c29200162.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
