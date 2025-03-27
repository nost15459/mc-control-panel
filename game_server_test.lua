local http = require("socket.http")
local json = require("cjson.safe")
local ltn12 = require("ltn12")

local function collect_game_data()
    return { item_stock = math.random(12) }
end

local function send_data_to_nginx(data)
    local payload = json.encode(data)
    local response = {}

    local result, status = http.request{
        url = "http://localhost:8080/api/update",
        method = "POST",
        headers = {
                ["Content-Type"] = "application/json",
                ["Content-Length"] = tostring(#payload)
        },
        source = ltn12.source.string(payload),
        sink = ltn12.sink.table(response)
    }

    if status == 200 then
        print("Data was sent successfully")
    else
        print("failed to send data, status:",status,"\npayload",payload)
    end
end

while true do
    local game_data = collect_game_data()
    send_data_to_nginx(game_data)
    os.execute("sleep 2")
end
