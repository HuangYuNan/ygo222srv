require 'expansions.script.c2150000'
function c2150013.initial_effect(c)
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_QUICK_O)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetRange(LOCATION_MZONE)
	a:SetCost(c2150013.coa)
	a:SetOperation(c2150013.opa)
	c:RegisterEffect(a)
	a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	a:SetCode(EVENT_LEAVE_FIELD)
	a:SetRange(LOCATION_MZONE)
	a:SetCondition(c2150013.cnb)
	a:SetOperation(c2150013.opb)
	a:SetCountLimit(1)
	c:RegisterEffect(a)
	a=a:Clone()
	a:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	c:RegisterEffect(a)
end
function c2150013.coa(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST)and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD+LOCATION_HAND,0)>1 end
        e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c2150013.opa(e,tp)
        if Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD+LOCATION_HAND,0)<2 then return end
        local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD+LOCATION_HAND,0,2,2,nil)
        Duel.SendtoGrave(g,REASON_EFFECT)
       	Duel.Draw(tp,(g:FilterCount(BiDiuF,nil)>1 and 1 or 0)+(Duel.GetTurnPlayer()==tp and 1 or 0),REASON_EFFECT)
end
function c2150013.cnb(e,tp,eg)return (not eg or eg:IsExists(BiDiuF,1,nil))and e:GetHandler():GetOverlayCount()<2 end
function c2150013.opb(e,tp)Duel.Draw(tp,1,REASON_EFFECT)end
