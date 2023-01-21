local script = "https://raw.githubusercontent.com/Black-Mesas/cc-roomba/main/src/roomba.lua"
local download = "https://raw.githubusercontent.com/Black-Mesas/cc-roomba/main/src/download.lua"

shell.run("rm roomba.lua")
shell.run("rm download.lua")

shell.run("wget " .. script)
shell.run("wget " .. download)
