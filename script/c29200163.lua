--凋叶棕-改-Parallel sky
function c29200163.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,29200131,aux.FilterBoolFunction(Card.IsFusionSetCard,0x53e0),1,true,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c29200163.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c29200163.spcon)
	e2:SetOperation(c29200163.spop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c29200163.con)
	e3:SetOperation(c29200163.op)
	c:RegisterEffect(e3)
	--draw
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(29200163,1))
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetCode(EVENT_BATTLE_DESTROYING)
	e7:SetCondition(c29200163.reccon)
	e7:SetTarget(c29200163.drtg)
	e7:SetOperation(c29200163.drop)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCondition(c29200163.reccon1)
	e8:SetTarget(c29200163.drtg1)
	e8:SetOperation(c29200163.drop1)
	c:RegisterEffect(e8)
end
function c29200163.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c29200163.spfilter1(c,tp,fc)
	return c:IsFusionCode(29200131) and c:IsCanBeFusionMaterial(fc)
		and Duel.CheckReleaseGroup(tp,c29200163.spfilter2,1,c,fc)
end
function c29200163.spfilter2(c,fc)
	return c:IsFusionSetCard(0x53e0) and c:IsCanBeFusionMaterial(fc)
end
function c29200163.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.CheckReleaseGroup(tp,c29200163.spfilter1,1,nil,tp,c)
end
function c29200163.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroup(tp,c29200163.spfilter1,1,1,nil,tp,c)
	local g2=Duel.SelectReleaseGroup(tp,c29200163.spfilter2,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.Release(g1,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
function c29200163.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_FUSION 
end
function c29200163.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(2500)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	--indestructable
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetTargetRange(LOCATION_MZONE,0)
	e8:SetCondition(c29200163.adcon)
	e8:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x53e0))
	e8:SetReset(RESET_EVENT+0x1fe0000)
	e8:SetValue(1)
	c:RegisterEffect(e8)
end
function c29200163.reccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and (bc:IsType(TYPE_MONSTER) and not bc:IsType(TYPE_XYZ))
end
function c29200163.reccon1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsType(TYPE_XYZ)
end
function c29200163.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rec=e:GetHandler():GetBattleTarget():GetLevel()*200
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,rec)
end
function c29200163.drop(e,tp,eg,ep,ev,re,r,rp)
	local rec=e:GetHandler():GetBattleTarget():GetLevel()*200
	local val=Duel.Recover(tp,rec,REASON_EFFECT)
	Duel.Damage(1-tp,rec,REASON_EFFECT)
end
function c29200163.drtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rec=e:GetHandler():GetBattleTarget():GetRank()*200
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,rec)
end
function c29200163.drop1(e,tp,eg,ep,ev,re,r,rp)
	local rec=e:GetHandler():GetBattleTarget():GetRank()*200
	local val=Duel.Recover(tp,rec,REASON_EFFECT)
	Duel.Damage(1-tp,rec,REASON_EFFECT)
end
function c29200163.adcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetLP(tp)>Duel.GetLP(1-tp)
end
