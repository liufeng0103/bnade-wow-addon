local GOLD_ICON = "|TInterface\\MoneyFrame\\UI-GoldIcon:0|t"
local SILVER_ICON = "|TInterface\\MoneyFrame\\UI-SilverIcon:0|t"
local COPPER_ICON = "|TInterface\\MoneyFrame\\UI-CopperIcon:0|t"

local function MoneyToString(money)
	money = tonumber(money)
	local gold = floor(money / COPPER_PER_GOLD)
	local silver = floor((money % COPPER_PER_GOLD) / COPPER_PER_SILVER)
	local copper = floor(money % COPPER_PER_SILVER)
	local text = nil
	if gold > 0 then
		text = gold .. GOLD_ICON .. silver .. SILVER_ICON .. copper .. COPPER_ICON
	elseif silver > 0 then
		text = silver .. SILVER_ICON .. copper .. COPPER_ICON
	else 
		text = copper .. COPPER_ICON
	end
	return text
end
local function OnTooltipSetItem(self)
	local name, link = self:GetItem()
	if name then		
		local itemId = link:match("Hitem:(%d+)")
		local item = Bnade_data[tonumber(itemId)]
		if item then
			local price = item[1]
			local quantity = item[2]
			GameTooltip:AddLine("BNADE参考价格: " .. MoneyToString(price), 1, 1, 1)
			GameTooltip:AddLine("参考服务器数: " .. quantity .. "/170", 1, 1, 1)
		end		
	end	
end
GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
local updated = Bnade_data["updated"]
if updated then
	print("BNADE查看物品参考价格，数据更新时间: " .. updated)
end

