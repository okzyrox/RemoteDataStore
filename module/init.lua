-- Remote Datastore Module

-- Begin

-- Roblox Services

local HttpService = game:GetService("HttpService")

local module = {}
module.settings = require(script.settings) -- ?

local function serverIsUp()
    if HttpService.HttpEnabled == false then
        warn("Http has not been enabled for this experience. Enable it to use Remote Datastore")
        return false
    end

    local response
	local data

	pcall(function()
		response = HttpService:GetAsync(module.settings["serverIp"] .. "/hb")
		data = HttpService:JSONDecode(response)
	end)

	if not data then
        warn("No response from server. Is the server turned on?")
		return nil
	end

    if data["alive"] then
        return true
    else
        return "Server is down?"
    end
end

module.alive = serverIsUp()

function MakeRequest(request_type, location, headers, data)
    if request_type == nil then request_type = "GET" end
    
    assert(location ~= nil, "Location is nil")
    
    if headers == nil then headers = {} end
    headers["API_KEY"] = module.settings["serverKey"]

    if request_type == "GET" then
        return HttpService:GetAsync(location, headers)
    elseif request_type == "POST" then
        return HttpService:PostAsync(location, data, Enum.HttpContentType.ApplicationJson, headers)
    else
        return "Invalid request type"
    end
end

function module:GetDatastore(name)
    local datastore = {}
    datastore.path = module.settings["serverIp"] .. "/datastore/" .. name

    function datastore:GetAsync(key)
        local response
	    local data

        pcall(function()
            response = MakeRequest("GET", self.path .. "/get/" .. key, {})
            data = HttpService:JSONDecode(response)
        end)

        if not data then
            warn("No response from server. Is the server turned on?")
            return nil
        end

        if response == nil or data == nil then
            return nil
        else
            return data
        end
    end

    function datastore:SetAsync(key, value)
        local response
        
        pcall(function()
            response = MakeRequest("GET", self.path .. "/set/" .. key .. "/" .. value, {})
        end)
        
        return response
    end

    return datastore
end
