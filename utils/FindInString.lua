local function FindInString(str, value)
    return string.match(string.lower(str), string.lower(value)) == string.lower(value)
end

return FindInString