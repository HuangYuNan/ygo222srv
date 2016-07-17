--ENS·绯色月下、狂咲之绝
require "expansions/script/c57300000"
function c57310001.initial_effect(c)
	miyuki.ens(c,57310001)
	miyuki.neg(c,1,57310001,miyuki.serlcost,c57310001.con,miyuki.ensop(57310001))
end
function c57310001.con(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end