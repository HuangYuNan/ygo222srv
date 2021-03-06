--Kindly Stranger
require "expansions/script/c9990000"
function c9990411.initial_effect(c)
	Dazz.DFCFrontsideCommonEffect(c)
	--Xyz
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	--Remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9990411,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,nil) end
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,0,1,tp,LOCATION_DECK)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
		local tc=g:GetFirst()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_REMOVED)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			Duel.SendtoGrave(e:GetHandler(),REASON_RETURN+REASON_EFFECT)
		end)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		tc:RegisterEffect(e1)
	end)
	c:RegisterEffect(e1)
	--Transform
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9990411,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0x1e0)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetOriginalCode()==9990411
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0)
		if chk==0 then
			for i=0,2 do
				if g:FilterCount(Card.IsType,nil,2^i)==0 then return false end
			end
			return Dazz.DFCTransformable(c,tp) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) or not Dazz.DFCTransformable(c,tp) then return end
		local token=Dazz.DFCTransformExecute(c,true)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
		local xg=Duel.GetFieldGroup(tp,LOCATION_GRAVE,LOCATION_GRAVE)
		if xg:GetCount()==0 then return end
		local xg=xg:Select(tp,1,3,nil)
		Duel.Overlay(token,xg)
	end)
	c:RegisterEffect(e2)
end