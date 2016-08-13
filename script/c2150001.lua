if not pcall(function() require("expansions/script/c2150000") end) then require("script/c2150000") end
function c2150001.initial_effect(c)
	local a=BiDiu(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	a:SetCode(EVENT_ADJUST)
	a:SetRange(LOCATION_MZONE)
	a:SetOperation(c2150001.opa)
	c:RegisterEffect(a)
end
function c2150001.opa(e,tp)
	g=Duel.GetOverlayGroup(tp,0,LOCATION_MZONE)
	Duel.GetMatchingGroup(BiDiuF,tp,LOCATION_MZONE,0,nil):ForEach(function(c)g:Merge(c:GetOverlayGroup())end)
	if g:GetCount()<1 then return end
	Duel.SendtoGrave(g,REASON_EFFECT)
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)-800*g:GetCount())
end
