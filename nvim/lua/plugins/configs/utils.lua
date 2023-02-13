local utils = {}

-- conditionally require module (in case its not added to path)
local function prequire(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

utils.wk = {}
local wk = prequire("which-key")
function utils.wk.register(dict)
  return wk and wk.register(dict)
end

return utils
