# Status bar for TMUX
# Originally stolen and adapted from akinsho
# https://github.com/akinsho/dotfiles/blob/main/tmux/tmux-status.conf

BACKGROUND_COLOR='#2A2A37'
INACTIVE_FG_COLOR='#54546D'

set-option -g status-style "bg=$BACKGROUND_COLOR"

# Status setup
set-option -g status on
set-option -g status-fg default
set -g status-justify left
set -g status-interval 1

# Position
set -g status-position bottom

separator="#[fg=$INACTIVE_FG_COLOR]｜#[default]"
search_icon="#{?window_active,#{?window_zoomed_flag,#[fg=blue],},} "
pane_count="#{?window_active,#[fg=white#,noitalics](#{window_panes}),}"
status_items="#{?window_bell_flag,#[fg=red] ,}$search_icon"

# Most of the status bar is empty.
set -g status-left-length 80
set -g status-left ""
set -g status-right-length 70
set -g status-right ""

set-window-option -g window-status-current-style "bold"
set-window-option -g window-status-current-format " #I: #[bold]#W $status_items"

set-window-option -g window-status-style "fg=$INACTIVE_FG_COLOR dim"
set-window-option -g window-status-format "#[none] #I: #W $status_items"
set-window-option -g window-status-separator "$separator"

# Set window notifications
set-option -g visual-activity off
