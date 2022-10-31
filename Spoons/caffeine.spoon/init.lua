-- based on https://github.com/Hammerspoon/Spoons/tree/master/Source/Caffeine.spoon

local obj = { __gc = true }
setmetatable(obj, obj)
obj.__gc = function(t)
  t:stop()
end

obj.name = "caffeine"
obj.version = "0.1.0"
obj.logger = hs.logger.new("caffeine")

obj.menuBarItem = nil

function obj:start()
  if self.menuBarItem then
    self:stop()
  end

  self.menuBarItem = hs.menubar.new()
  self.menuBarItem:setClickCallback(self.clicked)
  self.setDisplay(hs.caffeinate.get("displayIdle"))

  return self
end

function obj:stop()
  if self.menuBarItem then
    self.menuBarItem:delete()
  end

  self.menuBarItem = nil
  return self
end

function obj.setDisplay(state)
  if state then
    obj.menuBarItem:setTitle("awake")
  else
    obj.menuBarItem:setTitle("sleepy")
  end
end

function obj.clicked()
  obj.setDisplay(hs.caffeinate.toggle("displayIdle"))
end

function obj:setState(on)
  hs.caffeinate.set("displayIdle", on)
  obj.setDisplay(on)
end

return obj
