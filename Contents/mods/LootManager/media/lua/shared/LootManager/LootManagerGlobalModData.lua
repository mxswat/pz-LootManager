--- @class LootManagerModDataManager
--- @field x number
--- @field y number
--- @field z number
--- @field objectIndex number

--- @class LootManagerGlobalModData
--- @field managers table<string, LootManagerModDataManager>
--- @field managerCords table<number, table<number, table<number, string>>>

local modDataKey = 'LootManager'
local LootManagerModData = {}

---@return LootManagerGlobalModData
function LootManagerModData:get()
  local modData = ModData.getOrCreate(modDataKey)
  if not modData.managers then modData.managers = {} end
  if not modData.managerCords then
    modData.managerCords = {}
  end

  return modData
end

---@param cords LootManagerModDataManager
function LootManagerModData:addLootManager(cords)
  local moddata = self:get()

  local id = table.concat({ cords.x, cords.y, cords.z, cords.objectIndex }, '_')

  moddata.managers[id] = cords

  if not moddata.managerCords[cords.x] then
    moddata.managerCords[cords.x] = {}
  end

  if not moddata.managerCords[cords.x][cords.y] then
    moddata.managerCords[cords.x][cords.y] = {}
  end

  moddata.managerCords[cords.x][cords.y][cords.z] = id
end

---@param cords LootManagerModDataManager
function LootManagerModData:removeLootManager(cords)
  local moddata = self:get()

  local id = table.concat({ cords.x, cords.y, cords.z, cords.objectIndex }, '_')

  moddata.managers[id] = nil

  if moddata.managerCords[cords.x] and moddata.managerCords[cords.x][cords.y] then
    moddata.managerCords[cords.x][cords.y][cords.z] = nil
  end
end

function LootManagerModData:findLootManagersInRange(x, y, z, range)
  local moddata = self:get()
  local result = {}

  for i = x - range, x + range do
    for j = y - range, y + range do
      for k = z - range, z + range do
        if moddata.managerCords[i] and moddata.managerCords[i][j] and moddata.managerCords[i][j][k] then
          local id = moddata.managerCords[i][j][k]
          local manager = moddata.managers[id]
          table.insert(result, manager)
        end
      end
    end
  end

  return result
end

return LootManagerModData
