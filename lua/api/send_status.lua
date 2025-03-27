local data_memory = ngx.shared.game_data
local status = { item_stock = data_memory:get("item_stock") }
ngx.header.content_type = "application/json"
ngx.say(require("cjson").encode(status))
