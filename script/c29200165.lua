--凋叶棕-改-Mad Party
function c29200165.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,29200134,aux.FilterBoolFunction(Card.IsFusionSetCard,0x53e0),1,true,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c29200165.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SPSUMMON_PROC)
	e7:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e7:SetRange(LOCATION_EXTRA)
	e7:SetCondition(c29200165.spcon)
	e7:SetOperation(c29200165.spop)
	c:RegisterEffect(e7)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c29200165.con)
	e3:SetOperation(c29200165.op)
	c:RegisterEffect(e3)
	--destroy replace
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e14:SetCode(EFFECT_DESTROY_REPLACE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetTarget(c29200165.reptg)
	c:RegisterEffect(e14)
	--atkup
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(29200165,0))
	e12:SetCategory(CATEGORY_DESTROY)
	e12:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e12:SetCode(EVENT_SPSUMMON_SUCCESS)
	e12:SetCountLimit(1,29200165)
	e12:SetCondition(c29200165.con1)
	e12:SetTarget(c29200165.tg1)
	e12:SetOperation(c29200165.op1)
	c:RegisterEffect(e12)
end
c29200165.material_dyz_lv=8
function c29200165.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c29200165.spfilter1(c,tp,fc)
	return c.may_party_list and c:IsCanBeFusionMaterial(fc)
		and Duel.CheckReleaseGroup(tp,c29200165.spfilter2,1,c,fc)
end
function c29200165.spfilter2(c,fc)
	return c:IsFusionSetCard(0x53e0) and c:IsCanBeFusionMaterial(fc)
end
function c29200165.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.CheckReleaseGroup(tp,c29200165.spfilter1,1,nil,tp,c)
end
function c29200165.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroup(tp,c29200165.spfilter1,1,1,nil,tp,c)
	local g2=Duel.SelectReleaseGroup(tp,c29200165.spfilter2,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.Release(g1,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
function c29200165.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_FUSION 
end
function c29200165.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29200165,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	e2:SetCondition(c29200165.condition)
	e2:SetOperation(c29200165.operation)
	c:RegisterEffect(e2)
	--search
	e12=Effect.CreateEffect(c)
	e12:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e12:SetProperty(EFFECT_FLAG_DELAY)
	e12:SetCode(EVENT_BATTLE_DESTROYING)
	e12:SetReset(RESET_EVENT+0x1fe0000)
	e12:SetCountLimit(1,29200022)
	e12:SetTarget(c29200165.schtg)
	e12:SetOperation(c29200165.schop)
	c:RegisterEffect(e12)
end
function c29200165.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return e:GetHandler():IsReason(REASON_EFFECT+REASON_BATTLE) and c:GetDefense()~=0 end
	if Duel.SelectYesNo(tp,aux.Stringid(29200165,0)) then
	local preatk=c:GetAttack()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(-500)
	c:RegisterEffect(e1)
	if predef~=0 and c:GetDefense()==0 then 
	   Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
		return true
	else return false end
end
function c29200165.con1(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
		and Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
		or Duel.GetFieldCard(1-tp,LOCATION_SZONE,4-seq)
end
function c29200165.filter1(c,seq)
	return c:GetSequence()==seq  and c:IsDestructable()
end
function c29200165.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local seq=e:GetHandler():GetSequence()
	local g=Group.CreateGroup()
	local dc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
	if dc then g:AddCard(dc) end
	dc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,4-seq)
	if dc then g:AddCard(dc) end
	Duel.SelectOption(1-tp,aux.Stringid(29200165,2))
	Duel.SelectOption(tp,aux.Stringid(29200165,2))
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c29200165.op1(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local g=Group.CreateGroup()
	local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
	if tc then g:AddCard(tc) end
	tc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,4-seq)
	if tc then g:AddCard(tc) end
	Duel.Destroy(g,REASON_EFFECT)
end
function c29200165.filter(c,tc)
	if not c:IsFaceup() then return false end
	return tc:GetBaseAttack()~=c:GetAttack() or tc:GetBaseAttack()~=c:GetDefense()
end
function c29200165.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc and c29200165.filter(c,bc) and bc:IsFaceup() and bc:IsRelateToBattle()
end
function c29200165.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:IsFaceup() and c:IsRelateToBattle() and bc:IsFaceup() and bc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(bc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c29200165.sfilter(c)
	return c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c29200165.schtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29200165.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29200165.schop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c29200165.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end