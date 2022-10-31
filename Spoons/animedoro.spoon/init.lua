-- based on https://github.com/Hammerspoon/Spoons/blob/master/Source/Cherry.spoon/init.lua

local obj = {}
obj.__index = obj

obj.name = "animedoro"
obj.version = "0.1.0"

obj.duration = 45
-- obj.sound = nil

function obj:init()
  self:reset()
end

function obj:reset()
  self.timeLeft = self.duration * 60
  self.timerRunning = false
end

function obj:renderTimeLeft()
  local minutes = math.floor(self.timeLeft / 60)
  local seconds = self.timeLeft - (minutes * 60)
  return string.format("%02d:%02d left", minutes, seconds)
end

function obj:timeLeftPopup()
  if self.timerRunning then
    local timeLeft = self:renderTimeLeft()
    hs.alert.show(timeLeft)
  else
    hs.alert.show("animedoro is off")
  end
end

function obj:tick()
  self.timeLeft = self.timeLeft - 1
  
  -- TODO sound
  if self.timeLeft <= 0 then
    self:reset()
    hs.alert.show("Zing zing!")
  end
end

function obj:start()
  if self.timerRunning then
    hs.alert.show("animedoro is already on")  
  else
    self.timerRunning = true
    self.timer = hs.timer.doWhile(
      function() return self.timerRunning end,
      function() self:tick() end,
      1
    )

    hs.alert.show("animedoro started")
  end
end

function obj:pause()
  if self.timerRunning then
    self.timerRunning = false
    local timeLeft = self:renderTimeLeft()
    hs.alert.show("animedoro paused, " .. timeLeft)
  else
    hs.alert.show("animedoro is off already")
  end
end

function obj:stop()
  local timeLeft = self:renderTimeLeft()
  self:reset()
  hs.alert.show("animedoro stopped, " .. timeLeft)
end

return obj
