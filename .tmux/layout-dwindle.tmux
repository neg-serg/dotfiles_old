# binary space partitioned layouts (dwindle, spiral)
# https://sunaku.github.io/tmux-layout-dwindle.html
bind-key M-w run-shell 'tmux-layout-dwindle brhc && tmux-redraw-vim'
bind-key M-C-w run-shell 'tmux-layout-dwindle trhc && tmux-redraw-vim'
bind-key M-v run-shell 'tmux-layout-dwindle brvc && tmux-redraw-vim'
bind-key M-C-v run-shell 'tmux-layout-dwindle blvc && tmux-redraw-vim'
