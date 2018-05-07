function script.load(filename)
	script.directory = filename:match("^(.*/)")
	local env = script.env
	--local script = assert(loadfile(filename, "=" .. filename, env))
	local code, err = love.filesystem.load(filename)
	if code == null then
		error("Error loading file: " .. tostring(err))
	end
	local script = assert(load(string.dump(code), "=" .. filename, "bt", env))
	local obj = {
		env = env,
		script = coroutine.wrap(script)
	}

	return obj
end
