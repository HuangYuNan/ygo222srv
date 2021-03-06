--神天竜－イラップト
require "expansions/script/c9990000"
function c9991214.initial_effect(c)
	Dazz.GodraExtraCommonEffect(c,19991214)
	--Fusion
	aux.AddFusionProcFun2(c,function(c) return Dazz.IsGodra(c,Card.GetFusionCode) end,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE),true)
	c:EnableReviveLimit()
	--Damage & Draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991214,1))
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,29991214)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(function(e)
		e:SetLabel(1)
		return true
	end)
	e1:SetTarget(c9991214.ctg)
	e1:SetOperation(c9991214.cop)
	c:RegisterEffect(e1)
end
c9991214.Dazz_name_godra=true
function c9991214.cfilter(c)
	return c:IsRace(RACE_WYRM) and c:IsAbleToRemoveAsCost()
end
function c9991214.ctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==1 then e:SetLabel(0) else return false end
		return Duel.IsExistingMatchingCard(c9991214.cfilter,tp,LOCATION_GRAVE,0,1,nil)
			and Duel.IsPlayerCanDraw(tp,1)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local cc=Duel.SelectMatchingCard(tp,c9991214.cfilter,tp,LOCATION_GRAVE,0,1,1,nil):GetFirst()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(cc:GetAttack())
	Duel.Remove(cc,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,cc:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c9991214.cop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Damage(p,d,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end