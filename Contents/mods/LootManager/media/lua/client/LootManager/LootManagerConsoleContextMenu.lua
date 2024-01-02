local Utils = require("MxUtilities/Utils")
local LootManagerConsoleModData = require("LootManager/LootManagerConsoleModData")

---@class LootManagerWorldMenu
local LootManagerConsoleContextMenu = {}

-- ISGeneratorInfoWindow

---@param lootManagerObject IsoObject
---@param context ISContextMenu
function LootManagerConsoleContextMenu:renderEnableMenu(lootManagerObject, context)
  local text = getText("ContextMenu_EnableLootManager")

  context:addOption(text, self, function()
    local sq = lootManagerObject:getSquare()
    local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ(), objectIndex = lootManagerObject:getObjectIndex() }
    sendClientCommand("LootManagerCommands", "EnableLootManager", args);
  end);
end

---@param lootManagerObject IsoObject
---@param context ISContextMenu
function LootManagerConsoleContextMenu:renderDisableMenu(lootManagerObject, context)
  local text = getText("ContextMenu_DisableLootManager")

  context:addOption(text, self, function()
    local sq = lootManagerObject:getSquare()
    local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ(), objectIndex = lootManagerObject:getObjectIndex() }
    sendClientCommand("LootManagerCommands", "DisableLootManager", args);
  end);
end

---@param playerIndex int
---@param context ISContextMenu
---@param worldObjects table
function LootManagerConsoleContextMenu.renderMenu(playerIndex, context, worldObjects)
  local self = LootManagerConsoleContextMenu
  local player = getSpecificPlayer(playerIndex)

  local lootManagerConsoleOff = Utils:findObjectByNameAndGroup(worldObjects, 'LootManager', 'Console')
  local lootManagerConsoleOn = Utils:findObjectByNameAndGroup(worldObjects, 'LootManager', 'Console On')

  if not lootManagerConsoleOff and not lootManagerConsoleOn then
    return
  end

  local menuOption = context:addOption(getText("ContextMenu_LootManagerSettings"), nil)
  local subMenuContext = ISContextMenu:getNew(context)
  context:addSubMenu(menuOption, subMenuContext)

  if lootManagerConsoleOff then
    self:renderEnableMenu(lootManagerConsoleOff, subMenuContext)
  end

  if lootManagerConsoleOn then
    self:renderDisableMenu(lootManagerConsoleOn, subMenuContext)
  end
end

Events.OnFillWorldObjectContextMenu.Add(LootManagerConsoleContextMenu.renderMenu)

return LootManagerConsoleContextMenu
