local MxDebug = require "MxUtilities/MxDebug"

---@class SendToContainer: ISInventoryTransferAction
local SendToContainerAction = ISInventoryTransferAction:derive("SendToContainerAction");

function SendToContainerAction:transferItem()
  MxDebug:print('#SendToContainerAction', 'transferItem')
end

return SendToContainerAction