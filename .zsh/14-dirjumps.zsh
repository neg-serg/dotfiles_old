jump_dirs=( 
                ~/1st_level  
                ~/dw         
                ~/dev        
                ~/pic        
                ~/vid        
                ~/trash      
            )

for index in $(seq 1 $((${#jump_dirs[@]} )))
do
    # echo "jump_dir ${index} is ${jump_dirs[$index]}"
    bindkey -s "${index}" "cd ${jump_dirs[$index]}"
done
  
# function up-one-dir   { pushd .. > /dev/null; zle redisplay; zle -M `pwd` }
# function back-one-dir { popd     > /dev/null; zle redisplay; zle -M `pwd` }
# zle -N up-one-dir
# zle -N back-one-dir
