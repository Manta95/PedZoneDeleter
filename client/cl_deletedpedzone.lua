local areas = {
    { coords = vector3(-1095.872559, -833.806580, 37.695602), radius = 20.0 }, -- LSPD
    { coords = vector3(-1200.261597, -895.782166, 19.983397), radius = 10.0 }  -- Burgershot
}

local playerInArea = {}
for i = 1, #areas do
    playerInArea[i] = false
end

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i, area in ipairs(areas) do
            local coords = area.coords
            local radius = area.radius

            if #(playerCoords - coords) <= radius then
                if not playerInArea[i] then
                    ClearAreaOfPeds(coords.x, coords.y, coords.z, radius, 1)
                    playerInArea[i] = true
                end
            else
                if playerInArea[i] then
                    playerInArea[i] = false
                end
            end
        end

        Wait(1000)
    end
end)
