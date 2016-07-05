--扑克魔术 蔓越莓
function c66612304.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c66612304.pucon)
	e1:SetCost(c66612304.cost)
	e1:SetOperation(c66612304.operation)
	c:RegisterEffect(e1)
	--[[if not c66612304.global_check then
		c66612304.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66612304.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66612304.clear)
		Duel.RegisterEffect(ge2,0)
	end--]]
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66612304,3))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c66612304.con)
	e2:SetTarget(c66612304.butg)
	e2:SetOperation(c66612304.buop)
	e2:SetCountLimit(1)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(66612304,4))
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c66612304.setg)
	e3:SetOperation(c66612304.seop)
	c:RegisterEffect(e3)
end
function c66612304.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x660) then
			c66612304[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c66612304.clear(e,tp,eg,ep,ev,re,r,rp)
	c66612304[0]=true
	c66612304[1]=true
end
function c66612304.pucon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c66612304.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() and  Duel.GetFlagEffect(tp,66612301)==0 end
	Duel.RegisterFlagEffect(tp,66612301,RESET_PHASE+PHASE_END,0,1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e:GetHandler():RegisterEffect(e1)
end
function c66612304.operation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_CARD,0,66612362)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c66612304.con)
	e1:SetOperation(c66612304.op)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
end
function c66612304.filter(c,tp)
	return c:IsSetCard(0x660) and c:IsControler(tp) and  c:IsType(TYPE_MONSTER) 
end
function c66612304.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c66612304.filter,1,nil,tp)
end
function c66612304.gvfilter(c)
	return c:IsSetCard(0x660) and c:IsFaceup() 
end
function c66612304.op(e,tp,eg,ep,ev,re,r,rp)
   Duel.Hint(HINT_CARD,0,66612304)
   local g=Duel.GetMatchingGroup(c66612304.gvfilter,tp,LOCATION_MZONE,0,nil)
   local tc=g:GetFirst()
   while tc do
    local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(200)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1,true)
   tc=g:GetNext()
   end
end
function c66612304.thfilter(c)
	return c:IsSetCard(0x660) and c:IsAbleToHand() and  c:IsType(TYPE_MONSTER) 
end
function c66612304.butg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
		Duel.IsExistingMatchingCard(c66612304.thfilter,tp,LOCATION_REMOVED,0,1,nil) or
		eg:GetFirst():IsFaceup()
	end
	local t={}
	local p=1
	if eg:GetFirst():IsFaceup() then t[p]=aux.Stringid(66612304,0) p=p+1 end
	if	Duel.IsExistingMatchingCard(c66612304.thfilter,tp,LOCATION_REMOVED,0,1,nil) then t[p]=aux.Stringid(66612304,1) p=p+1 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612304,2))
	local sel=Duel.SelectOption(tp,table.unpack(t))+1
	local opt=t[sel]-aux.Stringid(66612304,0)
	local sg=nil
	if opt==1 then 
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
	end
	e:SetLabel(opt)
end
function c66612304.buop(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local sg=nil
	if opt==0 then 
	local sg=eg:Filter(c66612304.filter,nil,tp)
	local tg=sg:GetFirst()
	while tg do
	if tg:IsFaceup() and not tg:IsImmuneToEffect(e) then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(66612304,5))
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	tg:RegisterEffect(e1)
	tg=sg:GetNext()
	end
	end
	else 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=Duel.SelectMatchingCard(tp,c66612304.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	if sg:GetCount()>0 then
    Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
end
function c66612304.sefilter(c)
	return c:GetCode()==66612318 and c:IsAbleToHand()
end
function c66612304.setg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612304.sefilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end
function c66612304.seop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstMatchingCard(c66612304.sefilter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end