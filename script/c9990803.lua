--眠れる古き竜（ドーマント・ワイラム）
function c9990803.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9990803.target)
	e1:SetOperation(c9990803.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c9990803.handcon)
	c:RegisterEffect(e2)
end
function c9990803.confilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsRace(RACE_WYRM)
end
function c9990803.handcon(e)
	return Duel.GetMatchingGroupCount(c9990803.confilter,e:GetHandler():GetControler(),LOCATION_GRAVE,0,nil)==0
end
function c9990803.filter(c,tp)
	return c:IsAbleToDeck() and c:IsType(TYPE_MONSTER) and Duel.GetLocationCount(c:GetOwner(),LOCATION_MZONE)~=0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,9990804,0,0x5011,0,0,2,0x800000,0x20,0x4,c:GetOwner())
end
function c9990803.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c9990803.filter(chkc,tp) and chkc:IsLocation(LOCATION_GRAVE) end
	if chk==0 then return Duel.IsExistingTarget(c9990803.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c9990803.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c9990803.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e):GetFirst()
	if not tc then return end
	local race=tc:GetRace()
	local tkp=tc:GetOwner()
	if Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)~=0 then
		if Duel.GetLocationCount(tkp,LOCATION_MZONE)==0
			or not Duel.IsPlayerCanSpecialSummonMonster(tp,9990804,0,0x5011,0,0,2,0x800000,0x20,0x4,tkp) then return end
		Duel.BreakEffect()
		local token=Duel.CreateToken(tp,9990804)
		Duel.SpecialSummonStep(token,0,tp,tkp,false,false,POS_FACEUP_DEFENSE)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e1:SetValue(c9990803.synlimit)
		e1:SetLabel(race)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
		--run for race text
		local val=1020
		local level=0x1
		while level<=0x100000 do
			for i=0,3 do
				if bit.band(race,(2^i)*level)~=0 then
					token:RegisterFlagEffect(9990803,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,val)
				else
					val=val+1
				end
			end
			level=level*0x10
		end
		Duel.SpecialSummonComplete()
	end
end
function c9990803.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(e:GetLabel())
end