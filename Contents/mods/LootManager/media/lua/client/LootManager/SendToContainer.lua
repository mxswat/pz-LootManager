local MxDebug = require "MxUtilities/MxDebug"
local SendToContainerAction = require "LootManager/SendToContainerAction"

local dummyContainer = ItemContainer.new("dummyContainer", nil, nil, 10)

---@class SendToContainer: ISInventoryPaneContextMenu
local SendToContainer = {}

---@param itemsToMove table<number,InventoryItem>
---@param playerIdx number
function SendToContainer.sendItems(itemsToMove, playerIdx)
  local player = getSpecificPlayer(playerIdx)

  for _, item in ipairs(itemsToMove) do
    ISTimedActionQueue.add(SendToContainerAction:new(player, item, item:getContainer(), dummyContainer))
  end
end

Events.OnFillInventoryObjectContextMenu.Add(function(playerIndex, context, _items)
  ---@type table<number,InventoryItem>
  local items = ISInventoryPane.getActualItems(_items)

  if #items == 0 then return end

  MxDebug:print('#items', #items)

  if not items[1]:isInPlayerInventory() then return end

  context:addOption(getText("ContextMenu_SendToContainer"), items, SendToContainer.sendItems, playerIndex);
end)
