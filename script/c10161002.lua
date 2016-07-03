--双龙咆哮
function c10161002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c10161002.cost)
	e1:SetTarget(c10161002.target)
	e1:SetOperation(c10161002.activate)
	c:RegisterEffect(e1) 
end

function c10161002.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,10161002)==0 end
	Duel.RegisterFlagEffect(tp,10161002,0,0,0)
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end


function c10161002.filter1(c)
	return c:IsSetCard(0x9333) and c:GetLevel()==9 and c:IsAbleToHand()
end

function c10161002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c10161002.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)
	if chk==0 then return g:GetCount()>=2 and g:GetClassCount(Card.GetAttribute)>=2 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function c10161002.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c10161002.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)
	if g1:GetCount()<=0 or g1:GetClassCount(Card.GetAttribute)<=2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=g1:Select(tp,1,1,nil)
	g1:Remove(Card.IsAttribute,nil,tg:GetFirst():GetAttribute())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=g1:Select(tp,1,1,nil):GetFirst()   
	tg:AddCard(tc)
	  Duel.SendtoHand(tg,nil,REASON_EFFECT)
	  Duel.ConfirmCards(1-tp,tg)
end
