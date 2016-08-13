require 'expansions.script.c2150000'
function c2150014.initial_effect(c)
        aux.AddXyzProcedure(c,nil,3,2)
        c:EnableReviveLimit()
        local a=Effect.CreateEffect(c)
        a:SetType(EFFECT_TYPE_QUICK_O)
        a:SetCode(EVENT_FREE_CHAIN)
        a:SetRange(LOCATION_MZONE)
        a:SetCost(c2150014.coa)
        a:SetOperation(c2150014.opa)
        c:RegisterEffect(a)
	a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD)
	a:SetCode(EFFECT_EXTRA_ATTACK)
	a:SetRange(LOCATION_MZONE)
	a:SetTargetRange(LOCATION_MZONE,0)
	a:SetTarget(c2150014.tgb)
	a:SetCondition(c2150014.cnb)
	a:SetValue(1)
	c:RegisterEffect(a)
	a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD)
	a:SetCode(EFFECT_CANNOT_BP)
	a:SetRange(LOCATION_MZONE)
	a:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	a:SetTargetRange(0,1)
	a:SetCondition(c2150014.cnb)
	--a:SetValue(function(e)return e:GetHandlerPlayer()~=Duel.GetTurnPlayer()end)
	a:SetValue(1)
	c:RegisterEffect(a)
end	
function c2150014.coa(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST)and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD+LOCATION_HAND,0)>1 end
        e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c2150014.opa(e,tp)
        if Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD+LOCATION_HAND,0)<2 then return end
        local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD+LOCATION_HAND,0,2,2,nil)
        Duel.SendtoGrave(g,REASON_EFFECT)
        local c=(g:FilterCount(BiDiuF,nil)>1 and 1 or 0)+(Duel.GetTurnPlayer()==tp and 1 or 0)
	local g=Duel.GetMatchingGroup(BiDiuF,tp,LOCATION_GRAVE,0,nil)
	if c<1 or g:GetCount()<c then return end
	Duel.SendtoHand(g:Select(tp,c,c,nil),nil,REASON_EFFECT)
end
function c2150014.tgb(e,c)return BiDiuF(c)end
function c2150014.cnb(e)return e:GetHandler():GetOverlayCount()<1 end
