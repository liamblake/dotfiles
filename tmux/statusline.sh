# Status bar for TMUX
# Originally stolen and adapted from akinsho
# https://github.com/akinsho/dotfiles/blob/main/tmux/tmux-status.conf

BACKGROUND_COLOR='#12151f'
INACTIVE_FG_COLOR='#5c6370'
ACTIVE_FG_COLOR='#fac863'

set-option -g status-style "bg=$BACKGROUND_COLOR"

# Status setup
set-option -g status on
set-option -g status-fg default
set -g status-justify left
set -g status-interval 1

# NOTE: these use nested conditionals and "," and "}" must be escaped
set -g @batt_remain_short 'true'

# Set the battery colours to match the other monitors
set -g @batt_color_charge_secondary_tier8 "[fg=@cpu_low_fg_color]"
set -g @batt_color_charge_secondary_tier7 @cpu_low_fg_color
set -g @batt_color_charge_secondary_tier6 @cpu_medium_fg_color
set -g @batt_color_charge_secondary_tier5 @cpu_medium_fg_color
set -g @batt_color_charge_secondary_tier4 @cpu_medium_fg_color
set -g @batt_color_charge_secondary_tier3 @cpu_high_fg_color
set -g @batt_color_charge_secondary_tier2 @cpu_high_fg_color
set -g @batt_color_charge_secondary_tier1 @cpu_high_fg_color

separator="#[fg=$INACTIVE_FG_COLOR]｜#[default]"

search_icon="#{?window_active,#{?window_zoomed_flag,#[fg=blue],},} "

pane_count="#{?window_active,#[fg=white#,noitalics](#{window_panes}),}"

status_items="#{?window_bell_flag,#[fg=red] ,}$search_icon"

battery="#[bold]BAT: #[default]#{battery_status_fg}#{battery_percentage}#[default]"

cpu="#[bold]CPU: #[default]#{cpu_fg_color}#{cpu_percentage}#[default]"

ram="#[bold]RAM: #[default]#{ram_fg_color}#{ram_percentage}#[default]"

set -g status-left-length 80
# Options -> ⧉ ❐
set -g status-left "#{?client_prefix,#[fg=#ffffff bg=#22252B],#[fg=#e5c07b]} #S "
set -g status-right-length 70
# alternate date format "%a %d %b"
set -g status-right "$separator $cpu  $ram  $battery $separator  #[fg=blue]%H:%M  #[default]%a %d %b "

set-window-option -g window-status-current-style "bold"
set-window-option -g window-status-current-format " #I: #[bold]#W $status_items"

# for some unknown reason this tmux section is being set to reverse from
# somewhere so we explictly remove it here
set-window-option -g window-status-style "fg=$INACTIVE_FG_COLOR dim"
# TODO: consider adding window name #{=20:window_name} if #T is empty
set-window-option -g window-status-format "#[none] #I: #W $status_items"
set-window-option -g window-status-separator "$separator"

# Set window notifications
set-option -g monitor-activity on
set-option -g visual-activity off
