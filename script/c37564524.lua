local m=37564524
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function cm.initial_effect(c)
	c:EnableReviveLimit()
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_SINGLE)
	e22:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e22:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e22)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(cm.spcon)
	e2:SetOperation(cm.spop)
	e2:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e2)
	senya.nnhr(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(cm.atkop)
	c:RegisterEffect(e1)
	senya.scopy(c,LOCATION_DECK,0,aux.FilterBoolFunction(Card.IsHasEffect,37564765),nil,nil,1,EFFECT_COUNT_CODE_SINGLE,nil,false)
end
function cm.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ
end
function cm.spfilter(c,sc,att)
	return c:IsFaceup() and c:IsType(att) and c:IsCanBeXyzMaterial(sc) and c:IsCode(37564765)
end
function cm.spfilter1(c,mg,sc,att)
	local catt=c:GetType()
	if bit.band(catt,att)==0 then return false end
	if bit.band(catt,att)==TYPE_RITUAL then att=att-TYPE_RITUAL end
	if bit.band(catt,att)==TYPE_FUSION then att=att-TYPE_FUSION end
	if bit.band(catt,att)==TYPE_SYNCHRO then att=att-TYPE_SYNCHRO end
	if bit.band(catt,att)==TYPE_XYZ then att=att-TYPE_XYZ end
	mg:RemoveCard(c)
	local ret=mg:IsExists(cm.spfilter2,1,nil,mg,sc,att)
	mg:AddCard(c)
	return ret and c:IsFaceup() and c:IsCanBeXyzMaterial(sc) and c:IsCode(37564765)
end
function cm.spfilter2(c,mg,sc,att)
	local catt=c:GetType()
	if bit.band(catt,att)==0 then return false end
	if bit.band(catt,att)==TYPE_RITUAL then att=att-TYPE_RITUAL end
	if bit.band(catt,att)==TYPE_FUSION then att=att-TYPE_FUSION end
	if bit.band(catt,att)==TYPE_SYNCHRO then att=att-TYPE_SYNCHRO end
	if bit.band(catt,att)==TYPE_XYZ then att=att-TYPE_XYZ end
	mg:RemoveCard(c)
	local ret=mg:IsExists(cm.spfilter3,1,nil,mg,sc,att)
	mg:AddCard(c)
	return ret and c:IsFaceup() and c:IsCanBeXyzMaterial(sc) and c:IsCode(37564765)
end
function cm.spfilter3(c,mg,sc,att)
	local catt=c:GetType()
	if bit.band(catt,att)==0 then return false end
	if bit.band(catt,att)==TYPE_RITUAL then att=att-TYPE_RITUAL end
	if bit.band(catt,att)==TYPE_FUSION then att=att-TYPE_FUSION end
	if bit.band(catt,att)==TYPE_SYNCHRO then att=att-TYPE_SYNCHRO end
	if bit.band(catt,att)==TYPE_XYZ then att=att-TYPE_XYZ end
	mg:RemoveCard(c)
	local ret=mg:IsExists(cm.spfilter4,1,nil,mg,sc,att)
	mg:AddCard(c)
	return ret and c:IsFaceup() and c:IsCanBeXyzMaterial(sc) and c:IsCode(37564765)
end
function cm.spfilter4(c,mg,sc,att)
	if bit.band(c:GetType(),att)==0 then return false end
	return c:IsFaceup() and c:IsCanBeXyzMaterial(sc) and c:IsCode(37564765)
end
function cm.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local att=TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ
	local mg=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,att)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		return mg:FilterCount(cm.spfilter1,nil,mg,c,att)>0
	else
		return Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_MZONE,0,1,nil,c,att) 
			and mg:FilterCount(cm.spfilter1,nil,mg,c,att)>0
	end
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local att=TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ
	local mg=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,att)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local rg1=mg:FilterSelect(tp,cm.spfilter1,1,1,nil,mg,c,att)
		local catt=rg1:GetFirst():GetType()
		if bit.band(catt,att)==TYPE_RITUAL then att=att-TYPE_RITUAL end
		if bit.band(catt,att)==TYPE_FUSION then att=att-TYPE_FUSION end
		if bit.band(catt,att)==TYPE_SYNCHRO then att=att-TYPE_SYNCHRO end
		if bit.band(catt,att)==TYPE_XYZ then att=att-TYPE_XYZ end
		mg:Sub(rg1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local rg2=mg:FilterSelect(tp,cm.spfilter2,1,1,nil,mg,c,att)
		catt=rg2:GetFirst():GetType()
		if bit.band(catt,att)==TYPE_RITUAL then att=att-TYPE_RITUAL end
		if bit.band(catt,att)==TYPE_FUSION then att=att-TYPE_FUSION end
		if bit.band(catt,att)==TYPE_SYNCHRO then att=att-TYPE_SYNCHRO end
		if bit.band(catt,att)==TYPE_XYZ then att=att-TYPE_XYZ end
		mg:Sub(rg2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local rg3=mg:FilterSelect(tp,cm.spfilter3,1,1,nil,mg,c,att)
		catt=rg3:GetFirst():GetType()
		if bit.band(catt,att)==TYPE_RITUAL then att=att-TYPE_RITUAL end
		if bit.band(catt,att)==TYPE_FUSION then att=att-TYPE_FUSION end
		if bit.band(catt,att)==TYPE_SYNCHRO then att=att-TYPE_SYNCHRO end
		if bit.band(catt,att)==TYPE_XYZ then att=att-TYPE_XYZ end
		mg:Sub(rg3)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local rg4=mg:FilterSelect(tp,cm.spfilter4,1,1,nil,mg,c,att)
		rg1:Merge(rg2)
		rg1:Merge(rg3)
		rg1:Merge(rg4)
		local tc=rg1:GetFirst()
		local sg=Group.CreateGroup()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=rg1:GetNext()
		end
		Duel.SendtoGrave(sg,REASON_RULE)
		c:SetMaterial(rg1)
		Duel.Overlay(c,rg1)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local rg1=Duel.SelectMatchingCard(tp,cm.spfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,c,att)
		local catt=rg1:GetFirst():GetType()
		if bit.band(catt,att)==TYPE_RITUAL then att=att-TYPE_RITUAL end
		if bit.band(catt,att)==TYPE_FUSION then att=att-TYPE_FUSION end
		if bit.band(catt,att)==TYPE_SYNCHRO then att=att-TYPE_SYNCHRO end
		if bit.band(catt,att)==TYPE_XYZ then att=att-TYPE_XYZ end
		mg:Sub(rg1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local rg2=mg:FilterSelect(tp,cm.spfilter2,1,1,nil,mg,c,att)
		catt=rg2:GetFirst():GetType()
		if bit.band(catt,att)==TYPE_RITUAL then att=att-TYPE_RITUAL end
		if bit.band(catt,att)==TYPE_FUSION then att=att-TYPE_FUSION end
		if bit.band(catt,att)==TYPE_SYNCHRO then att=att-TYPE_SYNCHRO end
		if bit.band(catt,att)==TYPE_XYZ then att=att-TYPE_XYZ end
		mg:Sub(rg2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local rg3=mg:FilterSelect(tp,cm.spfilter3,1,1,nil,mg,c,att)
		catt=rg3:GetFirst():GetType()
		if bit.band(catt,att)==TYPE_RITUAL then att=att-TYPE_RITUAL end
		if bit.band(catt,att)==TYPE_FUSION then att=att-TYPE_FUSION end
		if bit.band(catt,att)==TYPE_SYNCHRO then att=att-TYPE_SYNCHRO end
		if bit.band(catt,att)==TYPE_XYZ then att=att-TYPE_XYZ end
		mg:Sub(rg3)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local rg4=mg:FilterSelect(tp,cm.spfilter4,1,1,nil,mg,c,att)
		rg1:Merge(rg2)
		rg1:Merge(rg3)
		rg1:Merge(rg4)
		local tc=rg1:GetFirst()
		local sg=Group.CreateGroup()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=rg1:GetNext()
		end
		Duel.SendtoGrave(sg,REASON_RULE)
		c:SetMaterial(rg1)
		Duel.Overlay(c,rg1)
	end
end
function cm.rmfilter(c)
	return c:IsAbleToRemove()
end
function cm.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(cm.rmfilter,tp,0,LOCATION_EXTRA,nil)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local gc=g:Select(tp,1,1,nil):GetFirst()
	Duel.Remove(gc,POS_FACEUP,REASON_EFFECT)
		local tc=Duel.GetOperatedGroup():GetFirst()
		if tc then
			local cd=tc:GetOriginalCode()
			c:CopyEffect(cd,RESET_EVENT+0x1fe0000)
		end
end