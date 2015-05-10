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
    bindkey -s "${index}" "cd ${jump_dirs[$index]}"
done
