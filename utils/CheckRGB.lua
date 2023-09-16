local function CheckRGB(r, g, b)
    if (r >= 255) then r = 255 end
    if (g >= 255) then g = 255 end
    if (b >= 255) then b = 255 end
    if (r <= 0) then r = 0 end
    if (g <= 0) then g = 0 end
    if (b <= 0) then b = 0 end

    return r, g, b
end

return CheckRGB