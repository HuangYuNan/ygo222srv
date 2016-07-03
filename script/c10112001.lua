--炼金生命体·赤
function c10112001.initial_effect(c)
	--become material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c10112001.condition)
	e2:SetOperation(c10112001.operation)
	c:RegisterEffect(e2)	
end

function c10112001.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL or r==REASON_FUSION or r==REASON_SYNCHRO or r==REASON_XYZ 
end

function c10112001.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Group.CreateGroup()
	if r==REASON_SYNCHRO or r==REASON_XYZ then
	  if re and (re:GetHandler():GetOriginalCode()==10112011 or re:GetHandler():GetOriginalCode()==10112015) and wocao[0]:GetCount()>0 then
	   sg:Merge(wocao[0])
	   wocao[0]:DeleteGroup()
	  else 
	   sg:AddCard(c:GetReasonCard())
	  end
	end
	if r==REASON_RITUAL or r==REASON_FUSION then
	  sg:Merge(eg)
	end
	 rc=sg:GetFirst()
	 while rc do
		--if rc:GetFlagEffect(10112001)==0 then
		  if rc:IsType(TYPE_RITUAL) then
			--directatk
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetDescription(aux.Stringid(10112001,0))
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetCode(EFFECT_DIRECT_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e1,true)
		  end
		  if rc:IsType(TYPE_FUSION) then
			--mu atk
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_EXTRA_ATTACK)
			e2:SetDescription(aux.Stringid(10112001,0))
			e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(1)
			rc:RegisterEffect(e2,true)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			e3:SetCondition(c10112001.atkcon)
			rc:RegisterEffect(e3,true)
		  end
		  if rc:IsType(TYPE_SYNCHRO) then
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_PIERCE)
			e4:SetDescription(aux.Stringid(10112001,0))
			e4:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e4:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e4,true)
		  end
		  if rc:IsType(TYPE_XYZ) then
			--double
			local e5=Effect.CreateEffect(c)
			e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e5:SetCode(EVENT_PRE_BATTLE_DAMAGE)
			e5:SetCondition(c10112001.damcon)
			e5:SetOperation(c10112001.damop)
			e5:SetDescription(aux.Stringid(10112001,0))
			e5:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e5:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e5,true)
		  end
			--rc:RegisterFlagEffect(10112001,RESET_EVENT+0x1fe0000,0,1)
			  if not rc:IsType(TYPE_EFFECT) then
			  local e8=Effect.CreateEffect(c)
			  e8:SetType(EFFECT_TYPE_SINGLE)
			  e8:SetCode(EFFECT_ADD_TYPE)
			  e8:SetValue(TYPE_EFFECT)
			  e8:SetReset(RESET_EVENT+0x1fe0000)
			  rc:RegisterEffect(e8,true)
			  end
		--end
		rc=sg:GetNext()
	 end
end

function c10112001.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():GetBattleTarget()~=nil
end

function c10112001.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end

function c10112001.atkcon(e)
	return e:GetHandler():IsDirectAttacked()
end