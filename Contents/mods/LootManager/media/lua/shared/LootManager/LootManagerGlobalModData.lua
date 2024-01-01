--- @class LootManagerModDataManager
--- @field x number
--- @field y number
--- @field z number
--- @field objectIndex number

--- @class LootManagerGlobalModData
--- @field managers table<string, LootManagerModDataManager>
--- @field managerLocations table<number, LootManagerModDataManager>

local modDataKey = 'LootManager'
local LootManagerModData = {}

---@return LootManagerGlobalModData
function LootManagerModData:get()
  local modData = ModData.getOrCreate(modDataKey)
  if not modData.managers then modData.managers = {} end
  if not modData.managerLocations then modData.managerLocations = {} end

  return modData
end

return LootManagerModData
