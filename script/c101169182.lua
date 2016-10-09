--空明-樱守姬此芽
function c101169182.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101169182,2))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c101169182.rtarget)
	e1:SetOperation(c101169182.roperation)
	c:RegisterEffect(e1)
	local e4=e1:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101169182,0))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c101169182.sumcon)
	e2:SetTarget(c101169182.sumtg)
	e2:SetOperation(c101169182.sumop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(101169182,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	--e3:SetCountLimit(1)
	e3:SetCondition(c101169182.sumcon)
	e3:SetTarget(c101169182.target)
	e3:SetOperation(c101169182.activate)
	c:RegisterEffect(e3)
end
function c101169182.zfilter(c)
	return true
end
function c101169182.sumcon(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c101169182.zfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=sg:GetFirst()
	if not tc then return false end
	while tc do
		if tc:GetCardTarget():GetCount()>0 and tc:GetOriginalCode()==101169182 then
			return false
		end
		tc=sg:GetNext()
	end
	return true
end
function c101169182.sumfilter(c)
	return c:IsSetCard(0xf1) and c:IsSummonable(true,nil,1)
end
function c101169182.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101169182.sumfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c101169182.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c101169182.sumfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
function c101169182.filter(c,lv)
	return c:IsSetCard(0xf1) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and c:GetLevel()<lv
end
function c101169182.filter2(c,lv)
	return c:IsSetCard(0xf1) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and c:GetLevel()==lv
end
function c101169182.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101169182.filter,tp,LOCATION_DECK,0,1,nil,e:GetHandler():GetLevel()) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c101169182.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local t={}
	local i=1
	local p=1
	local lv=c:GetLevel()-1
	for i=1,lv do
		if Duel.IsExistingMatchingCard(c101169182.filter2,tp,LOCATION_DECK,0,1,nil,i) then t[p]=i p=p+1 end
	end
	t[p]=nil
	local slv=Duel.AnnounceNumber(tp,table.unpack(t))
	local g=Duel.SelectMatchingCard(tp,c101169182.filter2,tp,LOCATION_DECK,0,1,1,nil,slv)
	if g:GetCount()>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-slv)
		c:RegisterEffect(e1)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c101169182.rfilter(c,ec)
	return not ec:IsHasCardTarget(c)
end
function c101169182.rtarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc~=c and c101169182.rfilter(chkc,c) end
	if chk==0 then return Duel.IsExistingTarget(c101169182.rfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c101169182.rfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c,c)
end
function c101169182.roperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		--replace
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_QUICK_F)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetCode(EVENT_CHAINING)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(c101169182.acondition)
		e1:SetTarget(c101169182.atarget)
		e1:SetOperation(c101169182.aoperation)
		c:RegisterEffect(e1)
	end
end
function c101169182.acondition(e,tp,eg,ep,ev,re,r,rp)
	if e==re or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsOnField() and tc:GetOwnerTarget():IsContains(e:GetHandler())
end
function c101169182.afilter(c,re,rp,tf,ceg,cep,cev,cre,cr,crp)
	return tf(re,rp,ceg,cep,cev,cre,cr,crp,0,c)
end
function c101169182.atarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	if chkc then return chkc:IsOnField() and c101169182.afilter(chkc,re,rp,tf,ceg,cep,cev,cre,cr,crp) end
	if chk==0 then return Duel.IsExistingTarget(c101169182.afilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp) end
end
function c101169182.aoperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetOwner()
	if tc:IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,Group.FromCards(tc))
	end
end
