if isClient() then return end

local MxDebug = require "MxUtilities/MxDebug"

local LootManagerGlobalModData = require "LootManager/LootManagerGlobalModData"

local LootManagerCommands = {};

---@param spriteName string # the sprite name eg: `loot_manager_0`
---@return string # returns the sprite name with the last digit plus 4, value is wrapped between 0 and 7
function LootManagerCommands.getOppositeStateSpriteName(spriteName)
  local lastDigit = tonumber(spriteName:sub(-1))

  return spriteName:sub(1, -2) .. (lastDigit + 4) % 8
end

---@param source IsoPlayer
---@param cords LootManagerModDataManager
function LootManagerCommands.EnableLootManager(source, cords)
  local gs = getCell():getGridSquare(cords.x, cords.y, cords.z)
  if not gs then return nil end

  local object = gs:getObjects():get(cords.objectIndex)
  if not object then return end

  local spriteName = LootManagerCommands.getOppositeStateSpriteName(object:getSprite():getName())
  -- this only changes the square tile estetics, not the actual object, good to know
  -- EDIT: I think it works when done server side like this
  object:setSprite(spriteName)

  LootManagerGlobalModData:addLootManager(cords)
end

---@param source IsoPlayer
---@param cords LootManagerModDataManager
function LootManagerCommands.DisableLootManager(source, cords)
  local gs = getCell():getGridSquare(cords.x, cords.y, cords.z)
  if not gs then return nil end

  local object = gs:getObjects():get(cords.objectIndex)
  if not object then return end

  local spriteName = LootManagerCommands.getOppositeStateSpriteName(object:getSprite():getName())
  object:setSprite(spriteName)

  LootManagerGlobalModData:removeLootManager(cords)
end

local onClientCommand = function(module, command, source, args)
  if module ~= 'LootManagerCommands' then return end

  if LootManagerCommands and LootManagerCommands[command] then
    MxDebug:print('LootManagerCommands', command, source, args)
    LootManagerCommands[command](source, args);
  end
end

Events.OnClientCommand.Add(onClientCommand);
