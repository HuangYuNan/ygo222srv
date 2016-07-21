--扑克魔术 随想曲
function c66612309.initial_effect(c)
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsSetCard,0x660),c66612309.ffilter,true)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c66612309.sprcon)
	e1:SetOperation(c66612309.sprop)
	c:RegisterEffect(e1)
	--cannnot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c66612309.val)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(c66612309.splimit)
	c:RegisterEffect(e3)
	--to deck
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c66612309.tdcon)
	e4:SetCost(c66612309.tdcost)
	e4:SetTarget(c66612309.tdtg)
	e4:SetOperation(c66612309.tdop)
	c:RegisterEffect(e4)
	--sp
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(66612309,2))
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,66612309+EFFECT_COUNT_CODE_DUEL)
	e5:SetCost(c66612309.pucost)
	e5:SetTarget(c66612309.putg)
	e5:SetOperation(c66612309.puop)
	c:RegisterEffect(e5)
end
function c66612309.ffilter(c)
	return c:GetLevel()==3 or c:GetLevel()==7
end
function c66612309.splimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0xe660)
end
function c66612309.spfilter1(c,tp,fc)
	return c:IsSetCard(0x660)  and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial(fc)
		and Duel.IsExistingMatchingCard(c66612309.spfilter2,tp,LOCATION_MZONE,0,1,c,fc)
end
function c66612309.spfilter2(c,fc)
	return (c:GetLevel()==3 or c:GetLevel()==7)  and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function c66612309.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c66612309.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp,c)
end
function c66612309.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612309,0))
	local g1=Duel.SelectMatchingCard(tp,c66612309.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612309,1))
	local g2=Duel.SelectMatchingCard(tp,c66612309.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c66612309.val(e,c)
	return  c:IsSetCard(0x660) and c~=e:GetHandler()
end
function c66612309.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.exccon(e) 
end
function c66612309.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function c66612309.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)   end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c66612309.tdop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)>0 and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
end
function c66612309.pufilter(c)
	return not c:IsPublic()
end
function c66612309.pucost(e,tp,eg,ep,ev,re,r,rp,chk)
	 local g=Duel.GetMatchingGroup(c66612309.pufilter,tp,LOCATION_HAND,0,nil)
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
function c66612309.puthfilter(c)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c66612309.pufufilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
end
function c66612309.putg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612309.puthfilter,tp,LOCATION_REMOVED,0,1,nil)
	and Duel.GetFlagEffect(tp,66612301)==0  and Duel.IsExistingMatchingCard(c66612309.pufufilter,tp,LOCATION_MZONE,0,1,nil)	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,0,0,0)
end
function c66612309.puop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_CARD,0,66612363)
    local g=Duel.GetMatchingGroupCount(c66612309.pufufilter,tp,LOCATION_MZONE,0,nil)
	if g>0 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local rg=Duel.SelectMatchingCard(tp,c66612309.puthfilter,tp,LOCATION_REMOVED,0,1,g,nil)
    if rg:GetCount()>0 then
	Duel.SendtoHand(rg,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,rg)
	end
end
end