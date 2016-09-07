--ＳＡｒｋ（ステラライズ・アークエンジェル）・シェパード
function c9991012.initial_effect(c)
	--Xyz
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--Summon Success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9990322,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chk==0 then return Duel.IsExistingTarget(c9991012.rvfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=Duel.SelectTarget(tp,c9991012.rvfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		local tc=g:GetFirst()
		local sel=0
		if tc:IsType(TYPE_SPELL+TYPE_TRAP) then
			c:RegisterFlagEffect(1,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991012,4))
		elseif not tc:IsType(TYPE_PENDULUM) then
			sel=1
			c:RegisterFlagEffect(1,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991012,2))
		else
			local v1,v2=
				Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false),
				Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)
			if v1 and not v2 then
				sel=Duel.SelectOption(tp,aux.Stringid(9991012,2))+1
			elseif v2 and not v1 then
				sel=Duel.SelectOption(tp,aux.Stringid(9991012,3))
			elseif v1 and v2 then
				sel=1-Duel.SelectOption(tp,aux.Stringid(9991012,2),aux.Stringid(9991012,3))
			end
			c:RegisterFlagEffect(1,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991012,3-sel))
		end
		if sel==0 then
			Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
		else
			Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
		end
		e:SetLabel(sel)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local tc=Duel.GetFirstTarget()
		if not tc:IsRelateToEffect(e) then return end
		if e:GetLabel()==0 then
			if tc:IsType(TYPE_FIELD) or c:IsType(TYPE_CONTINUOUS) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
				Duel.SSet(tp,tc)
				Duel.ConfirmCards(1-tp,tc)
			elseif tc:IsType(TYPE_PENDULUM) then
				Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			end
		else
			if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end)
	c:RegisterEffect(e1)
	--Standby Phase
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(9990322,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetTurnPlayer()==tp
	end)
	c:RegisterEffect(e2)
end
c9991012.Dazz_name_stellaris="Archangel"
function c9991012.rvfilter(c,e,tp)
	if c:IsType(TYPE_FIELD) then return c:IsSSetable(true) end
	if c:IsType(TYPE_CONTINUOUS) then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and c:IsSSetable(true) end
	if c:IsType(TYPE_PENDULUM) and (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then return true end
	if c:IsType(TYPE_MONSTER) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return true end
	return false
end