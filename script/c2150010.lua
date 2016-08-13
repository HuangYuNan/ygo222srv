require 'script.c2150000'
function c2150010.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	a:SetCode(EVENT_PHASE+PHASE_END)
	a:SetRange(LOCATION_DECK)
	a:SetCountLimit(1,2150010)
	a:SetCategory(CATEGORY_DRAW)
	a:SetCost(c2150010.coa)
	a:SetOperation(c2150010.opa)
	c:RegisterEffect(a)
	if c2150010.chk then return end
	c2150010.chk=true
	a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	a:SetCode(EVENT_TO_GRAVE)
	a:SetOperation(c2150010.opb)
	Duel.RegisterEffect(a,0)
	c2150010[0]=0
	c2150010[1]=0
	c2150010[2]=0
	c2150010[3]=0
end
function c2150010.coa(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c2150010[tp]==Duel.GetTurnCount()and e:GetHandler():IsAbleToGraveAsCost()and Duel.IsPlayerCanDraw(tp,1)end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c2150010.opa(e,tp)Duel.Draw(tp,1,REASON_EFFECT)end
function c2150010.opb(e,tp,eg,ep,ev,re)
	if not re or not BiDiuF(re:GetHandler())then return end
	for i=0,1 do
		local g=eg:Filter(Card.IsControler,nil,i)
		g=g:Filter(BiDiuF,nil)
		if g:GetCount()>0 then
			if c2150010[i]~=Duel.GetTurnCount()then c2150010[i]=Duel.GetTurnCount()c2150010[i+2]=0 end
			c2150010[i+2]=c2150010[i+2]+g:GetCount()
			Debug.Message(c2150010[i]..' + '..c2150010[i+2])
		end
	end
end
