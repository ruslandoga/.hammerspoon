hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.x = f.x + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function() 
  hs.reload()
end)

function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end

  if doReload then
    hs.reload()
  end
end

-- hs.loadSpoon("<name>")
-- spoon.<name>:start()

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
  if state then
    caffeine:setTitle("awake")
  else
    caffeine:setTitle("sleepy")
  end
end

function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
  caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

-- hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

mouseCircle = nil
mouseCircleTimer = nil

function mouseHighlight() 
  -- Delete an existing highlight if it exists
  if mouseCircle then
    mouseCircle:delete()
    if mouseCircleTimer then
      mouseCircleTimer:stop()
    end
  end

  -- get the current coordinates of the mouse pointer
  mousepoint = hs.mouse.absolutePosition()
  -- prepare the big red circle around the mouse pointer
  mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
  mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
  mouseCircle:setFill(false)
  mouseCircle:setStrokeWidth(5)
  mouseCircle:show()

  -- set a timer to delete the circle after 3 seconds
  mouseCircleTimer = hs.timer.doAfter(3, function()
    mouseCircle:delete()
    mouseCircle = nil
  end)
end

hs.hotkey.bind({"cmd", "alt", "shift"}, "D", mouseHighlight)

-- animedoro
animedoroTimer = nil
animedoroStartedAt = nil

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "A", function()
  if animedoroTimer then
    hs.notify.new({title="animedoro", informativeText="animedoro already on"}):send()
  else
    -- 45 minutes
    animedoroTimer = hs.timer.doAfter(60 * 45, function()
      hs.notify.new({title="Hammerspoon", informativeText="animedoro ended"}):send()
    end)
    
    hs.notify.new({title="Hammerspoon", informativeText="animedoro on"}):send()
  end
end)

hs.alert.show("Config loaded")
