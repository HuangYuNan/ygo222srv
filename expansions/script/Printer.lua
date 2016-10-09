--created by puzzle edit
Debug.SetAIName("Printer by Nanahira")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)
local g=Group.CreateGroup()
local n=1
function op(e,tp,eg,ep,ev,re,r,rp)
	local lc=e:GetLabel()
	local p=e:GetHandler():GetOwner()
	local cd=Duel.AnnounceCard(0)
	local d=Duel.CreateToken(p,cd)
	if lc==1 then
		Duel.SendtoDeck(d,nil,0,0x400)
	elseif lc==2 then
		Duel.SendtoHand(d,nil,0x400)
	elseif bit.band(lc,12)>0 then
		Duel.MoveToField(d,p,p,lc,5,true)
	elseif lc==16 then
		Duel.SendtoGrave(d,0x400)
	elseif lc==32 then
		Duel.Remove(d,5,0x400)
	elseif lc==64 then
		Duel.SendtoExtraP(d,nil,0x400)
	end
end
function efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
local g=Group.CreateGroup()
g:KeepAlive()
function reg(c,n)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(0x41500)
	e2:SetRange(0xff)
	e2:SetLabel(n)
	e2:SetOperation(op)
	c:RegisterEffect(e2)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetProperty(0x40500)
	e4:SetValue(efilter)
	c:RegisterEffect(e4)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE)
	e6:SetProperty(0x40500)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
while n<=64 do
	local a0=Debug.AddCard(37564765,0,0,n,0,POS_FACEUP_ATTACK)
	local a1=Debug.AddCard(37564765,1,1,n,0,POS_FACEUP_ATTACK)
	if n==1 then
		g:AddCard(a0)
		g:AddCard(a1)
	end
	reg(a0,n)
	reg(a1,n)
	n=n*2
end
local ex=Effect.GlobalEffect()
ex:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
ex:SetCode(EVENT_ADJUST)
ex:SetLabelObject(g)
ex:SetOperation(function(e,tp)
	local d=e:GetLabelObject()
	d:ForEach(function(c)
		c:ReverseInDeck()
	end)
end)
Duel.RegisterEffect(ex,0)
local ex=Effect.GlobalEffect()
ex:SetType(EFFECT_TYPE_FIELD)
ex:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
ex:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
ex:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
Duel.RegisterEffect(ex,0)
local ex=Effect.GlobalEffect()
ex:SetType(EFFECT_TYPE_FIELD)
ex:SetCode(EFFECT_TRAP_ACT_IN_HAND)
ex:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
Duel.RegisterEffect(ex,0)
Debug.ReloadFieldEnd()