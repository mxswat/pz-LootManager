if isClient() then return end

local MxDebug = require "MxUtilities/MxDebug"

local LootManagerModData = require "LootManager/LootManagerModData"

local LootManagerCommands = {};

---@param spriteName string # the sprite name eg: `loot_manager_0`
---@return string # returns the sprite name with the last digit plus 4, wrapped between 0 and 7
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
  -- object:setSprite(spriteName) -- this only changes the square tile estetics, not the actual object, good to know
  local square = object:getSquare()
  square:transmitRemoveItemFromSquare(object)

  ISBrushToolTileCursor:create(square:getX(), square:getY(), square:getZ(), nil, spriteName)

  local id = table.concat({ square:getX(), square:getY(), square:getZ(), cords.objectIndex }, '_')

  LootManagerModData:get().managers[id] = cords
end

local onClientCommand = function(module, command, source, args)
  if module ~= 'LootManagerCommands' then return end

  if LootManagerCommands and LootManagerCommands[command] then
    MxDebug:print('LootManagerCommands', command, source, args)
    LootManagerCommands[command](source, args);
  end
end

Events.OnClientCommand.Add(onClientCommand);
