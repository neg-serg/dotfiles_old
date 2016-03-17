function load_file(path)
    if type(path) == "string" then
        file_path=notion_path_..path..".lua"
        local f=io.open(file_path,"r")
        if f~=nil then 
            --file exists
            io.close(f)
            dofile(file_path)
        else 
            --file not exists
        end
    end
end

