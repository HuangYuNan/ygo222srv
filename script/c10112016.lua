--神秘之洞穴
function c10112016.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_RITUAL+TYPE_XYZ+TYPE_FUSION+TYPE_SYNCHRO))
	e2:SetCondition(c10112016.con1)
	e2:SetValue(100)
	c:RegisterEffect(e2) 
	--extra summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e3:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x5331))
	e3:SetCondition(c10112016.con2)
	c:RegisterEffect(e3)   
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetValue(1)
	e4:SetCondition(c10112016.con3)
	c:RegisterEffect(e4)
	--indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCondition(c10112016.con4)
	e5:SetTarget(c10112016.reptg)
	e5:SetValue(c10112016.repval)
	c:RegisterEffect(e5)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e5:SetLabelObject(g)
	--Destroy
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetDescription(aux.Stringid(10112016,1))
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetTarget(c10112016.destg)
	e6:SetOperation(c10112016.desop)
	c:RegisterEffect(e6)  
end

function c10112016.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(c10112016.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end

function c10112016.desfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ+TYPE_SYNCHRO+TYPE_FUSION+TYPE_RITUAL) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsDestructable()
end

function c10112016.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c10112016.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end

function c10112016.repfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsType(TYPE_XYZ+TYPE_SYNCHRO+TYPE_FUSION+TYPE_RITUAL) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:GetFlagEffect(10112016)==0
end

function c10112016.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c10112016.repfilter,1,nil,tp) end
	local g=eg:Filter(c10112016.repfilter,nil,tp)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(10112016,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(10112016,0))
		tc=g:GetNext()
	end
	e:GetLabelObject():Clear()
	e:GetLabelObject():Merge(g)
	return true
end

function c10112016.repval(e,c)
	local g=e:GetLabelObject()
	return g:IsContains(c)
end

function c10112016.con4(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c10112016.filter,tp,LOCATION_MZONE,0,nil)>=4
end

function c10112016.con3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c10112016.filter,tp,LOCATION_MZONE,0,nil)>=3
end

function c10112016.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c10112016.filter,tp,LOCATION_MZONE,0,nil)>=2
end

function c10112016.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c10112016.filter,tp,LOCATION_MZONE,0,nil)>=1
end

function c10112016.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ+TYPE_SYNCHRO+TYPE_FUSION+TYPE_RITUAL)
end
