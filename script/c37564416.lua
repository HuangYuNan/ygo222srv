--百慕 甜蜜和声·莫娜
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564416.initial_effect(c)
	aux.AddXyzProcedure(c,senya.bmchkfilter,3,2,nil,nil,5)
	c:EnableReviveLimit()
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(37564416,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
	end)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCost(senya.bmrmcost)
	e4:SetTarget(c37564416.drtg)
	e4:SetOperation(c37564416.drop)
	c:RegisterEffect(e4)
	--destroy
	senya.atkdr(c,c37564416.regcon,c37564416.destg)
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_REMOVE)
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCountLimit(1)
	e8:SetCost(senya.rmovcost(3))
	e8:SetCondition(c37564416.regcon)
	e8:SetTarget(c37564416.tgtg)
	e8:SetOperation(c37564416.tgop)
	c:RegisterEffect(e8)
end
function c37564416.regcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffect(37564416)>0
end
function c37564416.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(aux.FALSE)
end
function c37564416.drop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(37564416,RESET_EVENT+0x1fe0000,0,1)
end
function c37564416.atlimit(e,c)
	return c~=e:GetHandler()
end
function c37564416.destg(c,ec)
	return not c:IsAttribute(ATTRIBUTE_WATER)
end
function c37564416.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToBattle() and not tc:IsImmuneToEffect(e) then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
function c37564416.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c37564416.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end