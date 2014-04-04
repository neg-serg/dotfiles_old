#!/usr/bin/env zsh
## bindings in this file will override whatever is present in the
# default bindings. 
    zfm_bind_key "M-x" "zfm_views"
    zfm_bind_key "M-o" "settingsmenu"
    zfm_bind_key "M-s" "sortoptions"
    #zfm_bind_key "M-f" "filteroptions"
    zfm_bind_key "M-f" "visited_files"
    zfm_bind_key "F1" "print_help_keys"
    zfm_bind_key "F2" "zfm_goto_dir"
    zfm_bind_key "|" "zfm_filter_list"
    zfm_bind_key "C-e" "zfm_edit_pattern"
    zfm_bind_key "M-e" "zfm_exclude_pattern"
    zfm_bind_key "M-/" "zfm_ffind"
    zfm_bind_key "ML '" "visited_dirs"
    zfm_bind_key "M-d" "visited_dirs"
    #zfm_bind_key "C-x '" "visited_dirs"
    zfm_bind_key "ML v" "visited_files"
    zfm_bind_key "$ZFM_SIBLING_DIR_KEY" sibling_dir
    zfm_keymap+=(
        "/"    zfm_edit_regex
        "M-n"  zfm_next_page
        "SPACE"  zfm_next_page
        "M-p"  zfm_prev_page
        "Home" zfm_goto_start
        "End" zfm_goto_end
        "ML l" zfm_goto_line
        "M-m"  zfm_mark
        )



    ## movement related
    #
    zfm_bind_key "{" "zfm_go_top"
    zfm_bind_key "}" "zfm_go_bottom"
    zfm_bind_key "C-d" zfm_scroll_down
    zfm_bind_key "C-b" zfm_scroll_up
    zfm_bind_key "C-n" cursor_down
    zfm_bind_key "C-p" cursor_up
    zfm_bind_key 'ML \' "zfm_set_mode VIM"
    zfm_bind_key 'M-i' "zfm_set_mode INS"
    zfm_bind_key 'C-r' zfm_refresh
    zfm_bind_key 'ESCAPE' zfm_escape
    zfm_bind_key "BACKSPACE" zfm_bs
    zfm_bind_key "$ZFM_OPEN_FILES_KEY" zfm_selected_file_options

