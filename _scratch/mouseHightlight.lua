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
