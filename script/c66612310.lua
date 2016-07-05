--扑克魔术 血色花蕾
function c66612310.initial_effect(c)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c66612310.limit)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c66612310.sprcon)
	e1:SetOperation(c66612310.sprop)
	c:RegisterEffect(e1)
	--battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c66612310.condition)
	e2:SetTarget(c66612310.target)
	e2:SetOperation(c66612310.activate)
	c:RegisterEffect(e2)
	--limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(c66612310.splimit)
	c:RegisterEffect(e3)
	--to deck
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c66612310.tdcon)
	e4:SetCost(c66612310.tdcost)
	e4:SetTarget(c66612310.tdtg)
	e4:SetOperation(c66612310.tdop)
	c:RegisterEffect(e4)
	--sp
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(66612310,2))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,66612310+EFFECT_COUNT_CODE_DUEL)
	e5:SetCost(c66612310.pucost)
	e5:SetTarget(c66612310.putg)
	e5:SetOperation(c66612310.puop)
	c:RegisterEffect(e5)
end
function c66612310.limit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c66612310.splimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0xe660)
end
function c66612310.spfilter1(c,tp)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial(nil,true) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c66612310.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c66612310.spfilter2(c)
	return (c:GetLevel()==4 or c:GetLevel()==8) and c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial(nil,true) and c:IsAbleToRemoveAsCost()
end
function c66612310.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c66612310.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c66612310.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612310,0))
	local g1=Duel.SelectMatchingCard(tp,c66612310.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612310,1))
	local g2=Duel.SelectMatchingCard(tp,c66612310.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c66612310.condition(e,tp,eg,ep,ev,re,r,rp)
    return tp==Duel.GetTurnPlayer()
end
function c66612310.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true	end
	local t={aux.Stringid(66612310,3),aux.Stringid(66612310,4)}
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612310,5))
	local opt=Duel.SelectOption(tp,table.unpack(t))
	e:SetLabel(opt)
end
function c66612310.atkfilter(c)
	return c:IsSetCard(0x660) and c:IsFaceup() and  c:IsType(TYPE_MONSTER) 
end
function c66612310.activate(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local sg=nil
	if opt==0 then 
	local sg=Duel.GetMatchingGroupCount(c66612310.atkfilter,tp,LOCATION_MZONE,0,nil)
	if e:GetHandler():IsFaceup() then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(66612310,3))
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e:GetHandler():RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(sg*200)
	e2:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e:GetHandler():RegisterEffect(e2)
	end
	else
	if e:GetHandler():IsFaceup() then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(66612310,4))
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c66612310.destg)
	e1:SetOperation(c66612310.desop)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e:GetHandler():RegisterEffect(e1)
	end
	end
end
function c66612310.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return tc and tc:IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c66612310.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c66612310.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.exccon(e) 
end
function c66612310.tgfilter(c)
	return c:IsAbleToGrave() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x660)
end
function c66612310.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function c66612310.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  Duel.IsExistingMatchingCard(c66612310.tgfilter,tp,LOCATION_DECK,0,2,nil)    end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,tp,LOCATION_DECK)
end
function c66612310.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c66612310.tgfilter,tp,LOCATION_DECK,0,2,2,nil)
	if g:GetCount()==2 then
	Duel.SendtoGrave(g,REASON_EFFECT)
end
end
function c66612310.pufilter(c)
	return not c:IsPublic()
end
function c66612310.pucost(e,tp,eg,ep,ev,re,r,rp,chk)
	 local g=Duel.GetMatchingGroup(c66612310.pufilter,tp,LOCATION_HAND,0,nil)
	if chk==0 then return g:GetCount()>0 end
	local tc=g:GetFirst()
    while tc do
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
    tc=g:GetNext()
	end
end
function c66612310.pudefilter(c)
	return c:IsDestructable() and c:IsAttackPos()
end
function c66612310.putg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612310.pudefilter,tp,0,LOCATION_MZONE,1,nil)
	and Duel.GetFlagEffect(tp,66612301)==0	end
	local g=Duel.GetMatchingGroup(c66612310.pudefilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c66612310.puop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_CARD,0,66612362)
    local g=Duel.GetMatchingGroup(c66612310.pudefilter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
	Duel.Destroy(g,REASON_EFFECT)
	end
end