local Utils = require("MxUtilities/Utils")
local LootManagerConsoleModData = require("LootManager/LootManagerConsoleModData")

---@class LootManagerWorldMenu
local EnableLootManagerMenu = {}

-- ISGeneratorInfoWindow

---@param lootManagerObject IsoObject
---@param context ISContextMenu
function EnableLootManagerMenu:renderEnableMenu(lootManagerObject, context)
  local text = getText("ContextMenu_EnableLootManager")
  local menuOption = context:addOption(text, self, function()
    local sq = lootManagerObject:getSquare()
    local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ(), objectIndex = lootManagerObject:getObjectIndex() }
    sendClientCommand("LootManagerCommands", "EnableLootManager", args);
  end);
end

---@param playerIndex int
---@param context ISContextMenu
---@param worldObjects table
function EnableLootManagerMenu.renderMenu(playerIndex, context, worldObjects)
  local self = EnableLootManagerMenu
  local player = getSpecificPlayer(playerIndex)

  local lootManagerObject = Utils:findObjectByNameAndGroup(worldObjects, 'LootManager', 'Console')
  
  if not lootManagerObject then return end
  
  local modData = LootManagerConsoleModData:get(lootManagerObject)
  
  if not modData.isEnabled then
    self:renderEnableMenu(lootManagerObject, context)
  end

  local lootManagerObject = Utils:findObjectByNameAndGroup(worldObjects, 'LootManager', 'Console On')
end

Events.OnFillWorldObjectContextMenu.Add(EnableLootManagerMenu.renderMenu)

return EnableLootManagerMenu
