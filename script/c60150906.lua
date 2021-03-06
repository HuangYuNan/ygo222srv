--幻想曲T致命旋律 荒芜
function c60150906.initial_effect(c)
Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,60150906)
	e2:SetCondition(c60150906.sscon)
	e2:SetTarget(c60150906.sstg)
	e2:SetOperation(c60150906.ssop)
	c:RegisterEffect(e2)
	--atkup
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c60150906.atkup)
	c:RegisterEffect(e5)
	--xyzlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e3:SetValue(c60150906.xyzlimit)
	c:RegisterEffect(e3)
end
function c60150906.tfilter(c)
	return not c:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c60150906.sscon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c60150906.tfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c60150906.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,60150993,0,0x4011,1600,2000,6,RACE_FAIRY,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c60150906.ssop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,60150993,0,0x4011,1600,2000,6,RACE_FAIRY,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,60150993)
	if Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)>0 then
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) then return end
		Duel.SendtoDeck(c,1-tp,2,REASON_EFFECT)
		if not c:IsLocation(LOCATION_DECK) then return end
		Duel.ShuffleDeck(1-tp)
		c:ReverseInDeck()
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(60150906,1))
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_TO_HAND)
		e1:SetCondition(c60150906.spcon)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
		e1:SetTarget(c60150906.sptg)
		e1:SetOperation(c60150906.spop)
		e1:SetReset(RESET_EVENT+0x1de0000)
		c:RegisterEffect(e1)
	end
end
function c60150906.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DRAW)
end
function c60150906.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60150906.filter(c)
	return c:IsFaceup()
end
function c60150906.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
	if c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.Destroy(c,REASON_EFFECT)
		local g=Duel.GetMatchingGroup(c60150906.filter,1-tp,0,LOCATION_ONFIELD,nil)
		if g:GetCount()>0 then
			if Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
				Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
			end
		end
	else
		Duel.Destroy(c,REASON_RULE)
	end
	end
end
function c60150906.atkfilter(c)
	return c:IsFaceup() 
end
function c60150906.atkup(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*600
end
function c60150906.xyzlimit(e,c)
	if not c then return false end
	return not (c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_DARK))
end