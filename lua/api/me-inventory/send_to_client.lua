local items_name = ngx.shared.items_name
local items_displayName = ngx.shared.items_displayName
local items_amount = ngx.shared.items_amount

local inventory_table = {}
for _, key in ipairs(items_name:get_keys()) do
    if items_amount:get(key) ~= 0 then
        table.insert(inventory_table, {
            ["fingerprint"] = key,
            ["name"] = items_name:get(key),
            ["displayName"] = items_displayName:get(key),
            ["amount"] = items_amount:get(key) } )
    end
end
ngx.header.content_type = "application/json"
local json = require("cjson").encode(inventory_table)
ngx.say(json)
