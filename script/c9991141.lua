--Bane of Bala Ged
require "expansions/script/c9990000"
function c9991141.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,7,nil)
	--Exile Field
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_COIN,nil,2,1-tp,LOCATION_ONFIELD)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
		if g:GetCount()>2 then
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_REMOVE)
			g=g:Select(1-tp,2,2,nil)
		end
		Duel.HintSelection(g)
		local g1=g:Filter(Card.IsAbleToRemove,nil)
		g:Sub(g1)
		Duel.Remove(g1,POS_FACEUP,REASON_RULE)
		Duel.SendtoGrave(g,REASON_RULE)
	end)
	c:RegisterEffect(e1)
end