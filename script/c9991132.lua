--Catacomb Sifter
require "expansions/script/c9990000"
function c9991132.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,nil,nil)
	--Devoid
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ex:SetRange(LOCATION_MZONE)
	ex:SetCode(EFFECT_ADD_ATTRIBUTE)
	ex:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(ex)
	--Shuffle Back
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local g1=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,nil)
		local g2=Duel.GetFieldGroup(tp,LOCATION_REMOVED,0)
		if chk==0 then return g1:GetCount()+g2:GetCount()>0 end
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,g1:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g2,g2:GetCount(),0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g1=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,nil)
		Duel.SendtoDeck(g1,nil,2,REASON_EFFECT)
		local g2=Duel.GetFieldGroup(tp,LOCATION_REMOVED,0)
		Duel.SendtoGrave(g2,REASON_EFFECT+REASON_RETURN)
	end)
	c:RegisterEffect(e1)
	--Scry self
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9991132,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
			and not c:IsReason(REASON_RETURN)
	end)
	e2:SetOperation(c9991132.scry)
	c:RegisterEffect(e2)
	--Scry others
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(9991132,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg:IsExists(function(c,tp)
			return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
				and not c:IsReason(REASON_RETURN)
		end,1,nil,tp)
	end)
	e3:SetOperation(c9991132.scry)
	c:RegisterEffect(e3)
end
function c9991132.scry(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.ConfirmCards(tp,g)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==1 then return end
	if Duel.SelectYesNo(tp,aux.Stringid(9991132,1)) then
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(9991132,2))
		Duel.MoveSequence(g:GetFirst(),1)
	else
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(9991132,3))
	end
end