-- Remote Datastore Module

-- Begin

-- Roblox Services

local HttpService = game:GetService("HttpService")

local module = {}
module.settings = require(script.settings)

local function serverIsUp()
    if HttpService.HttpEnabled == false then
        warn("Http has not been enabled for this experience. Enable it to use Remote Datastore")
        return false
    end

    local response
	local data

	pcall(function()
		response = HttpService:GetAsync(module.settings["serverIp"])
		data = HttpService:JSONDecode(response)
	end)

	if not data then
        warn("No response from server. Is the server turned on?")
		return nil
	end

    if data["alive"] then
        return true
    end
end

module.alive = serverIsUp()

function MakeRequest(request_type, location, headers, data)
    if request_type == nil then request_type = "GET" end
    
    assert(location ~= nil, "Location is nil")
    
    if headers == nil then headers = {} end
    headers["API_KEY"] = module.settings["serverKey"]

    if data == nil then data = {} end

    if request_type == "GET" then
    end
end

function module:GetAsync(key)
    local headers = {}
    local data = {}
    if module.alive == true then
        MakeRequest("GET", "/storage/" .. module.settings["gameId"] .. "?key=" .. key)
    end
end
