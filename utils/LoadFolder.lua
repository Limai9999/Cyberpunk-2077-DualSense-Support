local function LoadFolder(list, folder)
    for _, file in pairs(dir(folder)) do
        if file.type == "file" and file.name:match("%.lua$") then
            local name = file.name:match("(.+)%..+")
            list[name] = require(folder .. "/" .. name)
        end
    end
end

return LoadFolder
