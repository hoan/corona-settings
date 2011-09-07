module(..., package.seeall)

function settings.set(key, value)
	_G.__settings[key] = value
	
	settings.save()
end

function settings.get(key)
	return _G.__settings[key]
end

function settings.save()
	local path = system.pathForFile("settings.json", system.DocumentsDirectory)
	local fh = io.open(path, "w")
	
	fh:write(json.encode(_G.__settings))
	fh:close()
end

function settings.load()
	local path = system.pathForFile("settings.json", system.DocumentsDirectory)
	local fh, reason = io.open(path, "r")

	if fh then
		-- read all contents of file into a string
		local contents = fh:read("*a")
		local data = json.decode(contents)
		
		_G.__settings = data

		print("Loaded settings")
	else
		print("Coulnd't load settings: " .. reason)
		
		_G.__settings = {}
	end
end
