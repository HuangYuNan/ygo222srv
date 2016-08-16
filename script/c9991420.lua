--遺忘暉撃
function c9991420.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,4,nil)
			and Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>0 end
		local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,4)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.DiscardHand(tp,Card.IsDiscardable,4,4,REASON_EFFECT+REASON_DISCARD)~=4 then return end
		local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
		Duel.Remove(g,POS_FACEUP,REASON_RULE)
	end)
	c:RegisterEffect(e1)
	--Miracle
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetCode(EVENT_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		return Duel.GetFlagEffect(tp,9991420)==0 and eg:IsContains(c)
	end)
	e2:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
		Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>0 end
		local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
		Duel.Remove(g,POS_FACEUP,REASON_RULE)
	end)
	c:RegisterEffect(e2)
	if not c9991420.miracle_check then
		c9991420.miracle_check=true
		local ex=Effect.GlobalEffect()
		ex:SetCode(EVENT_DRAW)
		ex:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ex:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local t={[0]=false,[1]=false}
			eg:ForEach(function(tc)
				local cp=tc:GetControler()
				t[cp]=true
			end)
			for i=0,1 do
				if t[i] then
					Duel.RegisterFlagEffect(i,9991420,RESET_PHASE+PHASE_END,0,1)
				end
			end
		end)
		Duel.RegisterEffect(ex,0)
	end
end