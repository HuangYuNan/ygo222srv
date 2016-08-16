--原初之根
function c75646124.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(0x10)
	e1:SetCode(1002)
	e1:SetCountLimit(1,75646124+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c75646124.target)
	e1:SetOperation(c75646124.activate)
	c:RegisterEffect(e1)
end
function c75646124.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0x4,0x4,1,nil) end
end
function c75646124.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(3,tp,514)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0x4,0x4,1,10,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst() 
		while tc do
			if not tc:IsStatus(STATUS_SPSUMMON_TURN) then
			tc:SetStatus(STATUS_SPSUMMON_TURN,true) end
			Duel.SpecialSummon(tc,0,tp,tp,false,false,0x5)
			local e1=Effect.CreateEffect(tc)
			e1:SetProperty(0x20000)
			e1:SetRange(0x4) 
			tc:RegisterEffect(e1)
			Duel.RaiseSingleEvent(tc,1102,e1,0,tp,0,0)
			tc=g:GetNext()
		end
		Duel.RaiseEvent(g,1102,e,0,tp,0,0)
	end
end
