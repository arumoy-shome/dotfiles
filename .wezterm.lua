local wezterm = require 'wezterm';

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
    -- The following section defines my preferred keybindings.
    -- See
    -- https://wezfurlong.org/wezterm/config/keyboard-concepts.html
    -- for more details, we don't want this since it may interfere
    -- with vim.
    use_dead_keys = false,
    -- }}}

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

}

-- vim: foldmethod=marker
