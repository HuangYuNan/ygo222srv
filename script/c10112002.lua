--炼金生命体·赭
function c10112002.initial_effect(c)
	--become material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c10112002.condition)
	e2:SetOperation(c10112002.operation)
	c:RegisterEffect(e2)	
end

function c10112002.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL or r==REASON_FUSION or r==REASON_SYNCHRO or r==REASON_XYZ 
end

function c10112002.operation(e,tp,eg,ep,ev,re,r,rp)
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
		--if rc:GetFlagEffect(10112002)==0 then
		  if rc:IsType(TYPE_RITUAL) then
			--untar
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(10112002,0))
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
			e1:SetValue(aux.tgval)
			e1:SetRange(LOCATION_MZONE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e1,true)
		  end
		  if rc:IsType(TYPE_FUSION) then
			--monsterimmue
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetDescription(aux.Stringid(10112002,0))
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EFFECT_IMMUNE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(c10112002.efilter1)
			rc:RegisterEffect(e2,true)
		  end
		  if rc:IsType(TYPE_SYNCHRO) then
			--spellimmue
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetDescription(aux.Stringid(10112002,0))
			e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
			e3:SetRange(LOCATION_MZONE)
			e3:SetCode(EFFECT_IMMUNE_EFFECT)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			e3:SetValue(c10112002.efilter2)
			rc:RegisterEffect(e3,true)
		  end
		  if rc:IsType(TYPE_XYZ) then
			--trapimmue
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetDescription(aux.Stringid(10112002,0))
			e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
			e4:SetRange(LOCATION_MZONE)
			e4:SetCode(EFFECT_IMMUNE_EFFECT)
			e4:SetReset(RESET_EVENT+0x1fe0000)
			e4:SetValue(c10112002.efilter3)
			rc:RegisterEffect(e4,true)
		  end
			--rc:RegisterFlagEffect(10112002,RESET_EVENT+0x1fe0000,0,1)
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

function c10112002.efilter3(e,te)
	return te:IsActiveType(TYPE_TRAP)
end

function c10112002.efilter2(e,te)
	return te:IsActiveType(TYPE_SPELL)
end

function c10112002.efilter1(e,te)
	return te:IsActiveType(TYPE_MONSTER)
end
