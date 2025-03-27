ngx.req.read_body()
local body = ngx.req.get_body_data()
local data = require("cjson").decode(body)
local data_memory = ngx.shared.game_data
data_memory:set("item_stock",data.item_stock)

ngx.say("Data updated")
