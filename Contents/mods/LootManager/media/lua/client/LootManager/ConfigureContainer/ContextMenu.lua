local MxDebug = require "MxUtilities/MxDebug"
local getContainersFromContextWorldObjects = require "MxUtilities/Utils/getContainersFromContextWorldObjects"

---@param context ISContextMenu
---@return table, ISContextMenu
local function createMenu(context)
  local menuOption = context:addOption(getText("ContextMenu_ConfigureContainer"), nil)
  local subMenuContext = ISContextMenu:getNew(context)
  context:addSubMenu(menuOption, subMenuContext)
  return menuOption, subMenuContext
end

---@param playerIndex int
---@param context ISContextMenu
---@param worldObjects table
local function renderContextMenu(playerIndex, context, worldObjects)
  local containers = getContainersFromContextWorldObjects(worldObjects)

  if #containers == 0 then
    return
  end

  MxDebug:print('Containers#', #containers)

  local menuOption, menuContext = createMenu(context)

  for i, container in ipairs(containers) do
    
  end
end

Events.OnFillWorldObjectContextMenu.Add(renderContextMenu)
