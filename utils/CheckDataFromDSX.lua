local function CheckDataFromDSX()
    local file = io.open('config/dataFromDSX.json', 'r')
    if not file then return false end

    local data = file:read('*a')

    local jsonData = json.decode(data)
    if not jsonData then return false end

    file:close()

    return jsonData
end

return CheckDataFromDSX