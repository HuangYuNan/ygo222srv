--救濟の神（ゴッド・サルヴェーション）-円環の理（ロー・オブ・サークル）
require "expansions/script/c9990000"
function c9991010.initial_effect(c)
	--Xyz
	c:EnableReviveLimit()
	Dazz.AddXyzProcedureLevelFree(c,function(c) return c:IsType(TYPE_SYNCHRO) and Dazz.IsVoid(c) end,3)
	local ex1=Effect.CreateEffect(c)
	ex1:SetType(EFFECT_TYPE_SINGLE)
	ex1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	c:RegisterEffect(ex1)
	local ex2=ex1:Clone()
	ex2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	ex2:SetCode(EFFECT_SPSUMMON_CONDITION)
	ex2:SetValue(aux.FALSE)
	c:RegisterEffect(ex2)
	--Arrow of Rule
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(9991010,0))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetHintTiming(0,TIMING_DRAW_PHASE)
	e4:SetCountLimit(1)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetTurnPlayer()~=tp
	end)
	e4:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
		Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	end)
	e4:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetTargetRange(0,1)
		e1:SetValue(aux.TRUE)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end)
	c:RegisterEffect(e4)
	--Salvation of Goddess
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(9991010,1))
	e5:SetCategory(CATEGORY_REMOVE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_BATTLE_START)
	e5:SetCountLimit(1,29991010)
	e5:SetTarget(c9991010.target2)
	e5:SetOperation(c9991010.operation2)
	c:RegisterEffect(e5)
	--Indestructibility
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e7)
end
function c9991010.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetBattleTarget() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler():GetBattleTarget(),1,0,0)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c9991010.operation2(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetHandler():GetBattleTarget():GetCode()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,0,0x5f,nil,code)
	local g1=g:Filter(Card.IsAbleToRemove,nil)
	g:Sub(g1)
	Duel.Remove(g1,POS_FACEUP,REASON_RULE)
	Duel.SendtoGrave(g,REASON_RULE)
	local hg1=Duel.GetFieldGroup(tp,0,LOCATION_HAND+LOCATION_ONFIELD)
	local hg2=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
	local hg3=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA):Filter(Card.IsFacedown,nil)
	if hg1:GetCount()~=0 then Duel.ConfirmCards(tp,hg1) Duel.ShuffleHand(1-tp) end
	if hg2:GetCount()~=0 then Duel.ConfirmCards(tp,hg2) Duel.ShuffleDeck(1-tp) end
	if hg3:GetCount()~=0 then Duel.ConfirmCards(tp,hg3) end
end