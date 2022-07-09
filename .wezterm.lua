local wezterm = require 'wezterm';
local action = wezterm.action;

-- status bar {{{
-- Taken from https://wezfurlong.org/wezterm/config/lua/window/set_right_status.html
wezterm.on("update-right-status", function(window, pane)
  local date = wezterm.strftime("%a %Y %b(%m) %d %H:%M");

  window:set_right_status(wezterm.format({
      {Attribute={Italic=true}},
      {Attribute={Underline="Single"}},
      {Text=date},
  }));
end);
-- }}}

return {

    -- colors {{{
    -- The following settings control the visual looks. wezterm
    -- supports all iterm2 colorschemes. See
    -- https://github.com/mbadolato/iTerm2-Color-Schemes for list of
    -- all supported colorschemes.
    color_scheme = "Tomorrow Night",
    -- }}}

    -- scrollback {{{
    -- The following settings control the scrollback
    scrollback_lines = 3500,
    enable_scroll_bar = false,
    -- }}}

    -- keys {{{
    -- See
    -- https://wezfurlong.org/wezterm/config/keyboard-concepts.html
    -- for more details, we don't want this since it may interfere
    -- with vim.
    use_dead_keys = false,
    -- The following section defines my preferred keybindings in
    -- a tmux-esque manner. I keep the original keybindings for
    -- backward compatibility and to accomodate muscle memory.
    leader = {key="Space", mods="CTRL"},
    keys = {
	-- panes {{{
	{key="v", mods="LEADER", action=action.SplitHorizontal{domain="CurrentPaneDomain"}},
	{key="s", mods="LEADER", action=action.SplitVertical{domain="CurrentPaneDomain"}},
	{key="s", mods="LEADER|SHIFT", action=action.SplitPane{
	    direction="Down",
	    size={Percent=25},
	}},
	{key="x", mods="LEADER", action=action.CloseCurrentPane{confirm=false}},
	{key="z", mods="LEADER", action=action.TogglePaneZoomState},
	{key="h", mods="LEADER", action=action.ActivatePaneDirection("Left")},
	{key="j", mods="LEADER", action=action.ActivatePaneDirection("Down")},
	{key="k", mods="LEADER", action=action.ActivatePaneDirection("Up")},
	{key="l", mods="LEADER", action=action.ActivatePaneDirection("Right")},
	--- }}}
	-- tabs {{{
	{key="p", mods="LEADER", action=action.ActivateTabRelative(-1)},
	{key="n", mods="LEADER", action=action.ActivateTabRelative(1)},
	{key="c", mods="LEADER", action=action.SpawnTab("DefaultDomain")},
	{key="w", mods="LEADER", action=action.CloseCurrentTab{confirm=false}},
	{key="o", mods="LEADER", action=action.ActivateLastTab},
	-- }}}
	-- copy mode {{{
	{key="Return", mods="LEADER", action=action.ActivateCopyMode},
	{key=" ", mods="LEADER", action=action.QuickSelect},
	-- }}}
	-- shell integration {{{
	{key="UpArrow", mods="SHIFT", action=action.ScrollToPrompt(-1)},
	{key="DownArrow", mods="SHIFT", action=action.ScrollToPrompt(1)},
	-- }}}
    },
    -- }}}

    -- mouse {{{
    mouse_bindings = {
	{
	    event={Up={streak=1, button="Left"}},
	    mods="CMD",
	    action=action.OpenLinkAtMouseCursor,
	},
    },
    -- {{{

    -- font {{{
    font_size = 16,
    bold_brightens_ansi_colors = true, -- default
    adjust_window_size_when_changing_font_size = false,
    -- }}}

    -- tab bar {{{
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = false,
    tab_bar_at_bottom = true,
    -- }}}

    -- status bar {{{
    -- Update every 6000 milliseconds or 1 minute.
    status_update_interval = 6000,
    -- }}}

    -- panes {{{
    unzoom_on_switch_pane = true, -- default
    -- }}}

}

-- vim: foldmethod=marker
