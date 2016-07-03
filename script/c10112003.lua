--炼金生命体·青
function c10112003.initial_effect(c)
	--become material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c10112003.condition)
	e1:SetOperation(c10112003.operation)
	c:RegisterEffect(e1)	
end

function c10112003.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL or r==REASON_FUSION or r==REASON_SYNCHRO or r==REASON_XYZ 
end

function c10112003.operation(e,tp,eg,ep,ev,re,r,rp)
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
	local rc=sg:GetFirst()
	while rc do
		--if rc:GetFlagEffect(10112003)==0 then
		  if rc:IsType(TYPE_RITUAL) then
			--spsummon
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(10112003,0))
			e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
			e1:SetCode(EVENT_TO_GRAVE)
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetCondition(c10112003.spcon)
			e1:SetTarget(c10112003.sptg)
			e1:SetOperation(c10112003.spop)
			e1:SetReset(RESET_EVENT+0x00102000)
			rc:RegisterEffect(e1,true)
		  end
		  if rc:IsType(TYPE_FUSION) then
			--spsummon2
			local e2=Effect.CreateEffect(c)
			e2:SetDescription(aux.Stringid(10112003,0))
			e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
			e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
			e2:SetCode(EVENT_BATTLE_DESTROYING)
			e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CLIENT_HINT)
			e2:SetCondition(aux.bdocon)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetTarget(c10112003.sptg2)
			e2:SetOperation(c10112003.spop2)
			rc:RegisterEffect(e2,true)
		  end
		  if rc:IsType(TYPE_SYNCHRO) then
			--draw
			local e3=Effect.CreateEffect(c)
			e3:SetDescription(aux.Stringid(10112003,0))
			e3:SetCategory(CATEGORY_DRAW)
			e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
			e3:SetRange(LOCATION_MZONE)
			e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
			e3:SetCode(EVENT_PHASE+PHASE_END)
			e3:SetCountLimit(1)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			e3:SetCondition(c10112003.drcon)
			e3:SetTarget(c10112003.drtg)
			e3:SetOperation(c10112003.drop)
			rc:RegisterEffect(e3,true)
		  end
		  if rc:IsType(TYPE_XYZ) then
			--Remove
			local e4=Effect.CreateEffect(rc)
			e4:SetDescription(aux.Stringid(10112003,0))
			e4:SetCategory(CATEGORY_REMOVE)
			e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
			e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CLIENT_HINT)
			e4:SetCode(EVENT_ATTACK_ANNOUNCE)
			e4:SetReset(RESET_EVENT+0x1fe0000)
			e4:SetTarget(c10112003.rmtg)
			e4:SetOperation(c10112003.rmop)
			rc:RegisterEffect(e4,true)
		  end
			  --rc:RegisterFlagEffect(10112003,RESET_EVENT+0x1fe0000,0,1)
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
function c10112003.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end

function c10112003.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end

function c10112003.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end

function c10112003.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end

function c10112003.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end

function c10112003.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

function c10112003.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==4
end

function c10112003.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c10112003.spfilter(chkc,e,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c10112003.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c10112003.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
	  Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c10112003.spcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_DESTROY)~=0
end

function c10112003.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c10112003.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end

