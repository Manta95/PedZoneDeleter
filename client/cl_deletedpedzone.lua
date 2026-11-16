local areas = {
    { coords = vector3(-1095.872559, -833.806580, 37.695602), radius = 30.0 }, -- LSPD
    { coords = vector3(-1200.261597, -895.782166, 19.983397), radius = 10.0 },  -- Burgershot
    { coords = vector3(174.595566, 2790.008545, 46.111168), radius = 20.0 }    -- Méca Sandy SHore
}

local playerInArea = {}
for i = 1, #areas do
    playerInArea[i] = false
end

local POPTYPE_MISSION = 7 -- peds créés par un script (CreatePed), à épargner

local function RemovePedsInArea(coords, radius)
    local peds = GetGamePool('CPed')
    for i = 1, #peds do
        local ped = peds[i]
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) and GetEntityPopulationType(ped) ~= POPTYPE_MISSION then
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

        for i = 1, #areas do
            local coords = areas[i].coords
            local radius = areas[i].radius

            if #(playerCoords - coords) <= radius then
                if not playerInArea[i] then
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
