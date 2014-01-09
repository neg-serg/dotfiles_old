export STACK_BT="1"

function die ()
{
echo " *** FAIL *** $0: $1" 1>&2
if [[ "$STACK_BT" == "1" ]];
then
  echo "Stack trace:" 1>&2
  for (( i=1; i<${#FUNCNAME[@]}; i++ )); do
    echo "  ${FUNCNAME[$i]} (${BASH_SOURCE[$i]}:${BASH_LINENO[$i-1]})" 1>&2
  done;
fi;

exit 1;
};

# function chpwd { ls }
# function precmd { vcs_info; title "zsh" "%~" }
# function preexec { title "$1" }

