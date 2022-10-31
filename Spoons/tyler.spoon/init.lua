-- based on https://github.com/Hammerspoon/Spoons/blob/master/Source/WindowHalfsAndThirds.spoon/init.lua

local obj = {}
obj.__index = obj

obj.name = "tyler"
obj.version = "0.1.0"
obj.logger = hs.logger.new("tyler")

obj.use_frame_correctness = false
obj.animationDuration = 0
-- obj.clear_cache_after_seconds = 60

local function _setFC()
  obj._savedFC = hs.window.setFrameCorrectness
  obj._savedDuration = hs.window.animationDuration
  hs.window.setFrameCorrectness = obj.use_frame_correctness
  
  if obj.animationDuration ~= nil then
    hs.window.animationDuration = obj.animationDuration
  end 
end

local function _restoreFC()
  hs.window.setFrameCorrectness = obj._savedFC
  
  if obj.animationDuration ~= nil then
    hs.window.animationDuration = obj._savedDuration
  end
end

function obj:moveLeft()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h

  _setFrame(win, f)
end

function obj:moveRight()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h

  _setFrame(win, f)
end

function obj:maximize()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h

  _setFrame(win, f)
end

function _setFrame(win, f)
  _setFC()
  win:setFrame(f)
  _restoreFC()
end

return obj
