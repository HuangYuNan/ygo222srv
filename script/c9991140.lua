--遗迹噬体
require "expansions/script/c9990000"
function c9991140.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,nil,function(e,tp)
		local exg=Duel.GetFieldGroup(tp,0,LOCATION_REMOVED)
		if exg:GetCount()==0 or not Duel.SelectYesNo(tp,aux.Stringid(9991140,0)) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		exg=exg:Select(tp,1,1,nil)
		Duel.HintSelection(exg)
		Duel.SendtoGrave(exg,REASON_RETURN+REASON_RULE)
		Duel.Recover(tp,4000,REASON_RULE)
	end)
end