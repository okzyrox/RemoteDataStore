local ds_settings = {}

ds_settings["serverIp"] = "127.0.0.1:5000"
ds_settings["serverKey"] = "EXAMPLEKEY1234" -- server validates from a list of api keys

ds_settings["gameId"] = game.GameId
ds_settings["isPrivateServer"] = game.PrivateServerId == "" and true or false

return ds_settings