--Sludge Crawler
function c9991111.initial_effect(c)
	--Devoid
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ex:SetRange(LOCATION_MZONE)
	ex:SetCode(EFFECT_ADD_ATTRIBUTE)
	ex:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(ex)
	--Eldrazi Tuner Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,9991111)
	e1:SetCondition(function(e,c)
		if c==nil then return true end
		local tp=c:GetControler()
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)>0
	end)
	c:RegisterEffect(e1)
	--Draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return not e:GetHandler():IsReason(REASON_RETURN)
	end)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if not Duel.IsPlayerCanDraw(tp,1) or not Duel.SelectYesNo(tp,aux.Stringid(9991111,0)) then return end
		if Duel.Draw(tp,1,REASON_EFFECT)~=0 then
			Duel.BreakEffect()
			local hg=Duel.GetMatchingGroup(Card.IsDiscardable,tp,LOCATION_HAND,0,nil)
			if hg:GetCount()~=0 then
				if hg:GetCount()>1 then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
					hg=hg:Select(tp,1,1,nil)
				end
				Duel.SendtoGrave(hg,REASON_DISCARD+REASON_EFFECT)
			end
		end
	end)
	c:RegisterEffect(e3)
end