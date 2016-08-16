--破晓之淑女·珂奥丝
function c10957794.initial_effect(c)
	c:SetSPSummonOnce(10957794)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c10957794.xyzcon)
	e1:SetOperation(c10957794.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)  
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_ADD_ATTRIBUTE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(e2)  
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10957794,0))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,0x1e0)
	e3:SetCost(c10957794.rmcost)
	e3:SetTarget(c10957794.rmtg)
	e3:SetOperation(c10957794.rmop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10957794,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(c10957794.thcon)
	e4:SetTarget(c10957794.thtg)
	e4:SetOperation(c10957794.thop)
	c:RegisterEffect(e4)
end
function c10957794.mfilter2(c)
	return ( c:IsFaceup() and not c:IsType(TYPE_TOKEN) ) or not c:IsLocation(LOCATION_MZONE)
end
function c10957794.mfilter(c)
	local mg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_EXTRA,0,nil,10957794)
	local mgtg=mg:GetFirst()
	if mgtg then
		local jud=false
		local lvb=c10957794.lvchk()
		for i=2,lvb do
			if c:IsXyzLevel(mgtg,i) then jud=true end
			if jud then break end
		end
		return jud
	else
		return c:GetLevel()>=1
	end
end
function c10957794.xyzfilter1(c,g,slf)
	return g:IsExists(c10957794.xyzfilter2,1,c,c:GetLevel(),slf) 
end
function c10957794.xyzfilter2(c,lv,slf)
	return c:IsXyzLevel(slf,lv) and c:IsSetCard(0x239)
end
function c10957794.xyzcon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local jud=false
	local lvb=c10957794.lvchk()
	for i=2,lvb do
		if Duel.CheckXyzMaterial(c,nil,i,2,2,og) then jud=true end
		if jud then break end
	end
	return jud and Duel.GetLocationCount(tp,LOCATION_MZONE)>=-1
end
function c10957794.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	if og then
		c:SetMaterial(og)
		Duel.Overlay(c,og)
	else
		local ag=Duel.GetMatchingGroup(c10957794.mfilter2,tp,LOCATION_MZONE,0,nil)
		local pg=Group.CreateGroup()
		local chkpg=false
		local agtg=ag:GetFirst()
		local lvb=c10957794.lvchk()
		while agtg do
			chkpg=false
			for i=2,lvb do
				if Duel.CheckXyzMaterial(c,nil,i,1,1,Group.FromCards(agtg)) then pg:AddCard(agtg) chkpg=true end
				if chkpg then break end
			end
			agtg=ag:GetNext()
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g1=pg:FilterSelect(tp,c10957794.xyzfilter1,1,1,nil,pg,c)
		local tc1=g1:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g2=pg:FilterSelect(tp,c10957794.xyzfilter2,1,1,tc1,tc1:GetLevel(),c)
		g1:Merge(g2)
		c:SetMaterial(g1)
		Duel.Overlay(c,g1)
	end
end
c10957794.xyz_filter=c10957794.mfilter
c10957794.xyz_count=2
function c10957794.lvchk()
	local lv=13
	local lvmg=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	if lvmg:GetCount()>0 then
		local lvc=lvmg:GetMaxGroup(Card.GetLevel):GetFirst():GetLevel()
		if lvc>lv then lv=lvc end
	end
	return lv
end
function c10957794.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c10957794.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c10957794.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c10957794.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ and re:GetHandler():IsType(TYPE_SPELL)
end
function c10957794.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c10957794.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
