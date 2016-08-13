if not pcall(function() require("expansions/script/c2150000") end) then require("script/c2150000") end
function c2150012.initial_effect(c)
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_QUICK_O)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetRange(LOCATION_MZONE)
	a:SetCost(c2150012.coa)
	a:SetOperation(c2150012.opa)
	c:RegisterEffect(a)
	a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD)
	a:SetCode(EFFECT_UPDATE_ATTACK)
	a:SetRange(LOCATION_MZONE)
	a:SetTargetRange(LOCATION_MZONE,0)
	a:SetTarget(c2150012.tgb)
	a:SetValue(c2150012.vb)
	c:RegisterEffect(a)
end
function c2150012.coa(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST)and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD+LOCATION_HAND,0)>1 end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c2150012.opa(e,tp)
	if Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD+LOCATION_HAND,0)<2 then return end
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD+LOCATION_HAND,0,2,2,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
	local c=(g:FilterCount(BiDiuF,nil)>1 and 1 or 0)+(Duel.GetTurnPlayer()==tp and 1 or 0)
	if c>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>=c then
		Duel.SendtoGrave(Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_ONFIELD,c,c,nil),REASON_EFFECT)
	end
end
function c2150012.tgb(e,c)return BiDiuF(c)end
function c2150012.vb(e)return math.max(0,1600-800*e:GetHandler():GetOverlayCount())end
