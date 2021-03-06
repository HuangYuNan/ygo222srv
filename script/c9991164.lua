--奥札奇挪移体
require "expansions/script/c9990000"
function c9991164.initial_effect(c)
	--Xyz
	c:EnableReviveLimit()
	Dazz.AddXyzProcedureEldrazi(c,5,2,nil,nil)
	--Devoid
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ex:SetRange(LOCATION_MZONE)
	ex:SetCode(EFFECT_ADD_ATTRIBUTE)
	ex:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(ex)
	--Exile
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetHintTiming(0,0x1c0)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local g=Duel.GetFieldGroup(tp,0,LOCATION_REMOVED)
		if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST)
			and g:GetCount()>0 end
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		g=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(g,REASON_COST+REASON_RETURN)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)>0 end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		if sg:GetCount()==0 then return end
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=sg:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		local tc=sg:GetFirst()
		if tc:IsAbleToRemove() then
			Duel.Remove(tc,POS_FACEUP,REASON_RULE)
		else
			Duel.SendtoGrave(tc,REASON_RULE)
			return
		end
		local op=tc:GetOwner()
		local lab=0
		if op==Duel.GetTurnPlayer() and Duel.GetCurrentPhase()==PHASE_STANDBY then
			lab=1
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,lab+1)
		e1:SetCountLimit(1)
		e1:SetLabel(lab)
		e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
			return tp==Duel.GetTurnPlayer()
		end)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			if e:GetLabel()==1 then e:SetLabel(0) return end
			local tc=e:GetLabelObject()
			if Duel.GetLocationCount(cp,LOCATION_MZONE)==0 then return Duel.SendtoGrave(tc,REASON_RULE) end
			Duel.MoveToField(tc,cp,cp,LOCATION_MZONE,POS_FACEUP_DEFENSE,true)
		end)
		e1:SetLabelObject(tc)
		Duel.RegisterEffect(e1,op)
	end)
	c:RegisterEffect(e1)
end