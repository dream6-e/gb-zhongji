local apiUrl = "https://api.jnkie.com/api/v1/luascripts/public/276cd4cb477f56ce87ca10e60369a72d00058774fcd155acb1f2f90692278e47/download"
local scriptContent = game:HttpGet(apiUrl)
loadstring(scriptContent)()
