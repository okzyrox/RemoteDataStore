local ds_settings = {}

ds_settings["serverIp"] = "SERVERIP:PORT"
ds_settings["serverKey"] = "SERVER API KEY" -- server validates from a list of api keys

ds_settings["gameId"] = game.GameId
ds_settings["isPrivateServer"] = game.PrivateServerId == "" and true or false

return ds_settings