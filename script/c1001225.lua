--阳炎级驱逐舰1号舰—阳炎
if not pcall(function() require("expansions/script/c1001252") end) then require("script/c1001252") end
function c1001225.initial_effect(c)
	colle.sum(c,1)
	colle.atkup(c,100)
	colle.cnb(c)
	colle.th(c)
	colle.defwd(c)
end
