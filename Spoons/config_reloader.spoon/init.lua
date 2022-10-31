-- based on https://github.com/Hammerspoon/Spoons/blob/master/Source/ReloadConfiguration.spoon/init.lua
local obj = {}
obj.__index = obj

obj.name = "config_reloader"
obj.version = "0.1.0"
obj.watch_paths = { hs.configdir }
obj.logger = hs.logger.new("config_reloader")

function obj:start()
  self.watches = {}
  
  for _, dir in pairs(self.watch_paths) do
    self.watches[dir] = hs.pathwatcher.new(dir, hs.reload):start()
  end

  return self
end

return obj

-- function reloadConfig(files)
--   doReload = false
--   for _, file in pairs(files) do
--     if file:sub(-4) == ".lua" then
--       doReload = true
--     end
--   end

--   if doReload then
--     hs.reload()
--   end
-- end

-- myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
