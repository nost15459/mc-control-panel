ngx.req.read_body()
local body = ngx.req.get_body_data()
local inventory_update = require("cjson").decode(body)

local items_name = ngx.shared.items_name
local items_displayName = ngx.shared.items_displayName
local items_amount = ngx.shared.items_amount

local item_exists = {}

for _, key in ipairs(items_name:get_keys()) do
    item_exists[key] = false
end

for _, item in ipairs(inventory_update) do
    local key = item.fingerprint
    
    item_exists[key] = true

    items_name:safe_set(key, item.name)
    items_displayName:safe_set(key, item.displayName)
    items_amount:safe_set(key, item.amount)
end

for key, exists in pairs(item_exists) do
    if not exists then
        items_amount:safe_set(key, 0)
        items_name:expire(key, 0.001)
        items_displayName:expire(key, 0.001)
        items_amount:expire(key, 0.001)
    end
end

items_name:flush_expired()
items_displayName:flush_expired()
items_amount:flush_expired()

ngx.say("Data updated")
