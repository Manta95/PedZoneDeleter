local areas = {
    { coords = vector3(-1095.872559, -833.806580, 37.695602), radius = 30.0 }, -- LSPD
    { coords = vector3(-1200.261597, -895.782166, 19.983397), radius = 10.0 },  -- Burgershot
    { coords = vector3(811.48, -881.01, 33.04), radius = 10.0 }  -- Benny's

}

local playerInArea = {}

for i = 1, #areas do
    playerInArea[i] = false
end

-- Function to get all NPCs created into the zone
local function RemovePedsInArea(coords, radius)
    local peds = GetGamePool('CPed')
    for _, ped in ipairs(peds) do
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
            local pedCoords = GetEntityCoords(ped)
            if #(pedCoords - coords) <= radius then
                DeleteEntity(ped)
            end
        end
    end
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

                RemovePedsInArea(coords, radius)

            else
                if playerInArea[i] then
                    playerInArea[i] = false
                end
            end
        end

        Wait(1000)
    end
end)
