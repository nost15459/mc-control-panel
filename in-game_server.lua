ME_BRIDGE_PERIPH_NAME = "back"

local function get_ME_inventory(me_birdge)
    local item_list = me_birdge.listItems()
    local inventory_table = {}
    for i, e in ipairs(item_list) do
        table.insert(inventory_table, {
            ["fingerprint"] = e.fingerprint,
            ["name"] = e.name,
            ["displayName"] = e.displayName,
            ["amount"] = e.amount,
            
        })
    end
    return inventory_table
end

local function send_data_to_nginx(data)
    local payload = textutils.serializeJSON(data, { allow_repetitions = true })
    print("PAYLOAD:"..payload)
    -- response_if_fail is not necessarily available(i.e. it can be nil)
    local response_or_flag, reason_why_fail, response_if_fail = http.post{
        url = "http://localhost:8080/api/me-inventory/update-inventory",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#payload)
        },
        body = payload
    }

    if response_or_flag ~= nil then
        print("Data was sent successfully")
    else
        write("failed to send data")
        if response_if_fail ~= nil then
            code_num,  code_msg = response_if_fail.getResponseCode()
            write(", HTTP status:",code_num,"(",code_msg,")")
        end
        print("\nreason:",reason_why_fail,"\n")
    end



end

local me_bridge = peripheral.wrap(ME_BRIDGE_PERIPH_NAME)

while true do 
    local me_inventory = get_ME_inventory(me_bridge)
    send_data_to_nginx(me_inventory)
    os.sleep(1)
end
