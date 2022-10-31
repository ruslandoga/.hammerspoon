-- based on https://github.com/Hammerspoon/Spoons/blob/master/Source/PopupTranslateSelection.spoon/init.lua

local obj={}
obj.__index = obj

obj.name = "translate"
obj.version = "0.1.0"

obj.popup_size = hs.geometry.size(770, 600)
obj.popup_style = hs.webview.windowMasks.utility |
  hs.webview.windowMasks.HUD |
  hs.webview.windowMasks.titled |
  hs.webview.windowMasks.closable

obj.popup_close_on_escape = true
obj.logger = hs.logger.new('transate')

obj.webview = nil

function obj:translatePopup(text, to, from)
  local query = hs.http.encodeForQuery(text)
  local url = "https://translate.google.com/translate_t?" ..
    (from and ("sl=" .. from .. "&") or "") ..
    (to and ("tl=" .. to .. "&") or "") ..
    "text=" .. query
  
  if self.webview == nil then
    local rect = hs.geometry.rect(0, 0, self.popup_size.w, self.popup_size.h)
    -- rect.center = hs.screen.mainScreen():frame().center
    self.webview = hs.webview.new(rect)
      :allowTextEntry(true)
      :windowStyle(self.popup_style)
      :closeOnEscape(self.popup_close_on_escape)
  end

  self.webview:url(url):bringToFront():show()
  self.webview:hswindow():focus()
  return self
end

function current_selection()
  local elem = hs.uielement.focusedElement()
  local sel = nil
  
  if elem then
    sel = elem:selectedText()
  end

  if (not sel) or (sel == "") then
    hs.eventtap.keyStroke({"cmd"}, "c")
    hs.timer.usleep(20000)
    sel = hs.pasteboard.getContents()
  end

  return (sel or "")
end

function obj:translateSelectionPopup(to, from)
  local text = current_selection()
  return self:translatePopup(text, to, from)
end

return obj
