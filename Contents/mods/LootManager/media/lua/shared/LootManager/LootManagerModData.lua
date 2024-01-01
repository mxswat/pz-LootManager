--- @class LootManagerModDataManager
--- @field x number
--- @field y number
--- @field z number
--- @field objectIndex number

--- @class LootManagerModData
--- @field managers table<string, LootManagerModDataManager>

local modDataKey = 'LootManager'
local LootManagerModData = {}

---@return LootManagerModData
function LootManagerModData:get()
  local modData = ModData.getOrCreate(modDataKey)
  if not modData.managers then modData.managers = {} end

  return modData
end

return LootManagerModData
