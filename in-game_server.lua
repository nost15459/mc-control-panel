local function collect_game_data()
    return { item_stock = math.random(12) }
end

local function send_data_to_nginx(data)
    local payload = textutils.serializeJSON(data)
    
    -- response_if_fail is not necessarily available(i.e. it can be nil)
    local response_or_flag, reason_why_fail, response_if_fail = http.post{
        url = "http://localhost:8080/api/update",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#payload)
        },
        body = payload
    }

    if response_or_flag ~= nil then
        print("Data was sent successfully")
    else
        print("failed to send data")
        if response_if_fail ~= nil then
            code_num,  code_msg = response_if_fail.getResponseCode()
            print(",HTTP status:",code_num,"(",code_msg,")")
        end
        print("reason\n",reason_why_fail,"\n")
    end



end


while true do 
    local game_data = collect_game_data()
    send_data_to_nginx(game_data)
    os.sleep(2)
end
