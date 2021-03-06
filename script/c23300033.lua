--忍野扇
function c23300033.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c23300033.con)
	e1:SetTarget(c23300033.tg)
	e1:SetOperation(c23300033.op)
	c:RegisterEffect(e1)
end
function c23300033.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c23300033.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
end
function c23300033.cfilter1(c)
	return c:IsSetCard(0x990) and c:IsLocation(LOCATION_GRAVE)
end
function c23300033.op(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(p,Card.IsAbleToGrave,p,LOCATION_ONFIELD,0,1,63,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoGrave(g,REASON_EFFECT)
	local sg=Duel.GetOperatedGroup()
	local ct=g:FilterCount(c23300033.cfilter1,nil)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Draw(p,ct,REASON_EFFECT)
	end
end