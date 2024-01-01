local Utils = require "MxUtilities/Utils"
local MxDebug = require("MxUtilities/MxDebug ")

local modDataKey = 'LootManagerConsoleModData'
local LootManagerConsoleModData = {}

---@param object IsoObject
---@return LootManagerConsoleModData
function LootManagerConsoleModData:get(object)
  return Utils:getModDataWithDefault(object:getModData(), modDataKey, self:getDefault(object))
end

---@param object IsoObject
---@return LootManagerConsoleModData
function LootManagerConsoleModData:getDefault(object)
  --- @class LootManagerConsoleModData
  local result = {
    isEnabled = false,
  }
  return result
end

return LootManagerConsoleModData
