--凋叶棕-改-绝对的一方通行
function c29200164.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,29200023,aux.FilterBoolFunction(Card.IsFusionSetCard,0x53e0),1,true,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c29200164.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c29200164.spcon)
	e2:SetOperation(c29200164.spop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c29200164.con)
	e3:SetOperation(c29200164.op)
	c:RegisterEffect(e3)
	--damage
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(29200164,0))
	e10:SetCategory(CATEGORY_DAMAGE)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e10:SetCode(EVENT_ATTACK_ANNOUNCE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCondition(c29200164.damcon)
	e10:SetTarget(c29200164.damtg)
	e10:SetOperation(c29200164.damop)
	c:RegisterEffect(e10)
end
function c29200164.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c29200164.spfilter1(c,tp,fc)
	return c:IsFusionCode(29200023) and c:IsCanBeFusionMaterial(fc)
		and Duel.CheckReleaseGroup(tp,c29200164.spfilter2,1,c,fc)
end
function c29200164.spfilter2(c,fc)
	return c:IsFusionSetCard(0x53e0) and c:IsCanBeFusionMaterial(fc)
end
function c29200164.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.CheckReleaseGroup(tp,c29200164.spfilter1,1,nil,tp,c)
end
function c29200164.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroup(tp,c29200164.spfilter1,1,1,nil,tp,c)
	local g2=Duel.SelectReleaseGroup(tp,c29200164.spfilter2,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.Release(g1,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
function c29200164.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_FUSION 
end
function c29200164.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetCondition(c29200164.con5)
	e1:SetOperation(c29200164.op5)
	c:RegisterEffect(e1)
	--must attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_MUST_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_EP)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetCondition(c29200164.becon)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e3)
end
function c29200164.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c29200164.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(600)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,600)
end
function c29200164.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	end
end
function c29200164.con5(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() 
end
function c29200164.op5(e,tp,eg,ep,ev,re,r,rp)
	local ats=eg:GetFirst():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if ats:GetCount()==0 or (at and ats:GetCount()==1) then return end
	if Duel.SelectYesNo(tp,aux.Stringid(29200164,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(29200164,2))
		local g=ats:Select(tp,1,1,at)
		Duel.Hint(HINT_CARD,0,29200164)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
function c29200164.becon(e)
	return Duel.IsExistingMatchingCard(Card.IsAttackable,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end

