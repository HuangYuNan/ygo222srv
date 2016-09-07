--約束された終末
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991031.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c9991031.target)
	e1:SetOperation(c9991031.activate)
	c:RegisterEffect(e1)
end
function c9991031.tgfilter(c)
	return c:IsFaceup() and Dazz.IsStellaris(c) and c:IsType(TYPE_SYNCHRO+TYPE_XYZ) and c:IsAbleToGrave()
end
function c9991031.spfilter(c,e,tp)
	return c:IsCode(9991021) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c9991031.confilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_PENDULUM+TYPE_SYNCHRO+TYPE_XYZ)
end
function c9991031.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local c=e:GetHandler()
	local v={
		Duel.IsExistingTarget(c9991031.tgfilter,tp,LOCATION_MZONE,0,3,nil)
			and Duel.IsExistingMatchingCard(c9991031.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp),
		Duel.IsExistingMatchingCard(c9991031.confilter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsPlayerCanDraw(tp,1)
	}
	if chk==0 then return v[1] or v[2] end
	local selt={tp}
	local keyt={}
	for i=1,2 do
		if v[i] then
			table.insert(selt,aux.Stringid(9991031,i-1))
			table.insert(keyt,i)
		end
	end
	local sel=keyt[Duel.SelectOption(table.unpack(selt))+1]
	c:RegisterFlagEffect(1,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991031,sel-1))
	if sel==1 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectTarget(tp,c9991031.tgfilter,tp,LOCATION_MZONE,0,3,3,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,3,0,0)
	else
		e:SetCategory(CATEGORY_DRAW)
		e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(1)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end
	e:SetLabel(sel)
end
function c9991031.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then
		local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e):Filter(Card.IsControler,nil,tp)
		if Duel.SendtoGrave(tg,REASON_EFFECT)~=3 then return end
		local sc=Duel.GetFirstMatchingCard(c9991031.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
		if sc and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			Duel.BreakEffect()
			Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)
		end
	else
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Draw(p,d,REASON_EFFECT)
	end
end
