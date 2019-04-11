local hyper = {"ctrl", "cmd", "alt", "shift"}

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "k"},
  right = {hyper, "l"},
  down = {hyper, "j"},
  left = {hyper, "h"},
  fullscreen = {hyper, "f"}
})

hs.hotkey.bind(hyper, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
