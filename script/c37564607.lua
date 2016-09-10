--Prim-加油热血啦啦队
local m=37564607
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function cm.initial_effect(c)
	senya.prl4(c,m)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+senya.delay)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,m)
	e1:SetCost(senya.discost(1))
	e1:SetCondition(cm.drcon)
	e1:SetTarget(cm.drtarg)
	e1:SetOperation(cm.drop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	--e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,m)
	e2:SetCost(cm.cost)
	e2:SetTarget(cm.target)
	e2:SetOperation(cm.operation)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34834619,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1,313131313)
	e3:SetCondition(c37564607.thcon1)
	e3:SetTarget(c37564607.sptg)
	e3:SetOperation(c37564607.spop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e4:SetValue(c37564607.splimit)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e6)
end
function c37564607.splimit(e,c)
	if not c then return false end
	return not c:IsHasEffect(37564600)
end
function cm.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function cm.drtarg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function cm.cfilter(c)
	return c:IsHasEffect(37564600) and c:IsLocation(LOCATION_GRAVE)
end
function cm.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,d,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct=g:FilterCount(cm.cfilter,nil)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
function cm.swwcostfilter(c,e,tp)
	local g=Duel.GetMatchingGroup(cm.filter,tp,LOCATION_GRAVE,0,c,e,tp)
	return c:IsHasEffect(37564600) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() and g:CheckWithSumEqual(Card.GetLevel,4,1,ft)
end
function cm.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	 if chk==0 then return Duel.IsExistingMatchingCard(cm.swwcostfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) and e:GetHandler():IsAbleToRemoveAsCost() end
	 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	 local g=Duel.SelectMatchingCard(tp,cm.swwcostfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),e,tp)
	 g:AddCard(e:GetHandler())
	 Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function cm.filter(c,e,tp)
	return c:IsHasEffect(37564600) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c~=e:GetHandler()
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and cm.filter(chkc,e,tp) end
	local g=Duel.GetMatchingGroup(cm.filter,tp,LOCATION_GRAVE,0,e:GetHandler(),e,tp)
	if chk==0 then 
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		return ft>0 and g:CheckWithSumEqual(Card.GetLevel,4,1,ft)
	end
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	--local g=Duel.SelectTarget(tp,cm.filter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(cm.filter,tp,LOCATION_GRAVE,0,nil,e,tp) 
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if not (ft>0 and g:CheckWithSumEqual(Card.GetLevel,4,1,ft)) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:SelectWithSumEqual(tp,Card.GetLevel,4,1,ft)
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end
function c37564607.thcon1(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c37564607.mtfilter(c,e)
	return c:GetLevel()>0 and c:IsHasEffect(37564600) and c:IsAbleToDeckAsCost() and not c:IsImmuneToEffect(e) and not c:IsCode(37564607)
end
function c37564607.spfilter(c,e,tp,m)
	return c:IsCode(37564607) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and m:CheckWithSumEqual(Card.GetRitualLevel,4,1,99,c)
end
function c37564607.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local mg=Duel.GetMatchingGroup(c37564607.mtfilter,tp,LOCATION_GRAVE,0,e:GetHandler(),e)
		return c37564607.spfilter(e:GetHandler(),e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c37564607.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c37564607.mtfilter,tp,LOCATION_GRAVE,0,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564607.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,mg)
	local tc=g:GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,4,1,99,tc)
		tc:SetMaterial(mat)
		Duel.SendtoDeck(mat,nil,2,REASON_COST)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end