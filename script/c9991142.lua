--Desolation Twin
require "expansions/script/c9990000"
function c9991142.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,7,function(e,tp)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsPlayerCanSpecialSummonMonster(tp,9991100,0,0x4011,5000,5000,10,RACE_REPTILE,ATTRIBUTE_LIGHT) then
			local token=Duel.CreateToken(tp,9991100)
			Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
		end
	end)
end