hs.loadSpoon("translate")

hs.hotkey.bind({"cmd"}, "g", function()
  spoon.translate:translateSelectionPopup("en", "")
end)

hs.loadSpoon("caffeine")
spoon.caffeine:start()

hs.loadSpoon("config_reloader")
spoon.config_reloader:start()

hs.loadSpoon("tyler")

hs.hotkey.bind({"cmd", "alt"}, "left", function()
  spoon.tyler:moveLeft()
end)

hs.hotkey.bind({"cmd", "alt"}, "right", function()
  spoon.tyler:moveRight()
end)

hs.hotkey.bind({"cmd", "alt"}, "return", function()
  spoon.tyler:maximize()
end)

hs.loadSpoon("animedoro")

hs.hotkey.bind({"cmd", "alt"}, "]", function()
  spoon.animedoro:start()
end)

hs.hotkey.bind({"cmd", "alt"}, "[", function()
  spoon.animedoro:pause()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "[", function()
  spoon.animedoro:stop()
end)

hs.hotkey.bind({"cmd", "alt"}, "/", function()
  spoon.animedoro:timeLeftPopup()
end)

-- TODO
-- hs.loadSpoon("location")
-- hs.loadSpoon("pastor")

-- simulates typing
hs.hotkey.bind({"cmd", "alt"}, "v", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

hs.hotkey.bind({"cmd", "alt"}, "c", function()
  hs.toggleConsole()
end)

hs.hotkey.bind({"cmd", "alt"}, "k", function()
  hs.console.clearConsole()
end)

hs.alert.show("hs started")
