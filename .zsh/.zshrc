#--------------------------------
#                   ██          -
#                  ░██          -
#    ██████  ██████░██          -
#   ░░░░██  ██░░░░ ░██████      -
#      ██  ░░█████ ░██░░░██     -
#     ██    ░░░░░██░██  ░██     -
#    ██████ ██████ ░██  ░██     -
#   ░░░░░░ ░░░░░░  ░░   ░░      -
#                               -
#--------------------------------

export ZDOTDIR="${HOME}/.zsh" && local _zsh_home="${ZDOTDIR}"

local _zsh_files=(
    01-init                     03-exports                 
    03-helpers                  04-oldprompt               
    05-functions                06-alias                   
    11-open                     12-completion              
    12-vi_additions             13-bindkeys                
    20-autopair                 60-functional              
    81-completion_gen           89-vim-interation.plugin   
    92-history-substring-search 96-fzf                     
    98-syntax                   
)

for i in ${_zsh_files[@]}; do
    [[ -f ${_zsh_home}/${i}.zsh ]] && source ${_zsh_home}/${i}.zsh
done
