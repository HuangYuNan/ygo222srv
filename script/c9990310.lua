--ペルシャの結合獣騎兵
function c9990310.initial_effect(c)
	--Synchro
	aux.AddSynchroProcedure2(c,nil,c9990310.synfilter)
	c:EnableReviveLimit()
end
function c9990310.synfilter(c)
	return c:IsType(TYPE_FUSION) and c:GetLevel()>=5
end
