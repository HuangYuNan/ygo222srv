--宝具 无毁的湖光
function c99999980.initial_effect(c)
	c:SetUniqueOnField(1,0,99999980)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99991099,6))
    e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c99999980.target)
	e1:SetOperation(c99999980.operation)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetValue(1)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c99999980.eqlimit)
	c:RegisterEffect(e3)
	--Atk,def up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(500)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	e5:SetValue(500)
	c:RegisterEffect(e5)
    --when went
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCountLimit(1,99999980+EFFECT_COUNT_CODE_OATH)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetTarget(c99999980.wwtg)
	e6:SetOperation(c99999980.wwop)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
    e7:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e7)
	--[[search card
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(999999,7))
	e8:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetRange(LOCATION_HAND)
	e8:SetCost(c99999980.secost)
	e8:SetTarget(c99999980.setarget)
	e8:SetOperation(c99999980.seoperation)
	c:RegisterEffect(e8)--]]
	--atk
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_EQUIP)
	e9:SetCode(EFFECT_UPDATE_ATTACK)
	e9:SetValue(700)
	e9:SetCondition(c99999980.atkcon)
	c:RegisterEffect(e9)
	--
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_EQUIP)
	e10:SetCode(EFFECT_CANNOT_TRIGGER)
	c:RegisterEffect(e10)
	--to hand
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetCategory(CATEGORY_TOHAND)
	e11:SetRange(LOCATION_SZONE)
	e11:SetCountLimit(1,99999980+EFFECT_COUNT_CODE_OATH)
	e11:SetTarget(c99999980.thtg)
	e11:SetOperation(c99999980.thop)
	c:RegisterEffect(e11)
end
function c99999980.eqlimit(e,c)
	return  c:IsCode(99999985) or c:IsSetCard(0x2e3)  or  c:IsCode(99999987)
end
function c99999980.filter(c)
	return c:IsFaceup() and (c:IsCode(99999985)  or c:IsSetCard(0x2e3)   or  c:IsCode(99999987))
end
function c99999980.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c99999980.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99999980.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c99999980.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c99999980.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c99999980.hfilter(c)
	return (c:IsSetCard(0x2e0) or c:IsSetCard(0x2e1)  or c:IsSetCard(0x2e6) or c:IsSetCard(0x2e7)) and c:GetCode()~=99999980 and c:IsAbleToHand()
end
function c99999980.wwtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c99999980.hfilter,tp,LOCATION_REMOVED,0,1,nil)	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c99999980.hfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,c,2,0,0)
end
function c99999980.wwop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	Duel.SendtoHand(tc,nil,1,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,tc)
	end
	if e:GetHandler():IsRelateToEffect(e) then
	Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	end
end
--[[function c99999980.secost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() and Duel.GetFlagEffect(tp,99999980)==0 and
	Duel.GetFlagEffect(tp,99999985)==0 end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
    Duel.RegisterFlagEffect(tp,99999980,RESET_PHASE+PHASE_END,0,1)
	Duel.RegisterFlagEffect(tp,99999985,RESET_PHASE+PHASE_END,0,1)
end
function c99999980.sefilter(c)
	return c:GetCode()==99999985 and c:IsAbleToHand()
end
function c99999980.setarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c99999980.sefilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c99999980.seoperation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetFirstMatchingCard(c99999980.sefilter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
--]]
function c99999980.atkcon(e,tp,eg,ep,ev,re,r,rp)
    local ec=e:GetHandler():GetEquipTarget()
	local ph=Duel.GetCurrentPhase()
	local dt=nil
	if ec==Duel.GetAttacker() then dt=Duel.GetAttackTarget()
	elseif ec==Duel.GetAttackTarget() then dt=Duel.GetAttacker() end
	return dt and ec:IsRelateToBattle() and (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and (dt:IsRace(RACE_DRAGON)) 
end
function c99999980.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c99999980.thop(e,tp,eg,ep,ev,re,r,rp)
      if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	if  c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end