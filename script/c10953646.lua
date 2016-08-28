--幻想猛兽
function c10953646.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c10953646.spcon)
	e2:SetOperation(c10953646.spop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE_START+PHASE_BATTLE_START)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c10953646.con)
	e3:SetOperation(c10953646.maop)
	c:RegisterEffect(e3)
end
function c10953646.filter2(c)
	return c:IsFaceup() and not c:IsSetCard(0x350) and not c:IsSetCard(0x23c)
end
function c10953646.spcon(e,c)
	if c==nil then return not Duel.IsExistingMatchingCard(c10953646.filter2,tp,LOCATION_MZONE,0,1,nil) end
	local tp=c:GetControler()
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local rg=Duel.GetReleaseGroup(tp)
	return (g:GetCount()>0 or rg:GetCount()>0) and g:FilterCount(Card.IsReleasable,nil)==g:GetCount()
end
function c10953646.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetReleaseGroup(tp)
	Duel.Release(g,REASON_COST)
	local atk=0
	local tc=g:GetFirst()
	while tc do
		local batk=tc:GetTextAttack()
		if batk>0 then
			atk=atk+batk
		end
		tc=g:GetNext()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
function c10953646.con(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c10953646.atkfilter(c)
	return (c:IsSetCard(0x350) or c:IsSetCard(0x23c)) and c:IsType(TYPE_MONSTER)
end
function c10953646.maop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	local ct=Duel.GetMatchingGroupCount(c10953646.atkfilter,tp,LOCATION_GRAVE,0,nil)
	if ct>7 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(ct-7)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_BATTLE)
		e:GetHandler():RegisterEffect(e1)
	end
end
