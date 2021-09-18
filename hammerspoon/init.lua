local hyper = {"ctrl", "cmd", "alt", "shift"}
local terminalPrg = "iTerm"
local browserPrg = "Firefox"
local editorPrg = "Emacs"

-- reload config
hs.loadSpoon("ReloadConfiguration")

spoon.ReloadConfiguration:bindHotkeys({
  reloadConfiguration = {hyper, "r"}
})
spoon.ReloadConfiguration:start()

-- window manager
hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "k"},
  right = {hyper, "l"},
  down = {hyper, "j"},
  left = {hyper, "h"},
  fullscreen = {hyper, "f"}
})

-- send focused window to other desktop
hs.hotkey.bind(hyper, "o", function()
  -- Get the focused window, its window frame dimensions, its screen frame
  -- dimensions, and the next screen's frame dimensions.
  local focusedWindow = hs.window.focusedWindow()
  local focusedScreenFrame = focusedWindow:screen():frame()
  local nextScreenFrame = focusedWindow:screen():next():frame()
  local windowFrame = focusedWindow:frame()

  -- Calculate the coordinates of the window frame in the next screen and retain
  -- aspect ratio
  windowFrame.x = ((((windowFrame.x - focusedScreenFrame.x) /
  focusedScreenFrame.w) * nextScreenFrame.w) + nextScreenFrame.x)
  windowFrame.y = ((((windowFrame.y - focusedScreenFrame.y) / focusedScreenFrame.h) * nextScreenFrame.h) + nextScreenFrame.y)
  windowFrame.h = ((windowFrame.h / focusedScreenFrame.h) * nextScreenFrame.h)
  windowFrame.w = ((windowFrame.w / focusedScreenFrame.w) * nextScreenFrame.w)

  -- Set the focused window's new frame dimensions
  focusedWindow:setFrame(windowFrame)
end)

-- hotkey for terminal
hs.hotkey.bind(hyper, "Return", function()
  if hs.application.frontmostApplication():name() == editorPrg then
    hs.application.launchOrFocus(terminalPrg)
  else
    hs.application.launchOrFocus(editorPrg)
  end
end)

-- editor and browser 50-50 layout
hs.hotkey.bind(hyper, "1", function()
  local mainScreen = "Color LCD"
  local terminal = hs.application.find(terminalPrg)
  local browser = hs.application.find(browserPrg)
  local layout = {
    {terminal, nil, mainScreen, hs.layout.left50, nil, nil},
    {browser, nil, mainScreen, hs.layout.right50, nil, nil}
  }
  hs.layout.apply(layout)
end)
