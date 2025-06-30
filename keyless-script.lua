-- Wait until the game is fully loaded and the LocalPlayer is available
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Map of PlaceIds to corresponding script URLs
local scripts = {
    [126884695634066] = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/Garden-V2.lua",
}

-- Get the script URL for the current game
local url = scripts[game.PlaceId]

-- If a script URL exists for this PlaceId, try to load and execute it
if url then
    local success, response = pcall(game.HttpGet, game, url)
    if success and response then
        local loadedFunction, loadErr = loadstring(response)
        if loadedFunction then
            loadedFunction()
        else
            warn("Failed to load string: " .. tostring(loadErr))
        end
    else
        warn("HTTP Get failed: " .. tostring(response))
    end
else
    warn("No script found for this PlaceId: " .. tostring(game.PlaceId))
end
