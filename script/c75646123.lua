--究极幻象 宇宙之羽
function c75646123.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,0x2000),aux.NonTuner(Card.IsType,0x2000),1)
	c:EnableReviveLimit()
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(1)
	e1:SetProperty(0x20000)
	e1:SetRange(4)
	e1:SetCode(42)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(41)
	c:RegisterEffect(e2)
	--reflect battle dam
	local e3=Effect.CreateEffect(c)
	e3:SetType(1)
	e3:SetCode(202)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(1)
	e3:SetCode(194)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end