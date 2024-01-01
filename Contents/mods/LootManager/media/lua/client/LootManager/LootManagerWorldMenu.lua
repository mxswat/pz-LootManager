local Utils = require("MxUtilities/Utils")

---@class LootManagerWorldMenu
local LootManagerWorldMenu = {}

-- ISGeneratorInfoWindow

---@param player IsoPlayer
---@param context ISContextMenu
---@param worldObjects table
function LootManagerWorldMenu:renderEnableMenu(player, context, worldObjects)
  local lootManagerObject = Utils:findObjectByNameAndGroup(worldObjects, 'LootManager', 'Off')
  if not lootManagerObject then return end

  local text = getText("ContextMenu_EnableLootManager")
  local menuOption = context:addOption(text, self, function()
    local sq = lootManagerObject:getSquare()
    local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ(), objectIndex = lootManagerObject:getObjectIndex() }
    sendClientCommand("LootManagerCommands", "EnableLootManager", args);
  end);

  if not ISMoveableSpriteProps:objectNoContainerOrEmpty(lootManagerObject) then
    menuOption.notAvailable = true
    local tooltip = ISInventoryPaneContextMenu.addToolTip()
    tooltip.description = getText("ContextMenu_EmptyTheLootManager")
    return
  end
end

---@param playerIndex int
---@param context ISContextMenu
---@param worldObjects table
function LootManagerWorldMenu.renderMenu(playerIndex, context, worldObjects)
  local self = LootManagerWorldMenu
  local player = getSpecificPlayer(playerIndex)

  self:renderEnableMenu(player, context, worldObjects)
end

function LootManagerWorldMenu:init()
  Events.OnFillWorldObjectContextMenu.Add(LootManagerWorldMenu.renderMenu)
end

LootManagerWorldMenu:init()

return LootManagerWorldMenu
