local hyper = {"ctrl", "cmd", "alt", "shift"}

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

-- reload
hs.hotkey.bind(hyper, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

-- watchers
function startSync(files)
  local gdrive = hs.application.find("Backup and Sync")

  if not gdrive then
    hs.application.launchOrFocus("Backup and Sync")
    -- wait for 5 minutes and then quit sync
    hs.timer.delayed.new(300, stopSync):start()
  end
end

function stopSync()
  hs.application.find("Backup and Sync"):kill()
end

local gdriveWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/Google Drive", startSync):start()
local orgWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/org", startSync):start()
local documentsWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/Documents", startSync):start()

-- hotkey for terminal
hs.hotkey.bind(hyper, "Return", function()
  hs.application.launchOrFocus("Kitty")
end)
