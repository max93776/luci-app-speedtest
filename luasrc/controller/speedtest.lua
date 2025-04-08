
module("luci.controller.speedtest", package.seeall)

function index()
    local page = entry({"admin", "network", "speedtest"}, template("speedtest"), _("Speedtest"), 100)
    page.dependent = true 
    entry({"admin", "network", "speedtest", "run"}, call("run_speedtest"), nil).leaf = true
end

function run_speedtest()
    local http = require("luci.http")
    local util = require("luci.util")
    local speedtest_mode = http.formvalue("speedtest_mode")
    local speedtest_mode_2 = http.formvalue("speedtest_mode_2")

    cmd = "iperf3 -c ..." -- insert your server here
    if speedtest_mode_2 == "1" then
	cmd = cmd .. " -R" 
    end
    cmd = cmd .. " -P " .. speedtest_mode .. " | tail -n 5"
    local handle = io.popen(cmd)
    
    if handle then
        local result = handle:read("*a")
        handle:close()
        
        if result and result ~= "" then
            http.prepare_content("application/json")
            http.write_json({status = "success", output = result})
        else
            http.prepare_content("application/json")
            http.write_json({status = "error", message = "Keine Ausgabe von iperf3 erhalten"})
        end
    else
        http.prepare_content("application/json")
        http.write_json({status = "error", message = "Fehler beim Ausfuehren von iperf3"})
    end
end

